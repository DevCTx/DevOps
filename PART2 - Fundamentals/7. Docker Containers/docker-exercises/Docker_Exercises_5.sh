Exercise 5:

# SET A DROPLET ON DIGITAL OCEAN
# ubuntu-nexus-docker / 4 GB Memory / 80 GB Disk / FRA1 - Ubuntu 24.04 (LTS) x64

# SET A SSH ROOT ACCESS AND CONFIGURE ~/.ssh/config ON LOCAL
more ~/.ssh/config 
#Host nexus-docker-root
#  HostName 161.35.75.247
#  User root
#  IdentityFile ~/.ssh/digital_rsa

# SET THE FIREWALL ON THE DROPLET TO OPEN
# 22 TO SPECIFIC IP FOR SSH
# 3000 FOR REACT (per default)
# 7071 FOR AMAZON S3 (per default)
# 8080 FOR THE JS APP
# 8081 FOR NEXUS REPO MANAGER
# 8083 FOR PHPMYADMIN
# 8084 FOR DOCKER (see config) 

# CONNECT TO THE SERVER VIA SSH
ssh nexus-docker-root 

# UPDATE UBUNTU
root@ubuntu-nexus-docker:~# apt update

# INSTALL DOCKER
root@ubuntu-nexus-docker:~# apt install docker.io 

# CREATE A VOLUME FOR NEXUS
root@ubuntu-nexus-docker:~# docker volume create --name nexus-data

# RUN NEXUS REPO MANAGER AS CONTAINER AND IMPERATIVELY ADD PORT 8084
root@ubuntu-nexus-docker:~# docker run -d -p 8081:8081 -p 8084:8084 --name nexus -v nexus-data:/nexus-data sonatype/nexus3

# CHECK THE USE OF A nexus USER 
root@ubuntu-nexus-docker:~# docker exec -it nexus /bin/bash
bash-5.1$ whoami
#nexus

# GET ADMIN PASSWORD FOR NEXUS
bash-5.1$ cat /nexus-data/admin.password 
# 453ff59d-1912-4b69-8f6c-5422d72f7100

# CONNECTO TO THE SERVER ON 161.35.75.247:8081
# LOGIN admin:453ff59d-1912-4b69-8f6c-5422d72f7100 AND CHANGE THE PASSWORD

# CREATE A BLOB
# Settings > Repository > Blob Stores > Create Blob : my-blob

# CREATE DOCKER HOSTED REPOSITORY
# Settings > Repository > Repositories > Create Repository : docker-hosted
# Others Connections : HTTP : 8084
# Blob store : my-blob

# AUTORIZE AUTHENTICATION BY DOCKER TOKEN
# Settings > Security > Realms > Active Realms : Add Docker Bearer Token Realm

# CREATE ROLE FOR DOCKER HOSTED REPO MANAGEMENT
# Settings > Security > Roles > Type : Nexus role
# ID : nx-docker-hosted
# Applied privileges : 	nx-repository-view-docker-docker-hosted-*

# CREATE USER FOR DOCKER HOSTED REPO MANAGEMENT
# Settings > Security > Users > Create User
# ID : team1 / Team / One
# PWD : team1 / confirmed / active
# Role : nx-docker-hosted

# TEST LOCAL
curl -u 'team1:team1' -X GET 'http://161.35.75.247:8081/service/rest/v1/repositories'
#[ {
#  "name" : "docker-hosted",
#  "format" : "docker",
#  "type" : "hosted",
#  "url" : "http://161.35.75.247:8081/repository/docker-hosted",
#  "size" : 0,
#  "attributes" : { }
#} ]

# ADD THIS CODE INTO build.gradle OF THE JS-APP
//##### ADD THIS CODE TO AUTHORIZE PUBLISH COMMAND #####
//
apply plugin: 'maven-publish'

publishing {
    publications {
        create("maven", MavenPublication) {
            artifact("build/libs/${project.name}-$version.jar"){
                    extension 'jar'
            }
        }
    }

    repositories {
        maven {
            name 'nexus'
            url = uri(project.nexusUrl)
            allowInsecureProtocol = project.allowInsecureProtocol
            credentials {
                username = project.repoUser
                password = project.repoPassword
            }
        }
    }
}
//
//#########################

# CREATE gradle.properties FOR THE PROJECT VALUES
nexusUrl=http://161.35.75.247:8081/repository/docker-hosted
allowInsecureProtocol=true
repoUser=team1
repoPassword=team1

# NOW IT IS NECESSARY TO ACCEPT INSECURE REGISTRIES ON LOCAL AND ON THE VPS

# ON LOCAL :
# Go to the Settings > Docker Engine of Docker Desktop UI
# set insecure-registries into the docker deamon configuration with the IP and port.
#{
#  "builder": {
#    "gc": {
#      "defaultKeepStorage": "20GB",
#      "enabled": true
#    }
#  },
#  "experimental": false,
#  "insecure-registries": [
#    "142.93.96.38:8083",
#    "161.35.75.247:8084"   # ADD THIS LINE
#  ]
#}

