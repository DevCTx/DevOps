Exercise 6

# ADD js-app TO THE docker-compose.yml
services:

    mysql:
        image: mysql:9.6.0-oraclelinux9
        container_name: mysql
        networks: 
            - "mysql-network"
        ports:
            - "3306:3306"
        volumes:
            - ./secrets:/run/secrets:ro
            - mysql-data:/var/lib/mysql
        environment:
            - MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password
            - MYSQL_USER_FILE=/run/secrets/mysql_user
            - MYSQL_PASSWORD_FILE=/run/secrets/mysql_password
            - MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server
            - MYSQL_DATABASE_FILE=/run/secrets/mysql_database
        healthcheck:
            test: [ "CMD", "mysqladmin", "ping", "-h", "localhost" ]
            interval: 10s
            timeout: 5s
            retries: 5

    phpmyadmin:
        image: phpmyadmin
        container_name: phpmyadmin
        networks: 
            - "mysql-network"
        ports:
            - "8083:80"
        depends_on:
            - mysql
        restart: always
        environment:
            - PMA_HOST_FILE=/run/secrets/mysql_host_server
            - PMA_PORT_FILE=/run/secrets/mysql_host_port
  
    js-app:
        image: 161.35.75.247:8084/js-app:1.0
        container_name: js-app
        networks:
            - "mysql-network"
        ports:
            - "8080:8080"
        depends_on:
            mysql:
                condition: service_healthy
        environment:
            - DB_USER=${DB_USER}
            - DB_PWD=${DB_PWD}
            - DB_SERVER=${DB_SERVER}
            - DB_NAME=${DB_NAME}

volumes:
    mysql-data:
        name: mysql-data
        driver: local

networks:
    mysql-network:
        name: mysql-network
        driver: bridge


# EXPORT THE VALUES IN LOCAL
export DB_SERVER=mysql
export DB_NAME=mydb
export DB_USER=team1
export DB_PWD=team1

#CHECK THE ENV
env | grep DB
#DB_USER=team1
#DB_NAME=mydb
#DB_SERVER=mysql
#DB_PWD=team1

# RUN THE DOCKER COMPOSE
$ docker images
#IMAGE   ID             DISK USAGE   CONTENT SIZE   EXTRA
$ docker ps -a
#CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
$ docker compose up -d
#[+] up 44/44
# ✔ Image 161.35.75.247:8084/js-app:1.0 Pulled                                                                                                                                                                                            1.6ss
# ✔ Image mysql:9.6.0-oraclelinux9      Pulled                                                                                                                                                                                            92.7s
# ✔ Image phpmyadmin                    Pulled                                                                                                                                                                                            68.5s
# ✔ Network mysql-network               Created                                                                                                                                                                                           0.1s
# ✔ Container mysql                     Healthy                                                                                                                                                                                           15.3s
# ✔ Container phpmyadmin                Created                                                                                                                                                                                           1.3s
# ✔ Container js-app                    Created                                                                                                                                                                                           0.5s
$ docker ps -a
#CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS                    PORTS                                         NAMES
#a73bc61ce1b6   phpmyadmin                      "/docker-entrypoint.…"   18 seconds ago   Up 15 seconds             0.0.0.0:8083->80/tcp, [::]:8083->80/tcp       phpmyadmin
#2fe8e04fe263   161.35.75.247:8084/js-app:1.0   "java -jar js-app.jar"   18 seconds ago   Up 4 seconds              0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp   js-app
#c44adbb33451   mysql:9.6.0-oraclelinux9        "docker-entrypoint.s…"   20 seconds ago   Up 16 seconds (healthy)   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysql

# CHECK on 127.0.0.1:8080 that the js-app is running
# CHECK on 127.0.0.1:8083 that phpmyadmin is running

# CHECK THE ACCES TO THE DATABASE BY js-app
$ curl http://127.0.0.1:8080/get-data
[{"name":"Sarah","role":"DevOps"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]





