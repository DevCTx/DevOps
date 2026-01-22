#!/bin/bash

########################
# Exercise 0
git clone https://gitlab.com/twn-devops-bootcamp/latest/05-cloud/cloud-basics-exercises
rm -rf ./cloud-basics-exercises/.git

########################
# Exercise 1
cd ./cloud-basics-exercises/app
npm pack
# bootcamp-node-project-1.0.0.tgz created

########################
# Exercise 2

# ON DIGITAL OCEAN
# Create New Droplet
# Select London, Ubuntu LTS 24.04, Regular, $4/month (512Mo, 10Gb)
# SSH by digital-root (set on local PC)
# named : second-ubuntu

# ON LOCAL PC
vim ~/.ssh/config
# Add this config lines :
#Host second-root
#  HostName 188.166.172.248
#  User root
#  IdentityFile ~/.ssh/digital_rsa
#
# Test connection
ssh second-root
# root@second-ubuntu:~#

########################
# Exercise 3
root@second-ubuntu:~# appt install nodejs
root@second-ubuntu:~# appt install npm
root@second-ubuntu:~# node -v
v18.19.1
root@second-ubuntu:~# npm -v
9.2.0

########################
# Exercise 4
root@second-ubuntu:~# adduser dapp
# enter password and full name

root@second-ubuntu:~# su - dapp
# dapp@second-ubuntu:~$ 

dapp@second-ubuntu:~$ ls -lag
#total 24
#drwxr-x--- 2 dapp 4096 Jan 22 10:23 .
#drwxr-xr-x 3 root 4096 Jan 22 10:20 ..
#-rw------- 1 dapp   49 Jan 22 10:25 .bash_history
#-rw-r--r-- 1 dapp  220 Jan 22 10:20 .bash_logout
#-rw-r--r-- 1 dapp 3771 Jan 22 10:20 .bashrc
#-rw-r--r-- 1 dapp    0 Jan 22 10:20 .cloud-locale-test.skip
#-rw-r--r-- 1 dapp  807 Jan 22 10:20 .profile

dapp@second-ubuntu:~$ mkdir .ssh
dapp@second-ubuntu:~$ touch .ssh/authorized_keys
dapp@second-ubuntu:~$ vim .ssh/authorized_keys
# Enter digital_rsa_dapp.pub SSH key from LOCAL PC
# and save

dapp@second-ubuntu:~$ exit
root@second-ubuntu:~# exit

# ON LOCAL PC
# Set SSH Config file
vim ~/.ssh/config
# Add this config lines :
#Host second-dapp
#  HostName 188.166.172.248
#  User dapp
#  IdentityFile ~/.ssh/digital_rsa_dapp
#
# Test connection
ssh second-dapp
#Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.8.0-71-generic x86_64)
# dapp@second-ubuntu:~$

dapp@second-ubuntu:~$ ls -lag
#total 36
#drwxr-x--- 4 dapp 4096 Jan 22 10:38 .
#drwxr-xr-x 3 root 4096 Jan 22 10:20 ..
#-rw------- 1 dapp  222 Jan 22 10:38 .bash_history
#-rw-r--r-- 1 dapp  220 Jan 22 10:20 .bash_logout
#-rw-r--r-- 1 dapp 3771 Jan 22 10:20 .bashrc
#drwx------ 2 dapp 4096 Jan 22 10:38 .cache
#-rw-r--r-- 1 dapp    0 Jan 22 10:20 .cloud-locale-test.skip
#-rw-r--r-- 1 dapp  807 Jan 22 10:20 .profile
#drwxrwxr-x 2 dapp 4096 Jan 22 10:37 .ssh
#-rw-r--r-- 1 dapp    0 Jan 22 10:34 .sudo_as_admin_successful
#-rw------- 1 dapp  874 Jan 22 10:37 .viminfo

