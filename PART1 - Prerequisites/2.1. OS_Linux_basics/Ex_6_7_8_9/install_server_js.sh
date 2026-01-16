#!/bin/bash
# Automated deployment: creates isolated user, downloads Node.js app from S3, 
# configures environment variables (APP_ENV, DB_USER, DB_PWD, LOG_DIR), 
# download and starts server.js with logs in server.log in /home/my_app
# use : sudo ./install_server_js.sh logs 

set -e  # Should be at every bash begining : stop the script if error appears !

#echo "
#Prepare environment"
#sudo apt-get purge nodejs npm -y
#sudo apt-get autoremove -y
#sudo rm -rf /etc/apt/sources.list.d/nodesource.list
#sudo apt-get clean
#sudo rm -rf /var/lib/apt/lists/*
#sudo apt update
#
#echo "
#NodeJS, NPM, and Curl installation"
#curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
#sudo apt-get install -y nodejs curl

echo "Versions:"
node --version
npm --version
curl -V | head -n 1


# Exercise 9: Create a new user to run the application
NEW_USER="my_app"
# Create user if doesn't exist
if ! id "$NEW_USER" &>/dev/null; then
    echo "Creating user $NEW_USER"
    sudo useradd -m -s /bin/bash "$NEW_USER"
fi

USER_HOME=$(eval echo ~"$NEW_USER")
echo "User home: $USER_HOME"

echo "
Fixing ownership of $USER_HOME"
sudo chown -R "$NEW_USER":"$NEW_USER" "$USER_HOME"

# Set log directory (argument or default /tmp)
if [ -n "$1" ]; then
    LOG_DIR="$USER_HOME/$1"
else
    LOG_DIR="$USER_HOME/tmp"
fi

echo "
Create log directory with proper permissions"
runuser -l "$NEW_USER" -c "
mkdir -p '$LOG_DIR' && 
chown '$NEW_USER':'$NEW_USER' '$LOG_DIR'
"
echo "Log directory : $LOG_DIR"

echo "
Delete old files in $USER_HOME dir and install the new ones"
runuser -l "$NEW_USER" -c "
cd ~ &&
rm -rf bootcamp-node-envvars-project* package &&
curl -# -O https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz &&
tar -xzf bootcamp-node-envvars-project-1.0.0.tgz
"

echo "
Move into package directory and install npm dependencies"
runuser -l "$NEW_USER" -c "
cd ~/package
npm cache clean --force &&
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret 
export LOG_DIR='$LOG_DIR'
npm install 
"

# runuser set a session for the user and close it after
# meaning that env vars must be reinitiated

echo "
Launch the server from $USER_HOME directory"
NODE_PID=$(runuser -l "$NEW_USER" -c "
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret 
export LOG_DIR='$LOG_DIR'
cd ~/package &&
node server.js > '$LOG_DIR/server.log' 2>&1 &
echo \$!
")

echo "Wait for the server to start and extract the listening port"
sleep 2
SERVER_PORT=$(runuser -l "$NEW_USER" -c "
grep -m1 'listening' '$LOG_DIR/server.log' | awk -F 'port ' '{print \$2}' | awk -F '!' '{print \$1}'
")

echo "
Server listening on port ${SERVER_PORT:-unknown} (PID: ${NODE_PID:-unknown})"

# Display that NodeJS is running on a port
ss -ltnp | grep node || true    # true needed for "set -e" to end the script

