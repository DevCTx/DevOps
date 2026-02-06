Exercise 1
cd /opt

# Download nexus
wget https://help.sonatype.com/en/download.html

# unzip untar nexus
tar -zxvf nexus-3.88.0-08-linux-x86_64.tar.gz

# set a nexus user
sudo useradd -r -m -d /opt/nexus -s /bin/bash nexus

# change file ownerships
chown -R nexus:nexus nexus-3.88.0-08
chown -R nexus:nexus sonatype-work

# change root to nexus user
su - nexus

# Config user in nexus config file
vim ~/opt/nexus-3.88.0-08/bin/nexus.rc
run_as_server="nexus"

# Set RAM config for Nexus
vim /opt/nexus/bin/nexus.vmoptions
# Modified to prevent Nexus from using all RAM
#-Xms2703m
#-Xmx2703m
-Xms2g
-Xmx2g
-XX:MaxDirectMemorySize=2g
#

# Then start nexus
/opt/nexus-3.88.0-08/bin/nexus start
Starting nexus

# Then set a password on first connection for admin



