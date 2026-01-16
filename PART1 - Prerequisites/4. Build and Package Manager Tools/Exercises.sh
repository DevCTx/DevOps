#!/bin/bash

####################
# Ex 0
# in Build and Package Folder
git clone https://gitlab.com/twn-devops-bootcamp/latest/04-build-tools/build-tools-exercises
cd build-tools-exercises/
rm -rf .git
git init
git add .
git commit -m "initial commit"
git push -u origin main

####################
# Ex 1
cd build-tools-exercises
gradle build

#Error in ./src/test/java/AppTest.java

####################
# Ex 2
# set         boolean result = myApp.getCondition(true);
# instead of  boolean result = myApp.getCondition("true");
gradle test 
# OK

####################
# Ex 3
gradle clean
gradle build

####################
# Ex 4
cd ./build/libs
java -jar ./build/libs/build-tools-exercises-1.0-SNAPSHOT.jar 

####################
# Ex 5
# open ./src/main/java/com/example/Application.java
# set add snippet on line 16 :
#Logger log = LoggerFactory.getLogger(Application.class);
#        try {
#              String one = args[0];
#              String two = args[1];
#              log.info("Application will start with the parameters {} and {}", one, two);
#        } 
#        catch (Exception e) {
#              log.info("No parameters provided");
#        }
#
#
gradle build
java -jar ./build/libs/build-tools-exercises-1.0-SNAPSHOT.jar 
# App indicates "No parameters provided"
java -jar ./build/libs/build-tools-exercises-1.0-SNAPSHOT.jar param1 param2
# App indicates "Application will start with the parameters param1 and param2"



