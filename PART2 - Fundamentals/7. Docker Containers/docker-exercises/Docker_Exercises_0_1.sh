Exercise 0 :

DatabaseConfig shows the use of 
DB_USER for user
DB_PWD for password
DB_SERVER for db host name, like localhost without the port
DB_NAME for db name
port 3306
URL = "jdbc:mysql://" + serverName + ":3306/" + dbName


Exercise 1 :

# -- GET MYSQL FROM DOCKER HUB ON LOCAL --
docker pull mysql:9.6.0-oraclelinux9
#9.6.0-oraclelinux9: Pulling from library/mysql
#fe44c8bf49c1: Pull complete 
#c3c2157be11c: Pull complete 
#e5a384f12fc1: Pull complete 
#74e9390a4418: Pull complete 
#a5b1ba019080: Pull complete 
#93b95dea6553: Pull complete 
#4f37333d1be6: Pull complete 
#7a3034072b44: Pull complete 
#c07617e6f14b: Pull complete 
#85e7dc27e1dd: Pull complete 
#cc8be4b9c0eb: Download complete 
#7e5a775ad22a: Download complete 
#Digest: sha256:db32c8ec843c042a728efb0ac7aa814d6f010eaac8923e20ae0a849d09c5baf8
#Status: Downloaded newer image for mysql:9.6.0-oraclelinux9
#docker.io/library/mysql:9.6.0-oraclelinux9

# -- VERIFY --
docker images
#IMAGE                      ID             DISK USAGE   CONTENT SIZE   EXTRA
#mysql:9.6.0-oraclelinux9   db32c8ec843c       1.27GB          283MB        

# -- RUN MYSQL IMAGE WITH SIMPLE ENV VARS (not secure) --
# CAREFUL : THEY MUST BE NAMED LIKE INDICATED INTO THE DOCS
docker run --name mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_USER=team1 \
  -e MYSQL_PASSWORD=team1 \
  -e MYSQL_HOST_SERVER=127.0.0.1 \
  -e MYSQL_DATABASE=mydb \
  -d mysql:9.6.0-oraclelinux9 
#2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2

# BUT LOCAL ENV VARS MUST BE LIKE INTO THE CODE
export DB_USER=team1
export DB_PWD=team1
export DB_SERVER=127.0.0.1
export DB_NAME=mydb

docker ps -a
#CONTAINER ID   IMAGE                      COMMAND                  CREATED         STATUS         PORTS                                         NAMES
#2a83fff00b0e   mysql:9.6.0-oraclelinux9   "docker-entrypoint.s…"   4 seconds ago   Up 3 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysql

