#!/bin/bash
export config_dir="conf_dir"
if [ -d "$config_dir" ]
then
 echo "reading config directory contents"
 config_files=$(ls "$config_dir")
else
 echo "config dir not found. Creating one"
 mkdir "$config_dir"
 touch "$config_dir/config.sh"
fi