dapp@second-ubuntu:~$ chmod 700 .ssh
dapp@second-ubuntu:~$ chmod 600 .ssh/authorized_keys
dapp@second-ubuntu:~$ ls -lag
#total 36
#drwxr-x--- 4 dapp 4096 Jan 22 10:38 .
#drwxr-xr-x 3 root 4096 Jan 22 10:20 ..
#-rw------- 1 dapp  222 Jan 22 10:38 .bash_history
#-rw-r--r-- 1 dapp  220 Jan 22 10:20 .bash_logout
#-rw-r--r-- 1 dapp 3771 Jan 22 10:20 .bashrc
#drwx------ 2 dapp 4096 Jan 22 10:38 .cache
#-rw-r--r-- 1 dapp    0 Jan 22 10:20 .cloud-locale-test.skip
#-rw-r--r-- 1 dapp  807 Jan 22 10:20 .profile
#drwx------ 2 dapp 4096 Jan 22 10:37 .ssh
#-rw-r--r-- 1 dapp    0 Jan 22 10:34 .sudo_as_admin_successful
#-rw------- 1 dapp  874 Jan 22 10:37 .viminfo

dapp@second-ubuntu:~$ exit

# transfer of the Node App
scp bootcamp-node-project-1.0.0.tgz second-dapp:/home/dapp/

# check on second-ubuntu with dapp user
ssh second-dapp
# Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.8.0-71-generic x86_64)
# dapp@second-ubuntu:~$ 
dapp@second-ubuntu:~$ ls -lag
#total 116
#drwxr-x--- 4 dapp  4096 Jan 22 10:46 .
#drwxr-xr-x 3 root  4096 Jan 22 10:20 ..
#-rw------- 1 dapp   249 Jan 22 10:47 .bash_history
#-rw-r--r-- 1 dapp   220 Jan 22 10:20 .bash_logout
#-rw-r--r-- 1 dapp  3771 Jan 22 10:20 .bashrc
#drwx------ 2 dapp  4096 Jan 22 10:38 .cache
#-rw-r--r-- 1 dapp     0 Jan 22 10:20 .cloud-locale-test.skip
#-rw-r--r-- 1 dapp   807 Jan 22 10:20 .profile
#drwx------ 2 dapp  4096 Jan 22 10:37 .ssh
#-rw-r--r-- 1 dapp     0 Jan 22 10:34 .sudo_as_admin_successful
#-rw------- 1 dapp   874 Jan 22 10:37 .viminfo
#-rw-rw-r-- 1 dapp 79382 Jan 22 10:46 bootcamp-node-project-1.0.0.tgz


########################
# Exercise 5

dapp@second-ubuntu:~$ npm install bootcamp-node-project-1.0.0.tgz 
#npm WARN deprecated inflight@1.0.6: This module is not supported, and leaks memory. Do not use it. Check out lru-cache if you want a good and tested way to coalesce async requests by a key value, which is much more comprehensive and powerful.
#npm WARN deprecated glob@7.2.3: Glob versions prior to v9 are no longer supported
#
#added 360 packages in 36s
#
#66 packages are looking for funding
#  run `npm fund` for details

dapp@second-ubuntu:~$ npm list bootcamp-node-project
#dapp@ /home/dapp
#└── bootcamp-node-project@1.0.0
dapp@second-ubuntu:~$ cat package.json 
#{
#  "dependencies": {
#    "bootcamp-node-project": "file:bootcamp-node-project-1.0.0.tgz"
#  }
#}

# No start script in package.json file, so `npm start` won't work
# We need to launch the package's server file directly from node_modules/bootcamp-node-project
dapp@second-ubuntu:~$ node node_modules/bootcamp-node-project/server.js 
#app listening on port 3000!


########################
# Exercise 6

# ON DIGITAL OCEAN
# Add the Droplet to the firewall
# Add the inbound rule : Custom	TCP	3000	All IPv4 All IPv6

# ON LOCAL PC
# using a browser
http://188.166.172.248:3000/
# The app answers :
#List of projects team is working on
#user-profileName: Andrea Hill
#Role: DevOps engineer
#Projects: AWS migration, Backup Automation
#user-profileName: Ari Baker
#Role: Software developer
#Projects: Online Shop, ERP Software
 