docker inspect mysql
#[
#    {
#        "Id": "2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2",
#        "Created": "2026-02-17T10:59:31.178105201Z",
#        "Path": "docker-entrypoint.sh",
#        "Args": [
#            "mysqld"
#        ],
#        "State": {
#            "Status": "running",
#            "Running": true,
#            "Paused": false,
#            "Restarting": false,
#            "OOMKilled": false,
#            "Dead": false,
#            "Pid": 2742,
#            "ExitCode": 0,
#            "Error": "",
#            "StartedAt": "2026-02-17T10:59:31.380574322Z",
#            "FinishedAt": "0001-01-01T00:00:00Z"
#        },
#        "Image": "sha256:db32c8ec843c042a728efb0ac7aa814d6f010eaac8923e20ae0a849d09c5baf8",
#        "ResolvConfPath": "/var/lib/docker/containers/2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2/resolv.conf",
#        "HostnamePath": "/var/lib/docker/containers/2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2/hostname",
#        "HostsPath": "/var/lib/docker/containers/2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2/hosts",
#        "LogPath": "/var/lib/docker/containers/2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2/2a83fff00b0e3e524780d9cee07b90f44ccbf8cbabebbe60f30f914db62d23e2-json.log",
#        "Name": "/mydb",
#        "RestartCount": 0,
#        "Driver": "overlayfs",
#        "Platform": "linux",
#        "MountLabel": "",
#        "ProcessLabel": "",
#        "AppArmorProfile": "",
#        "ExecIDs": null,
#        "HostConfig": {
#            "Binds": null,
#            "ContainerIDFile": "",
#            "LogConfig": {
#                "Type": "json-file",
#                "Config": {}
#            },
#            "NetworkMode": "bridge",
#            "PortBindings": {
#                "3306/tcp": [
#                    {
#                        "HostIp": "",
#                        "HostPort": "3306"
#                    }
#                ]
#            },
#            "RestartPolicy": {
#                "Name": "no",
#                "MaximumRetryCount": 0
#            },
#            "AutoRemove": false,
#            "VolumeDriver": "",
#            "VolumesFrom": null,
#            "ConsoleSize": [
#                59,
#                238
#            ],
#            "CapAdd": null,
#            "CapDrop": null,
#            "CgroupnsMode": "private",
#            "Dns": null,
#            "DnsOptions": [],
#            "DnsSearch": [],
#            "ExtraHosts": null,
#            "GroupAdd": null,
#            "IpcMode": "private",
#            "Cgroup": "",
#            "Links": null,
#            "OomScoreAdj": 0,
#            "PidMode": "",
#            "Privileged": false,
#            "PublishAllPorts": false,
#            "ReadonlyRootfs": false,
#            "SecurityOpt": null,
#            "UTSMode": "",
#            "UsernsMode": "",
#            "ShmSize": 67108864,
#            "Runtime": "runc",
#            "Isolation": "",
#            "CpuShares": 0,
#            "Memory": 0,
#            "NanoCpus": 0,
#            "CgroupParent": "",
#            "BlkioWeight": 0,
#            "BlkioWeightDevice": [],
#            "BlkioDeviceReadBps": [],
#            "BlkioDeviceWriteBps": [],
#            "BlkioDeviceReadIOps": [],
#            "BlkioDeviceWriteIOps": [],
#            "CpuPeriod": 0,
#            "CpuQuota": 0,
#            "CpuRealtimePeriod": 0,
#            "CpuRealtimeRuntime": 0,
#            "CpusetCpus": "",
#            "CpusetMems": "",
#            "Devices": [],
#            "DeviceCgroupRules": null,
#            "DeviceRequests": null,
#            "MemoryReservation": 0,
#            "MemorySwap": 0,
#            "MemorySwappiness": null,
#            "OomKillDisable": null,
#            "PidsLimit": null,
#            "Ulimits": [],
#            "CpuCount": 0,
#            "CpuPercent": 0,
#            "IOMaximumIOps": 0,
#            "IOMaximumBandwidth": 0,
#            "MaskedPaths": [
#                "/proc/acpi",
#                "/proc/asound",
#                "/proc/interrupts",
#                "/proc/kcore",
#                "/proc/keys",
#                "/proc/latency_stats",
#                "/proc/sched_debug",
#                "/proc/scsi",
#                "/proc/timer_list",
#                "/proc/timer_stats",
#                "/sys/devices/virtual/powercap",
#                "/sys/firmware"
#            ],
#            "ReadonlyPaths": [
#                "/proc/bus",
#                "/proc/fs",
#                "/proc/irq",
#                "/proc/sys",
#                "/proc/sysrq-trigger"
#            ]
#        },
#        "Storage": {
#            "RootFS": {
#                "Snapshot": {
#                    "Name": "overlayfs"
#                }
#            }
#        },
#        "Mounts": [
#            {
#                "Type": "volume",
#                "Name": "3fad4fcb930f67c9802420860272d2188eea026c9befdaa491ab59d3d11f5d0e",
#                "Source": "/var/lib/docker/volumes/3fad4fcb930f67c9802420860272d2188eea026c9befdaa491ab59d3d11f5d0e/_data",
#                "Destination": "/var/lib/mysql",
#                "Driver": "local",
#                "Mode": "",
#                "RW": true,
#                "Propagation": ""
#            }
#        ],
#        "Config": {
#            "Hostname": "2a83fff00b0e",
#            "Domainname": "",
#            "User": "",
#            "AttachStdin": false,
#            "AttachStdout": false,
#            "AttachStderr": false,
#            "ExposedPorts": {
#                "3306/tcp": {},
#                "33060/tcp": {}
#            },
#            "Tty": false,
#            "OpenStdin": false,
#            "StdinOnce": false,
#            "Env": [
#                "MYSQL_USER=team1",
#                "MYSQL_PASSWORD=team1",
#                "MYSQL_HOST_SERVER=127.0.0.1",
#                "MYSQL_DATABASE=mydb",
#                "MYSQL_ROOT_PASSWORD=password",
#                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#                "GOSU_VERSION=1.19",
#                "MYSQL_MAJOR=innovation",
#                "MYSQL_VERSION=9.6.0-1.el9",
#                "MYSQL_SHELL_VERSION=9.6.0-1.el9"
#            ],
#            "Cmd": [
#                "mysqld"
#            ],
#            "Image": "mysql:9.6.0-oraclelinux9",
#            "Volumes": {
#                "/var/lib/mysql": {}
#            },
#            "WorkingDir": "/",
#            "Entrypoint": [
#                "docker-entrypoint.sh"
#            ],
#            "Labels": {},
#            "StopTimeout": 1
#        },
#        "NetworkSettings": {
#            "SandboxID": "d1ecf63b9bc3ac9f3b1cf87a14dec7409e42e4a988db36fb15342867012c043a",
#            "SandboxKey": "/var/run/docker/netns/d1ecf63b9bc3",
#            "Ports": {
#                "3306/tcp": [
#                    {
#                        "HostIp": "0.0.0.0",
#                        "HostPort": "3306"
#                    },
#                    {
#                        "HostIp": "::",
#                        "HostPort": "3306"
#                    }
#                ]
#            },
#            "Networks": {
#                "bridge": {
#                    "IPAMConfig": null,
#                    "Links": null,
#                    "Aliases": null,
#                    "DriverOpts": null,
#                    "GwPriority": 0,
#                    "NetworkID": "09e33be8ab289b3c654e460395ffa01541eaca5367fbb157ac3687bfdc3b2c3d",
#                    "EndpointID": "fffd5a31922c0d361ec2699bd714c7c1cb3b273bf7bc2c23a9f100b2535de867",
#                    "Gateway": "172.17.0.1",
#                    "IPAddress": "172.17.0.2",
#                    "MacAddress": "6e:fc:19:12:fb:7e",
#                    "IPPrefixLen": 16,
#                    "IPv6Gateway": "",
#                    "GlobalIPv6Address": "",
#                    "GlobalIPv6PrefixLen": 0,
#                    "DNSNames": null
#                }
#            }
#        },
#        "ImageManifestDescriptor": {
#            "mediaType": "application/vnd.oci.image.manifest.v1+json",
#            "digest": "sha256:717d1e4b2352def1f05b40c3c16c470b57f320112a32e506d4548f9964853304",
#            "size": 2863,
#            "annotations": {
#                "com.docker.official-images.bashbrew.arch": "amd64",
#                "org.opencontainers.image.base.digest": "sha256:f480e42968c8a382785bae3fd6c1b2372770f31389a599b1cbcf04f04eb2831a",
#                "org.opencontainers.image.base.name": "oraclelinux:9-slim",
#                "org.opencontainers.image.created": "2026-02-05T22:08:13Z",
#                "org.opencontainers.image.revision": "f8c2facfccdc3c8b8b2c9b5a6aec31db3115105b",
#                "org.opencontainers.image.source": "https://github.com/docker-library/mysql.git#f8c2facfccdc3c8b8b2c9b5a6aec31db3115105b:innovation",
#                "org.opencontainers.image.url": "https://hub.docker.com/_/mysql",
#                "org.opencontainers.image.version": "9.6.0"
#            },
#            "platform": {
#                "architecture": "amd64",
#                "os": "linux"
#            }
#        }
#    }
#]

