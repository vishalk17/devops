#!/bin/bash

# do not allow further script if root user executing the script 

if [[ $EUID == 0 ]]
then
	echo " root user can not able to execute $0 script"
else
	echo " you are normal user"
	read -p "what is your name : " name
	echo " welcome to the world $name"
fi