# AND RESTART DOCKER ON LOCAL

# THEN ON THE DOCKER VPS
root@ubuntu-nexus-docker:~# vi /etc/docker/daemon.json 
{
  "insecure-registries":["161.35.75.247:8084"]
}
root@ubuntu-nexus-docker:~# docker stop nexus
#nexus
root@ubuntu-nexus-docker:~# sudo systemctl restart docker
root@ubuntu-nexus-docker:~# docker info | grep -A5 -i "Insecure Registries"
# Insecure Registries:
#  161.35.75.247:8084
root@ubuntu-nexus-docker:~# docker rm nexus
#nexus
# RESTART nexus WITH THE PORTS LINKED
root@ubuntu-nexus-docker:~# docker run -d \
  --name nexus \
  -p 8081:8081 \
  -p 8084:8084 \
  -v nexus-data:/nexus-data \
  sonatype/nexus3
#e4151fd7a6421ab8634c5ea7d7e03baa25d866410a65b800ab27c392fbd1c1b2
root@ubuntu-nexus-docker:~# docker ps
#CONTAINER ID   IMAGE             COMMAND                  CREATED         STATUS         PORTS                                                                                      NAMES
#e4151fd7a642   sonatype/nexus3   "/opt/sonatype/nexus…"   9 seconds ago   Up 9 seconds   0.0.0.0:8081->8081/tcp, [::]:8081->8081/tcp, 0.0.0.0:8084->8084/tcp, [::]:8084->8084/tcp   nexus

# LOGIN FROM THE VPS FOR REGISTRING THE CREDENTIALS
root@ubuntu-nexus-docker:~docker login 161.35.75.247:808484
Username: team1
Password: 
#
#WARNING! Your credentials are stored unencrypted in '/root/.docker/config.json'.
#Configure a credential helper to remove this warning. See
#https://docs.docker.com/go/credential-store/
#
#Login Succeeded
#
root@ubuntu-nexus-docker:~# exit
#logout
#
#Connection to 161.35.75.247 closed.

# THEN LOGIN FROM THE LOCAL PC
$ docker login 161.35.75.247:8084
#Username: team1
#Password: 
#Login Succeeded

# FINALY TAG THE JS APP TO USE THE PORT 8084
$ docker tag js-app:1.0 161.35.75.247:8084/js-app:1.0
$ docker images
#IMAGE                           ID             DISK USAGE   CONTENT SIZE   EXTRA
#161.35.75.247:8084/js-app:1.0   60c905d5ae19        686MB          222MB        
#js-app:1.0                      60c905d5ae19        686MB          222MB        
#mysql:9.6.0-oraclelinux9        db32c8ec843c       1.27GB          283MB    U   
#phpmyadmin:latest               ce66eefd0460        821MB          197MB    U   

$ docker push 161.35.75.247:8084/js-app:1.0
#The push refers to repository [161.35.75.247:8084/js-app]
#830b0f84c55d: Pushed 
#08798a439a3a: Pushed 
#1bbcf5688c19: Pushed 
#fd88562ce968: Pushed 
#b72c06c2c41e: Pushed 
#4f4fb700ef54: Pushed 
#d10f3ac7b458: Pushed 
#78395afbc5eb: Pushed 
#01d7766a2e4a: Pushed 
#1.0: digest: sha256:60c905d5ae191e2305e9ffa8ede034802e233184ebdd1c6cda3531d48deb8429 size: 856
#

# CHECK THE AVAILABILITY OF THE REPO
$ curl -u 'team1:team1' -X GET 'http://161.35.75.247:8081/service/rest/v1/components?repository=docker-hosted'
#{
#  "items" : [ {
#    "id" : "ZG9ja2VyLWhvc3RlZDo0ZjFiYmNkZA",
#    "repository" : "docker-hosted",
#    "format" : "docker",
#    "group" : "",
#    "name" : "js-app",
#    "version" : "1.0",
#    "assets" : [ {
#      "downloadUrl" : "http://161.35.75.247:8081/repository/docker-hosted/v2/js-app/manifests/1.0",
#      "path" : "/v2/js-app/manifests/1.0",
#      "id" : "ZG9ja2VyLWhvc3RlZDphMmEwMTBmMw",
#      "repository" : "docker-hosted",
#      "format" : "docker",
#      "checksum" : {
#        "sha1" : "275ebf84d51efbf4ee782bb0cc47b61302644a57",
#        "sha256" : "60c905d5ae191e2305e9ffa8ede034802e233184ebdd1c6cda3531d48deb8429"
#      },
#      "contentType" : "application/vnd.oci.image.index.v1+json",
#      "lastModified" : "2026-02-18T23:25:35.756+00:00",
#      "lastDownloaded" : "2026-02-18T23:27:43.199+00:00",
#      "uploader" : "team1",
#      "uploaderIp" : "88.173.128.66",
#      "fileSize" : 856,
#      "blobCreated" : "2026-02-18T23:25:35.758+00:00",
#      "blobStoreName" : "my-blob",
#      "docker" : { }
#    } ]
#  } ],
#  "continuationToken" : null
#}

































