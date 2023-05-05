#!/bin/bash

# ****** allow further script only if root user executing the script start*******
if [[ $EUID == 0 ]]
then

echo "script to add new user"
echo ""

# Ask for username & password
read -p "Enter username: " username
echo ""

read -p "Enter password: " password
echo ""

# Add new user
sudo adduser $username --disabled-password --gecos ""

# set new password for the user
##  echo "newuser:newpassword" | chpasswd
	
echo "$username:$password" | chpasswd

# grant sudo privileges:

sudo usermod -aG sudo $username

echo '$username ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo ""

echo "finished adduser task"
fi
