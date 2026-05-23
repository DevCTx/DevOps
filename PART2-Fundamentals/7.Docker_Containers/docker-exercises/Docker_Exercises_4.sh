Docker_Exercise 4

# CREATE a Dockerfile for the java app
FROM eclipse-temurin:17

RUN mkdir -p /home/myapp

WORKDIR /home/myapp

COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "js-app.jar"]


# CREATE A .dockerignore file (exclude build except the needed js-app file)
build
!./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar
docker-compose.yml
Dockerfile
Docker_Exercises*
.cache
.dockerignore
.env
.git
.gitignore
.gradle
.md
secrets

# BUILD OF THE JS-APP 
docker build -t js-app:1.0 .
#[+] Building 21.1s (10/10) FINISHED                                                                                                                                                                                      docker:desktop-linux
# => [internal] load build definition from Dockerfile                                                                                                                                                                                     0.0s
# => => transferring dockerfile: 238B                                                                                                                                                                                                     0.0s
# => [internal] load metadata for docker.io/library/eclipse-temurin:17                                                                                                                                                                    2.3s
# => [auth] library/eclipse-temurin:pull token for registry-1.docker.io                                                                                                                                                                   0.0s
# => [internal] load .dockerignore                                                                                                                                                                                                        0.0s
# => => transferring context: 214B                                                                                                                                                                                                        0.0s
# => [1/4] FROM docker.io/library/eclipse-temurin:17@sha256:b624cb9175b71aaeb654dd9def666035332d5abf70318537c1a46e61564dbecd                                                                                                             11.6s
# => => resolve docker.io/library/eclipse-temurin:17@sha256:b624cb9175b71aaeb654dd9def666035332d5abf70318537c1a46e61564dbecd                                                                                                              0.1s
# => => sha256:fd88562ce968f9f2742decb2b41610942b1696ea2c5e3d23e5a6d4d60c881435 2.28kB / 2.28kB                                                                                                                                           0.4s
# => => sha256:78395afbc5ebce60b7dff0200af60f0f3df93dd724ebb8f148212ed7d9b243e7 159B / 159B                                                                                                                                               0.5s
# => => sha256:1bbcf5688c1943d868111317459775672c2eb59c07b04633f4653e36deaac799 145.63MB / 145.63MB                                                                                                                                       5.6s
# => => sha256:d10f3ac7b458bcc0853b8cddf5bb91d305f64732b5e46f7897402e9104a2b6c7 22.96MB / 22.96MB                                                                                                                                         1.7s
# => => extracting sha256:d10f3ac7b458bcc0853b8cddf5bb91d305f64732b5e46f7897402e9104a2b6c7                                                                                                                                                3.8s
# => => extracting sha256:1bbcf5688c1943d868111317459775672c2eb59c07b04633f4653e36deaac799                                                                                                                                                5.5s
# => => extracting sha256:78395afbc5ebce60b7dff0200af60f0f3df93dd724ebb8f148212ed7d9b243e7                                                                                                                                                0.0s
# => => extracting sha256:fd88562ce968f9f2742decb2b41610942b1696ea2c5e3d23e5a6d4d60c881435                                                                                                                                                0.0s
# => [internal] load build context                                                                                                                                                                                                        0.0s
# => => transferring context: 131B                                                                                                                                                                                                        0.0s
# => [2/4] RUN mkdir -p /home/myapp                                                                                                                                                                                                       0.9s
# => [3/4] WORKDIR /home/myapp                                                                                                                                                                                                            0.2s
# => [4/4] COPY ./build/libs/docker-exercises-project-1.0-SNAPSHOT.jar js-app.jar                                                                                                                                                         0.4s
# => exporting to image                                                                                                                                                                                                                   4.5s
# => => exporting layers                                                                                                                                                                                                                  3.6s
# => => exporting manifest sha256:d0ceba504d496bf782066f62dd3d54d7289af9103aa7cadc88bccfc18b44f59a                                                                                                                                        0.0s
# => => exporting config sha256:810c8ea1b9bd3dbb426f3192dfb3316455878dd979f63825b687f1ab4921f13e                                                                                                                                          0.0s
# => => exporting attestation manifest sha256:04d6d160aa4acae2759579ebd8784ca4e43d491b53e3d821c446e242fdd14811                                                                                                                            0.1s
# => => exporting manifest list sha256:60c905d5ae191e2305e9ffa8ede034802e233184ebdd1c6cda3531d48deb8429                                                                                                                                   0.1s
# => => naming to docker.io/library/js-app:1.0                                                                                                                                                                                            0.0s
# => => unpacking to docker.io/library/js-app:1.0                                                                                                                                                                                         0.6s

# CHECK THE IMAGES
docker images
#IMAGE                      ID             DISK USAGE   CONTENT SIZE   EXTRA
#js-app:1.0                 60c905d5ae19        686MB          222MB        
#mysql:9.6.0-oraclelinux9   db32c8ec843c       1.27GB          283MB    U   
#phpmyadmin:latest          ce66eefd0460        821MB          197MB    U   

# RUN THE JS-APP WITH THE HOST SERVER DEFINED AS mysql CAUSE DOCKER CAN NOT ACCESS 127.0.0.1
docker run --name js-app \
  --network mysql-network \
  -p 8080:8080 \
  -e DB_USER=$(cat ./secrets/mysql_user) \
  -e DB_PWD=$(cat ./secrets/mysql_password) \
  -e DB_SERVER=mysql \
  -e DB_NAME=$(cat ./secrets/mysql_database) \
  -d js-app:1.0 

# CHECK THE CONTAINERS
docker ps -a
#CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                                         NAMES
#eb150b642f0f   js-app:1.0                 "java -jar js-app.jar"   3 seconds ago    Up 2 seconds    0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp   js-app
#1cd494a98820   phpmyadmin                 "/docker-entrypoint.…"   11 minutes ago   Up 11 minutes   0.0.0.0:8083->80/tcp, [::]:8083->80/tcp       phpmyadmin
#f298e375338a   mysql:9.6.0-oraclelinux9   "docker-entrypoint.s…"   11 minutes ago   Up 11 minutes   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysql

# 127.0.0.1:8080 answers with js-app
# 127.0.0.1:8083 answers with phpmyadmin

# CHECK THE VOLUME
curl http://127.0.0.1:8080/get-data
[{"name":"Sarah","role":"DevOps"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]
# DATA ARE STILL UNCHANGED AND ACCESSIBLE


