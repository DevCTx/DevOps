Exercise 7

# CAREFUL localhost IS NOT RECOGNISED AS 127.0.0.1 BY THE JS APP
# SO THE JS APP DOES NOT DISPLAY ALL THE DESIRED INFORMATION

# FRONT END AND BACK END ON THE SAME SERVER SO NO NEED HOST

# index.html:
...
<script>
  // HOST must be the server IP or DNS name when app running on a server
  // and localhost when running locally
  // const HOST = "127.0.0.1";
...  
        // const response = await fetch(`http://${HOST}:8080/get-data`);
        const response = await fetch(`/get-data`);
...
        // const response = await fetch(`http://${HOST}:8080/update-roles`, {
        const response = await fetch(`/update-roles`, {
...


# NOW SECURE ALL ENVIRONMENT VARIABLES INTO SECRETS DIRECTORY

# MODIFY THE DatabaseConfig.java FILE TO GET ALL INFO FROM SECRET FILES

//    private String user = System.getenv("DB_USER");
//    private String password = System.getenv("DB_PWD");
//    private String serverName = System.getenv("DB_SERVER"); // db host name, like localhost without the port
//    private String dbName = System.getenv("DB_NAME");
    private final MysqlDataSource datasource;

    public DatabaseConfig() {
        String user = readSecret("/run/secrets/mysql_user");
        String password = readSecret("/run/secrets/mysql_password");
        String serverName = readSecret("/run/secrets/mysql_host_server");
        String dbName = readSecret("/run/secrets/mysql_database");

        datasource = new MysqlDataSource();
        datasource.setUser(user);
        datasource.setPassword(password);
        datasource.setServerName(serverName);
        datasource.setPort(3306); // default config
        datasource.setDatabaseName(dbName);
        datasource.setURL("jdbc:mysql://" + serverName + ":3306/" + dbName);
    }

    private String readSecret(String path) {
        try {
            return Files.readString(Path.of(path)).trim();
        } catch (Exception e) {
            throw new RuntimeException("Unable to read secret: " + path, e);
        }
    }

# REMOVE ENVIRONMENT VARIABLES OF JS APP INTO docker-compose.yml
    js-app: 
        environment:
            - DB_USER=${DB_USER}
            - DB_PWD=${DB_PWD}
            - DB_SERVER=${DB_SERVER}
            - DB_NAME=${DB_NAME}
# AND ADD THE SECRET VOLUME
        volumes:
            - ./secrets:/run/secrets:ro


# CLOSE AND DELETE ALL IMAGES
docker compose down
docker rmi 161.35.75.247:8084/js-app:1.0 
docker rmi phpmyadmin:latest 
docker rmi mysql:9.6.0-oraclelinux9 
docker volume rm mysql-data


# REBUILD THE APP
gradle build

# REBUILD THE IMAGE (with Dockerfile)
docker build -t 161.35.75.247:8084/js-app:1.0 .

# CHECK LOGIN TO NEXUS
docker login 161.35.75.247:8084

# RELOAD THE IMAGE TO NEXUS
docker push 161.35.75.247:8084/js-app:1.0

# DELETE AGAIN THE JS APP IMAGE TO TAKE IT FROM NEXUS
docker rmi 161.35.75.247:8084/js-app:1.0 

# RELAUNCH THE CONTAINERS 
docker compose up -d
#[+] up 44/44
# ✔ Image 161.35.75.247:8084/js-app:1.0 Pulled                                                                                                                                                                                            1.5ss
# ✔ Image mysql:9.6.0-oraclelinux9      Pulled                                                                                                                                                                                            82.7s
# ✔ Image phpmyadmin                    Pulled                                                                                                                                                                                            82.8s
# ✔ Network mysql-network               Created                                                                                                                                                                                           0.2s
# ✔ Container mysql                     Healthy                                                                                                                                                                                           15.8s
# ✔ Container phpmyadmin                Created                                                                                                                                                                                           0.9s
# ✔ Container js-app                    Created                                                                                                                                                                                           0.8s

# THE APP DISPLAYS NOW THE INFORMATION FROM DATABASE

# COPY THE docker-compose.yml TO THE SERVER ON ROOT
scp docker-compose.yml root@161.35.75.247:/root/js-app/
#docker-compose.yml                                                                                                                                                                                          100% 1586    57.1KB/s   00:00    

# CONNECT AND CHECK
ssh nexus-docker-root 
root@ubuntu-nexus-docker:~# cd js-app/
root@ubuntu-nexus-docker:~/js-app# ls -lag
#total 12
#drwxr-xr-x 2 root 4096 Feb 19 13:29 .
#drwx------ 6 root 4096 Feb 19 13:28 ..
#-rw-r--r-- 1 root 1586 Feb 19 15:07 docker-compose.yml

# CHECK VOLUME, NETWORK, IMAGES, PROCESSES
root@ubuntu-nexus-docker:~# docker volume ls
#DRIVER    VOLUME NAME
#local     nexus-data
root@ubuntu-nexus-docker:~# docker network ls
#NETWORK ID     NAME      DRIVER    SCOPE
#da93d195a062   bridge    bridge    local
#56fb9d0ecd97   host      host      local
#119337cca059   none      null      local
root@ubuntu-nexus-docker:~# docker images
#REPOSITORY        TAG       IMAGE ID       CREATED      SIZE
#sonatype/nexus3   latest    9d8b132c1077   7 days ago   701MB
root@ubuntu-nexus-docker:~# docker ps -a
#CONTAINER ID   IMAGE             COMMAND                  CREATED        STATUS        PORTS                                                                                      NAMES
#e4151fd7a642   sonatype/nexus3   "/opt/sonatype/nexus…"   18 hours ago   Up 18 hours   0.0.0.0:8081->8081/tcp, [::]:8081->8081/tcp, 0.0.0.0:8084->8084/tcp, [::]:8084->8084/tcp   nexus

# INSTALL docker-compose
root@ubuntu-nexus-docker:~/js-app# apt install docker-compose

# THEN RUN docker-compose 
root@ubuntu-nexus-docker:~/js-app# docker-compose up -d
#Creating network "mysql-network" with driver "bridge"
#Creating volume "mysql-data" with local driver
#Pulling mysql (mysql:9.6.0-oraclelinux9)...
#9.6.0-oraclelinux9: Pulling from library/mysql
#4f37333d1be6: Pull complete
#e5a384f12fc1: Pull complete
#7a3034072b44: Pull complete
#c07617e6f14b: Pull complete
#85e7dc27e1dd: Pull complete
#a5b1ba019080: Pull complete
#c3c2157be11c: Pull complete
#74e9390a4418: Pull complete
#93b95dea6553: Pull complete
#fe44c8bf49c1: Pull complete
#Digest: sha256:db32c8ec843c042a728efb0ac7aa814d6f010eaac8923e20ae0a849d09c5baf8
#Status: Downloaded newer image for mysql:9.6.0-oraclelinux9
#Pulling phpmyadmin (phpmyadmin:)...
#latest: Pulling from library/phpmyadmin
#0c8d55a45c0d: Pull complete
#615510a9094d: Pull complete
#e24598f8ce57: Pull complete
#db5c301a6945: Pull complete
#10ecd2cd73b5: Pull complete
#8cb331d7a7d9: Pull complete
#9046ed4332b7: Pull complete
#927120e36889: Pull complete
#64133ee529eb: Pull complete
#3670ec7d2246: Pull complete
#2e9fade0540e: Pull complete
#27e4a7ec2970: Pull complete
#16b69d6f3818: Pull complete
#4d8bc193e0d0: Pull complete
#4f4fb700ef54: Pull complete
#3ad4835a89ba: Pull complete
#5a1bb28bc9ba: Pull complete
#c4ea0cbd9c71: Pull complete
#ef080651cc47: Pull complete
#ea8c0fa16a32: Pull complete
#78097ce2d8df: Pull complete
#Digest: sha256:ce66eefd046088d7a7cc7f2595da08e2896e099b6613e5008e04243fcefc31f6
#Status: Downloaded newer image for phpmyadmin:latest
#Pulling js-app (161.35.75.247:8084/js-app:1.0)...
#1.0: Pulling from js-app
#01d7766a2e4a: Pull complete
#d10f3ac7b458: Pull complete
#1bbcf5688c19: Pull complete
#78395afbc5eb: Pull complete
#fd88562ce968: Pull complete
#b72c06c2c41e: Pull complete
#4f4fb700ef54: Pull complete
#1eed23cb7f6a: Pull complete
#Digest: sha256:a0102b51547f69936ae8594181cfcdcca0f0f6b982bf8d2654c1de1c97e08b42
#Status: Downloaded newer image for 161.35.75.247:8084/js-app:1.0
#Creating mysql ... done
#Creating phpmyadmin ... done
#Creating js-app     ... done

# CHECK VOLUME, NETWORK, IMAGES, PROCESSES
root@ubuntu-nexus-docker:~/js-app# docker images
#REPOSITORY                  TAG                  IMAGE ID       CREATED       SIZE
#161.35.75.247:8084/js-app   1.0                  b54c2995509c   2 hours ago   448MB
#sonatype/nexus3             latest               9d8b132c1077   7 days ago    701MB
#mysql                       9.6.0-oraclelinux9   f66b7a288113   13 days ago   922MB
#phpmyadmin                  latest               ac0645b6953d   2 weeks ago   575MB
root@ubuntu-nexus-docker:~/js-app# docker ps -a 
#CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS                   PORTS                                                                                      NAMES
#8afb084edaa0   161.35.75.247:8084/js-app:1.0   "java -jar js-app.jar"   2 minutes ago   Up 2 minutes             0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp                                                js-app
#6237948c1c3d   phpmyadmin                      "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes             0.0.0.0:8083->80/tcp, [::]:8083->80/tcp                                                    phpmyadmin
#ed495f0e8c3c   mysql:9.6.0-oraclelinux9        "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes (healthy)   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp, 33060/tcp                                     mysql
#e4151fd7a642   sonatype/nexus3                 "/opt/sonatype/nexus…"   18 hours ago    Up 18 hours              0.0.0.0:8081->8081/tcp, [::]:8081->8081/tcp, 0.0.0.0:8084->8084/tcp, [::]:8084->8084/tcp   nexus
root@ubuntu-nexus-docker:~/js-app# docker volume ls
#DRIVER    VOLUME NAME
#local     mysql-data
#local     nexus-data
root@ubuntu-nexus-docker:~/js-app# docker network ls
#NETWORK ID     NAME            DRIVER    SCOPE
#da93d195a062   bridge          bridge    local
#56fb9d0ecd97   host            host      local
#81d26e8ce036   mysql-network   bridge    local
#119337cca059   none            null      local
root@ubuntu-nexus-docker:~/js-app# 

# JS APP DISPLAYS NOW THE INFORMATION FROM DATABASE on 161.35.75.247:8080 
# PHMYADMIN IS ACCESSIBLE FROM root:password AND team1:team1



