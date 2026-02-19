Docker_Exercise 8

# FINALY, IT WILL BE BETTER TO GET A SPECIFIC USER FOR THE JS APP

root@ubuntu-nexus-docker:~/js-app#
docker compose down
docker rmi 161.35.75.247:8084/js-app:1.0 
docker rmi phpmyadmin:latest 
docker rmi mysql:9.6.0-oraclelinux9 
docker volume rm mysql-data
exit

# IN Dockerfile OF THE JS APP
FROM eclipse-temurin:17

RUN groupadd -r javauser && useradd -r -g javauser javauser

RUN mkdir -p /home/myapp

WORKDIR /home/myapp

COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar

RUN chown -R javauser:javauser /home/myapp

USER javauser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "js-app.jar"]


# BUILD THE APP
gradle build

# BUILD, TRANSFER AND DELETE THE IMAGE
docker build -t 161.35.75.247:8084/js-app:1.0 .
docker login 161.35.75.247:8084
docker push 161.35.75.247:8084/js-app:1.0
docker rmi 161.35.75.247:8084/js-app:1.0 
#[+] Building 12.8s (12/12) FINISHED                                                                                                                                                                                      docker:desktop-linux
# => [internal] load build definition from Dockerfile                                                                                                                                                                                     0.1s
# => => transferring dockerfile: 358B                                                                                                                                                                                                     0.0s
# => [internal] load metadata for docker.io/library/eclipse-temurin:17                                                                                                                                                                    1.5s
# => [auth] library/eclipse-temurin:pull token for registry-1.docker.io                                                                                                                                                                   0.0s
# => [internal] load .dockerignore                                                                                                                                                                                                        0.0s
# => => transferring context: 214B                                                                                                                                                                                                        0.0s
# => CACHED [1/6] FROM docker.io/library/eclipse-temurin:17@sha256:b624cb9175b71aaeb654dd9def666035332d5abf70318537c1a46e61564dbecd                                                                                                       0.1s
# => => resolve docker.io/library/eclipse-temurin:17@sha256:b624cb9175b71aaeb654dd9def666035332d5abf70318537c1a46e61564dbecd                                                                                                              0.1s
# => [internal] load build context                                                                                                                                                                                                        0.0s
# => => transferring context: 131B                                                                                                                                                                                                        0.0s
# => [2/6] RUN groupadd -r javauser && useradd -r -g javauser javauser                                                                                                                                                                    1.0s
# => [3/6] RUN mkdir -p /home/myapp                                                                                                                                                                                                       0.4s
# => [4/6] WORKDIR /home/myapp                                                                                                                                                                                                            0.1s
# => [5/6] COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar                                                                                                                                                         0.8s
# => [6/6] RUN chown -R javauser:javauser /home/myapp                                                                                                                                                                                     1.0s
# => exporting to image                                                                                                                                                                                                                   7.1s
# => => exporting layers                                                                                                                                                                                                                  5.3s
# => => exporting manifest sha256:8a2d48a7200c3d30de00e5a59e54f597f647c6da6f0f87ab03f6f34d4c1ba47a                                                                                                                                        0.1s
# => => exporting config sha256:afdf19d4e6e09825fb490b5cfd6638eac19052a80a3362bd3a5e409437cd40c5                                                                                                                                          0.0s
# => => exporting attestation manifest sha256:1a67d2f480a771cbc0e1adc491803a7ff3072844ee6a2a84c417330ab17f24c0                                                                                                                            0.1s
# => => exporting manifest list sha256:e4b30263dd110a58c3a56148e0fab8facc9fd535ba552807af25faf062582622                                                                                                                                   0.0s
# => => naming to 161.35.75.247:8084/js-app:1.0                                                                                                                                                                                           0.0s
# => => unpacking to 161.35.75.247:8084/js-app:1.0                                                                                                                                                                                        1.5s
#Authenticating with existing credentials... [Username: team1]
#
#i Info → To login with a different account, run 'docker logout' followed by 'docker login'
#
#
#Login Succeeded
#The push refers to repository [161.35.75.247:8084/js-app]
#dc63d1791e7d: Pushed 
#1bbcf5688c19: Layer already exists 
#cc7bf43440ac: Pushed 
#78395afbc5eb: Layer already exists 
#d10f3ac7b458: Layer already exists 
#fe9b8185e559: Pushed 
#a0d99d6d1b39: Pushed 
#4f4fb700ef54: Layer already exists 
#3d77918a1b39: Pushed 
#01d7766a2e4a: Layer already exists 
#fd88562ce968: Layer already exists 
#1.0: digest: sha256:e4b30263dd110a58c3a56148e0fab8facc9fd535ba552807af25faf062582622 size: 856
#Untagged: 161.35.75.247:8084/js-app:1.0
#Deleted: sha256:e4b30263dd110a58c3a56148e0fab8facc9fd535ba552807af25faf062582622


