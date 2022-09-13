#!/bin/bash

######## part of check whether you are admin or not"

admin=vishalk17

read -p "enter your username : " username

if [[ $username == $admin ]]
then
	echo "You are the admin of the system"
else
	echo "You are not the admin of the system"
fi
