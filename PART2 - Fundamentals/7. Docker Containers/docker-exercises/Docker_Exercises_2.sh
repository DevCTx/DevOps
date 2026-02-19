
# get the phpmyadmin from Docker Hub
# --link mysql:mysql allows to create a link between the container and the host to know the name mysql in both
# then mysql is used as server and 3306 is used as port
docker run --name phpmyadmin \
  -p 8080:80 \
  --link mysql:mysql
  -e PMA_HOST=mysql \
  -e PMA_PORT=3306 \
  -d phpmyadmin

# link is depreciated, it's 'better to create a specific docker network between the containers
docker network create mysql-network

docker run --name mysql \
  --network mysql-network \
  -p 3306:3306 \
  -v ./secrets:/run/secrets:ro \
  -e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password \
  -e MYSQL_USER_FILE=/run/secrets/mysql_user \
  -e MYSQL_PASSWORD_FILE=/run/secrets/mysql_password \
  -e MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server \
  -e MYSQL_DATABASE_FILE=/run/secrets/mysql_database \
  -d mysql:9.6.0-oraclelinux9 

docker run --name phpmyadmin \
  --network mysql-network \
  -p 8080:80 \
  -e PMA_HOST=mysql \
  -e PMA_PORT=3306 \
  -d phpmyadmin

# Go to http://127.0.0.1:8080 and set User:root / Password:password to access phpmyadmin on mysql.
