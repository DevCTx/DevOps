#!/bin/bash

echo "JAVA installation"
sudo apt install default-jdk;

JAVA_VERSION=$(java -version 2>&1 | grep 'version');

echo "$JAVA_VERSION"

if [ "$JAVA_VERSION" ];
then
    echo "1. JAVA is installed";

    JAVA_MAJOR_VERSION=$(echo "$JAVA_VERSION" | awk -F '"' '{print $2}' | awk -F '.' '{print $1}' );

    if [ "$JAVA_MAJOR_VERSION" ];
    then
        echo "2. The Java major version is $JAVA_MAJOR_VERSION";

        if [ "$JAVA_MAJOR_VERSION" -ge 11 ];
        then 
            echo "3. This version is 11 or higher."
        else
            echo "3. This version is lower than 11."
        fi
    fi
fi