docker exec -it mysql /bin/bash
bash-5.1# env
#MYSQL_MAJOR=innovation
#HOSTNAME=013ed3998a3a
#MYSQL_HOST_SERVER=127.0.0.1
#PWD=/
#MYSQL_ROOT_PASSWORD=password
#MYSQL_PASSWORD=team1
#MYSQL_USER=team1
#HOME=/root
#MYSQL_VERSION=9.6.0-1.el9
#GOSU_VERSION=1.19
#TERM=xterm
#SHLVL=1
#MYSQL_DATABASE=mydb
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#MYSQL_SHELL_VERSION=9.6.0-1.el9
#_=/usr/bin/env
bash-5.1# exit
#exit

env | grep DB
DB_USER=team1
DB_PWD=team1
DB_SERVER=127.0.0.1
DB_NAME=mydb


# -- OR DEFINE SECRETS --

# PREPARE THE FILES INTO A "secrets" DIRECTORY
mkdir ./secrets
echo "password" > ./secrets/mysql_root_password
echo "team1" > ./secrets/mysql_user
echo "team1" > ./secrets/mysql_password
echo "127.0.0.1" > ./secrets/mysql_host_server
echo "mydb" > ./secrets/mysql_database
chmod 600 ./secrets/*

# EXPORT THE DATA AS ENV VARS
export MYSQL_ROOT_PASSWORD=$(cat ./secrets/mysql_root_password)
export DB_USER=$(cat ./secrets/mysql_user)
export DB_PWD=$(cat ./secrets/mysql_password)
export DB_SERVER=$(cat ./secrets/mysql_host_server)
export DB_NAME=$(cat ./secrets/mysql_database)

# -- CREATE A VOLUME ON CONTAINER LINKED TO THE HOST SERVER WITH SECRET FILES IN READ-ONLY[:ro] (more secure) --
# CAREFUL : THE VAR NAMES FOR THE MYSQL SERVER NEEDS THE "_FILE" EXTENSION AND THE DIRECTORY CAN NOT BE DIFFERENT
docker run --name mysql \
  -p 3306:3306 \
  -v ./secrets:/run/secrets:ro \
  -e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password \
  -e MYSQL_USER_FILE=/run/secrets/mysql_user \
  -e MYSQL_PASSWORD_FILE=/run/secrets/mysql_password \
  -e MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server \
  -e MYSQL_DATABASE_FILE=/run/secrets/mysql_database \
  -d mysql:9.6.0-oraclelinux9 

docker ps -a
#CONTAINER ID   IMAGE                      COMMAND                  CREATED         STATUS         PORTS                                         NAMES
#deafba298eb8   mysql:9.6.0-oraclelinux9   "docker-entrypoint.s…"   6 seconds ago   Up 4 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp   mysql

docker inspect mysql
#[
#    {
#        "Id": "deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03",
#        "Created": "2026-02-17T18:25:35.547492014Z",
#        "Path": "docker-entrypoint.sh",
#        "Args": [
#            "mysqld"
#        ],
#        "State": {
#            "Status": "running",
#            "Running": true,
#            "Paused": false,
#            "Restarting": false,
#            "OOMKilled": false,
#            "Dead": false,
#            "Pid": 1136,
#            "ExitCode": 0,
#            "Error": "",
#            "StartedAt": "2026-02-17T18:25:36.064968199Z",
#            "FinishedAt": "0001-01-01T00:00:00Z"
#        },
#        "Image": "sha256:db32c8ec843c042a728efb0ac7aa814d6f010eaac8923e20ae0a849d09c5baf8",
#        "ResolvConfPath": "/var/lib/docker/containers/deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03/resolv.conf",
#        "HostnamePath": "/var/lib/docker/containers/deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03/hostname",
#        "HostsPath": "/var/lib/docker/containers/deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03/hosts",
#        "LogPath": "/var/lib/docker/containers/deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03/deafba298eb80d09d73e3f31c0ead13dca18aa274992852ab4cd678de15d5c03-json.log",
#        "Name": "/mysql",
#        "RestartCount": 0,
#        "Driver": "overlayfs",
#        "Platform": "linux",
#        "MountLabel": "",
#        "ProcessLabel": "",
#        "AppArmorProfile": "",
#        "ExecIDs": null,
#        "HostConfig": {
#            "Binds": [
#                "/home/kkz/Documents/DevOps/PART2 - Fundamentals/7. Docker Containers/docker-exercises/secrets:/run/secrets:ro"
#            ],
#            "ContainerIDFile": "",
#            "LogConfig": {
#                "Type": "json-file",
#                "Config": {}
#            },
#            "NetworkMode": "bridge",
#            "PortBindings": {
#                "3306/tcp": [
#                    {
#                        "HostIp": "",
#                        "HostPort": "3306"
#                    }
#                ]
#            },
#            "RestartPolicy": {
#                "Name": "no",
#                "MaximumRetryCount": 0
#            },
#            "AutoRemove": false,
#            "VolumeDriver": "",
#            "VolumesFrom": null,
#            "ConsoleSize": [
#                59,
#                238
#            ],
#            "CapAdd": null,
#            "CapDrop": null,
#            "CgroupnsMode": "private",
#            "Dns": null,
#            "DnsOptions": [],
#            "DnsSearch": [],
#            "ExtraHosts": null,
#            "GroupAdd": null,
#            "IpcMode": "private",
#            "Cgroup": "",
#            "Links": null,
#            "OomScoreAdj": 0,
#            "PidMode": "",
#            "Privileged": false,
#            "PublishAllPorts": false,
#            "ReadonlyRootfs": false,
#            "SecurityOpt": null,
#            "UTSMode": "",
#            "UsernsMode": "",
#            "ShmSize": 67108864,
#            "Runtime": "runc",
#            "Isolation": "",
#            "CpuShares": 0,
#            "Memory": 0,
#            "NanoCpus": 0,
#            "CgroupParent": "",
#            "BlkioWeight": 0,
#            "BlkioWeightDevice": [],
#            "BlkioDeviceReadBps": [],
#            "BlkioDeviceWriteBps": [],
#            "BlkioDeviceReadIOps": [],
#            "BlkioDeviceWriteIOps": [],
#            "CpuPeriod": 0,
#            "CpuQuota": 0,
#            "CpuRealtimePeriod": 0,
#            "CpuRealtimeRuntime": 0,
#            "CpusetCpus": "",
#            "CpusetMems": "",
#            "Devices": [],
#            "DeviceCgroupRules": null,
#            "DeviceRequests": null,
#            "MemoryReservation": 0,
#            "MemorySwap": 0,
#            "MemorySwappiness": null,
#            "OomKillDisable": null,
#            "PidsLimit": null,
#            "Ulimits": [],
#            "CpuCount": 0,
#            "CpuPercent": 0,
#            "IOMaximumIOps": 0,
#            "IOMaximumBandwidth": 0,
#            "MaskedPaths": [
#                "/proc/acpi",
#                "/proc/asound",
#                "/proc/interrupts",
#                "/proc/kcore",
#                "/proc/keys",
#                "/proc/latency_stats",
#                "/proc/sched_debug",
#                "/proc/scsi",
#                "/proc/timer_list",
#                "/proc/timer_stats",
#                "/sys/devices/virtual/powercap",
#                "/sys/firmware"
#            ],
#            "ReadonlyPaths": [
#                "/proc/bus",
#                "/proc/fs",
#                "/proc/irq",
#                "/proc/sys",
#                "/proc/sysrq-trigger"
#            ]
#        },
#        "Storage": {
#            "RootFS": {
#                "Snapshot": {
#                    "Name": "overlayfs"
#                }
#            }
#        },
#        "Mounts": [
#            {
#                "Type": "bind",
#                "Source": "/home/kkz/Documents/DevOps/PART2 - Fundamentals/7. Docker Containers/docker-exercises/secrets",
#                "Destination": "/run/secrets",
#                "Mode": "ro",
#                "RW": false,
#                "Propagation": "rprivate"
#            },
#            {
#                "Type": "volume",
#                "Name": "f7e662a17378c7b91eace37f6ce0e28b6a991aa866b636b1b35c383986d71e15",
#                "Source": "/var/lib/docker/volumes/f7e662a17378c7b91eace37f6ce0e28b6a991aa866b636b1b35c383986d71e15/_data",
#                "Destination": "/var/lib/mysql",
#                "Driver": "local",
#                "Mode": "",
#                "RW": true,
#                "Propagation": ""
#            }
#        ],
#        "Config": {
#            "Hostname": "deafba298eb8",
#            "Domainname": "",
#            "User": "",
#            "AttachStdin": false,
#            "AttachStdout": false,
#            "AttachStderr": false,
#            "ExposedPorts": {
#                "3306/tcp": {},
#                "33060/tcp": {}
#            },
#            "Tty": false,
#            "OpenStdin": false,
#            "StdinOnce": false,
#            "Env": [
#                "MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server",
#                "MYSQL_DATABASE_FILE=/run/secrets/mysql_database",
#                "MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password",
#                "MYSQL_USER_FILE=/run/secrets/mysql_user",
#                "MYSQL_PASSWORD_FILE=/run/secrets/mysql_password",
#                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#                "GOSU_VERSION=1.19",
#                "MYSQL_MAJOR=innovation",
#                "MYSQL_VERSION=9.6.0-1.el9",
#                "MYSQL_SHELL_VERSION=9.6.0-1.el9"
#            ],
#            "Cmd": [
#                "mysqld"
#            ],
#            "Image": "mysql:9.6.0-oraclelinux9",
#            "Volumes": {
#                "/var/lib/mysql": {}
#            },
#            "WorkingDir": "/",
#            "Entrypoint": [
#                "docker-entrypoint.sh"
#            ],
#            "Labels": {},
#            "StopTimeout": 1
#        },
#        "NetworkSettings": {
#            "SandboxID": "24e9eb844cfae959dbc7db8b03ec6eaf67926e22e954936212ae8fd240a7d95d",
#            "SandboxKey": "/var/run/docker/netns/24e9eb844cfa",
#            "Ports": {
#                "3306/tcp": [
#                    {
#                        "HostIp": "0.0.0.0",
#                        "HostPort": "3306"
#                    },
#                    {
#                        "HostIp": "::",
#                        "HostPort": "3306"
#                    }
#                ]
#            },
#            "Networks": {
#                "bridge": {
#                    "IPAMConfig": null,
#                    "Links": null,
#                    "Aliases": null,
#                    "DriverOpts": null,
#                    "GwPriority": 0,
#                    "NetworkID": "fec9ebec04d331c063929c47280435f20ab81a08a47a6b0cfbecae35b2f8fea3",
#                    "EndpointID": "d00f4f96f1cc4f78c0475c5b2363458de42e57e9121c09a8798f3b5ffe5edcb5",
#                    "Gateway": "172.17.0.1",
#                    "IPAddress": "172.17.0.2",
#                    "MacAddress": "62:21:f6:9a:6e:1e",
#                    "IPPrefixLen": 16,
#                    "IPv6Gateway": "",
#                    "GlobalIPv6Address": "",
#                    "GlobalIPv6PrefixLen": 0,
#                    "DNSNames": null
#                }
#            }
#        },
#        "ImageManifestDescriptor": {
#            "mediaType": "application/vnd.oci.image.manifest.v1+json",
#            "digest": "sha256:717d1e4b2352def1f05b40c3c16c470b57f320112a32e506d4548f9964853304",
#            "size": 2863,
#            "annotations": {
#                "com.docker.official-images.bashbrew.arch": "amd64",
#                "org.opencontainers.image.base.digest": "sha256:f480e42968c8a382785bae3fd6c1b2372770f31389a599b1cbcf04f04eb2831a",
#                "org.opencontainers.image.base.name": "oraclelinux:9-slim",
#                "org.opencontainers.image.created": "2026-02-05T22:08:13Z",
#                "org.opencontainers.image.revision": "f8c2facfccdc3c8b8b2c9b5a6aec31db3115105b",
#                "org.opencontainers.image.source": "https://github.com/docker-library/mysql.git#f8c2facfccdc3c8b8b2c9b5a6aec31db3115105b:innovation",
#                "org.opencontainers.image.url": "https://hub.docker.com/_/mysql",
#                "org.opencontainers.image.version": "9.6.0"
#            },
#            "platform": {
#                "architecture": "amd64",
#                "os": "linux"
#            }
#        }
#    }
#]

docker exec -it mysql /bin/bash
bash-5.1# env
#MYSQL_MAJOR=innovation
#HOSTNAME=deafba298eb8
#MYSQL_PASSWORD_FILE=/run/secrets/mysql_password
#PWD=/
#HOME=/root
#MYSQL_VERSION=9.6.0-1.el9
#MYSQL_DATABASE_FILE=/run/secrets/mysql_database
#GOSU_VERSION=1.19
#TERM=xterm
#MYSQL_HOST_SERVER_FILE=/run/secrets/mysql_host_server
#SHLVL=1
#MYSQL_ROOT_PASSWORD_FILE=/run/secrets/mysql_root_password
#MYSQL_USER_FILE=/run/secrets/mysql_user
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#MYSQL_SHELL_VERSION=9.6.0-1.el9
#_=/usr/bin/env
bash-5.1# exit
#exit

env | grep DB
#DB_USER=team1
#DB_NAME=mydb
#DB_SERVER=127.0.0.1
#DB_PWD=team1

# BUILD AND RUN THE JAVA APP
gradle build
java -jar build/libs/docker-exercises-project-1.0-SNAPSHOT.jar 

# THE APP ANSWERS TO http://127.0.0.1:8080 with a text and a picture

# CHECK GET-DATA
curl http://127.0.0.1:8080/get-data
#[{"name":"Sarah","role":"Full stack developer"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]

# CHECK UPDATE-ROLES BY MAKING A CHANGE
curl -X POST http://127.0.0.curl -X POST http://127.0.0.1:8080/update-roles \
  -H "Content-Type: application/json" \
  -d '[{"name":"Sarah","role":"DevOps"}]'
#[{"name":"Sarah","role":"DevOps"}]

# CHECK CHANGE
curl http://127.0.0.1:8080/get-data
#[{"name":"Sarah","role":"DevOps"},{"name":"Bobby","role":"React developer"},{"name":"Ari","role":"Java developer"},{"name":"Andrea","role":"DevOps engineer"},{"name":"Bruno","role":"IT operations"}]