# IN THE docker-compose.yml ADD BUT THAT'S NOT REQUIRED
    js-app:
        image: 161.35.75.247:8084/js-app:1.0
        container_name: js-app
        user: "javauser"

# TRANSFER THE docker-compose FILE 
scp docker-compose.yml root@161.35.75.247:/root/js-app/

# RELAUNCH ALL THE CONTAINERS
ssh nexus-docker-root 
root@ubuntu-nexus-docker:~# cd js-app/
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
#a0d99d6d1b39: Pull complete
#fe9b8185e559: Pull complete
#4f4fb700ef54: Pull complete
#dc63d1791e7d: Pull complete
#cc7bf43440ac: Pull complete
#Digest: sha256:e4b30263dd110a58c3a56148e0fab8facc9fd535ba552807af25faf062582622
#Status: Downloaded newer image for 161.35.75.247:8084/js-app:1.0
#Creating mysql ... done
#Creating phpmyadmin ... done
#Creating js-app     ... done

root@ubuntu-nexus-docker:~/js-app# docker images
#REPOSITORY                  TAG                  IMAGE ID       CREATED         SIZE
#161.35.75.247:8084/js-app   1.0                  afdf19d4e6e0   2 minutes ago   474MB
#sonatype/nexus3             latest               9d8b132c1077   7 days ago      701MB
#mysql                       9.6.0-oraclelinux9   f66b7a288113   13 days ago     922MB
#phpmyadmin                  latest               ac0645b6953d   2 weeks ago     575MB

root@ubuntu-nexus-docker:~/js-app# docker ps -a
#CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS                    PORTS                                                                                      NAMES
#9026b40a26f9   161.35.75.247:8084/js-app:1.0   "java -jar js-app.jar"   13 seconds ago   Up 12 seconds             0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp                                                js-app
#e6f8f8b6eb2a   phpmyadmin                      "/docker-entrypoint.…"   33 seconds ago   Up 32 seconds             0.0.0.0:8083->80/tcp, [::]:8083->80/tcp                                                    phpmyadmin
#a2d0f5c57e53   mysql:9.6.0-oraclelinux9        "docker-entrypoint.s…"   33 seconds ago   Up 33 seconds (healthy)   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp, 33060/tcp                                     mysql
#e4151fd7a642   sonatype/nexus3                 "/opt/sonatype/nexus…"   19 hours ago     Up 19 hours               0.0.0.0:8081->8081/tcp, [::]:8081->8081/tcp, 0.0.0.0:8084->8084/tcp, [::]:8084->8084/tcp   nexus

root@ubuntu-nexus-docker:~/js-app# docker volume ls
#DRIVER    VOLUME NAME
#local     mysql-data
#local     nexus-data

root@ubuntu-nexus-docker:~/js-app# docker network ls
#NETWORK ID     NAME            DRIVER    SCOPE
#da93d195a062   bridge          bridge    local
#56fb9d0ecd97   host            host      local
#4491ce38a14a   mysql-network   bridge    local
#119337cca059   none            null      local

root@ubuntu-nexus-docker:~/js-app# docker logs js-app 
#
#  .   ____          _            __ _ _
# /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
#( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
# \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
#  '  |____| .__|_| |_|_| |_\__, | / / / /
# =========|_|==============|___/=/_/_/_/
#
# :: Spring Boot ::                (v3.5.5)
#
#2026-02-19T17:33:09.256Z  INFO 1 --- [           main] com.example.Application                  : Starting Application v1.0-SNAPSHOT using Java 17.0.18 with PID 1 (/home/myapp/js-app.jar started by javauser in /home/myapp)
#2026-02-19T17:33:09.262Z  INFO 1 --- [           main] com.example.Application                  : No active profile set, falling back to 1 default profile: "default"
#2026-02-19T17:33:11.295Z  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8080 (http)
#2026-02-19T17:33:11.320Z  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
#2026-02-19T17:33:11.320Z  INFO 1 --- [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.44]
#2026-02-19T17:33:11.371Z  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
#2026-02-19T17:33:11.373Z  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1936 ms
#2026-02-19T17:33:12.207Z  INFO 1 --- [           main] com.example.Application                  : Java app started
#2026-02-19T17:33:12.385Z  INFO 1 --- [           main] o.s.b.a.w.s.WelcomePageHandlerMapping    : Adding welcome page: class path resource [static/index.html]
#2026-02-19T17:33:12.929Z  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8080 (http) with context path '/'
#2026-02-19T17:33:12.990Z  INFO 1 --- [           main] com.example.Application                  : Started Application in 4.831 seconds (process running for 5.847)

root@ubuntu-nexus-docker:~/js-app# docker exec -it js-app /bin/bash
javauser@9026b40a26f9:/home/myapp$ pwd
#/home/myapp
javauser@9026b40a26f9:/home/myapp$ whoami
#javauser
exit


PENSER A SUPPRIMER LES SERVEURS SUR DIGITAL A LA FIN !!!
