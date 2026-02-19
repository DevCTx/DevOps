Docker_Exercise 4

# CREATE docker-compose.yml INTO THE APP DIRECTORY :
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

    phpmyadmin:
        image: phpmyadmin
        container_name: phpmyadmin
        networks: 
            - "mysql-network"
        ports:
            - "8083:80"
        depends_on:
            - mysql
        environment:
            - PMA_HOST=mysql
            - PMA_PORT=3306
  
volumes:
    mysql-data:
        name: mysql-data
        driver: local

networks:
    mysql-network:
        name: mysql-network
        driver: bridge


# RUN THE CONTAINERS
docker compose up -d
#[+] up 4/4
# ✔ Network mysql-network Created                                                                                                                                                                                                          0.1s
# ✔ Volume mysql-data     Created                                                                                                                                                                                                          0.0s
# ✔ Container mysql       Created                                                                                                                                                                                                          0.3s
# ✔ Container phpmyadmin  Created                                                                                                                                                                                                          0.7s

docker network ls
#NETWORK ID     NAME            DRIVER    SCOPE
#7dbb579732f1   bridge          bridge    local
#7799956493f1   host            host      local
#8fba0c003a6e   mysql-network   bridge    local
#c5f6690ff042   none            null      local

docker volume ls
#DRIVER    VOLUME NAME
#...
#local     mysql-data

docker compose config
#name: docker-exercises
#services:
#  mysql:
#    container_name: mysql
#    environment:
#      MYSQL_DATABASE_FILE: /run/secrets/mysql_database
#      MYSQL_HOST_SERVER_FILE: /run/secrets/mysql_host_server
#      MYSQL_PASSWORD_FILE: /run/secrets/mysql_password
#      MYSQL_ROOT_PASSWORD_FILE: /run/secrets/mysql_root_password
#      MYSQL_USER_FILE: /run/secrets/mysql_user
#    image: mysql:9.6.0-oraclelinux9
#    networks:
#      mysql-network: null
#    ports:
#      - mode: ingress
#        target: 3306
#        published: "3306"
#        protocol: tcp
#    volumes:
#      - type: bind
#        source: /home/kkz/Documents/DevOps/PART2 - Fundamentals/7. Docker Containers/docker-exercises/secrets
#        target: /run/secrets
#        read_only: true
#        bind: {}
#      - type: volume
#        source: mysql-data
#        target: /var/lib/mysql
#        volume: {}
#  phpmyadmin:
#    container_name: phpmyadmin
#    depends_on:
#      mysql:
#        condition: service_started
#        required: true
#    environment:
#      PMA_HOST: mysql
#      PMA_PORT: "3306"
#    image: phpmyadmin
#    networks:
#      mysql-network: null
#    ports:
#      - mode: ingress
#        target: 80
#        published: "8083"
#        protocol: tcp
#networks:
#  mysql-network:
#    name: mysql-network
#    driver: bridge
#volumes:
#  mysql-data:
#    name: mysql-data
#    driver: local


# IN ANOTHER TERMINAL
java -jar build/libs/docker-exercises-project-1.0-SNAPSHOT.jar 


# AND BACK TO THE FIRST TERMINAL
# CHECK GET-DATA
curl http://127.0.0.1:8080/get-data
#[{"name":"Sarah","role":"Full stack developer"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]

# CHECK UPDATE-ROLES BY MAKING A CHANGE
curl -X POST http://127.0.0.curl -X POST http://127.0.0.1:8080/update-roles -H "Content-Type: application/json" -d '[{"name":"Sarah","role":"DevOps"}]'
#[{"name":"Sarah","role":"DevOps"}]

# CHECK CHANGE
curl http://127.0.0.1:8080/get-data
#[{"name":"Sarah","role":"DevOps"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]


# TURN OFF THE APP
docker compose down
#[+] down 3/3
# ✔ Container phpmyadmin  Removed                                                                                                                                                                                                          1.6s
# ✔ Container mysql       Removed                                                                                                                                                                                                          1.6s
# ✔ Network mysql-network Removed                                                                                                                                                                                                          0.7s
docker compose up -d
#[+] up 3/3
# ✔ Network mysql-network Created                                                                                                                                                                                                          0.1s
# ✔ Container mysql       Created                                                                                                                                                                                                          0.2s
# ✔ Container phpmyadmin  Created                                                                                                                                                                                                          0.6s

# TURN ON THE APP AND CHECK AGAIN INTO THE FIRST TERMINAL
curl http://127.0.0.1:8080/get-data
[{"name":"Sarah","role":"DevOps"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]kkz@kkz-NC-SF314-51-34C3:~/Documents/

# DATA ARE THE SAME THAN BEFORE
