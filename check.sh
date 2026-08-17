#!/bin/bash

echo " "
chmod 755 ~/temp_projects/
chmod 755 ~/temp_server/
echo "temp_server unlocked"
echo " "

echo " "
echo "checking for Questa work"
find ~/ -type d -name "work"
echo " "

echo " "
echo "checking for VCS csrc"
find ~/ -type d -name "csrc"
echo " "

echo " "
echo "checking for *.sw* files"
find ~/ -type f -name "*.sw*"
echo " "

echo " "
chmod 000 ~/temp_projects/
chmod 000 ~/temp_server/
echo "temp_server locked"
echo " "


