#!/bin/bash

# ****** allow further script only if root user executing the script start*******
if [[ $EUID == 0 ]]
then

	## install require pkges ##
	amazon-linux-extras install ansible2 -y
	yum install git -y
	sleep 4

	### add user with password start ###
	# -m : The user’s home directory will be created if it does not exist.
	# -p EncryptedPasswordHere : The encrypted password, as returned by crypt().
	# username : Add this user to the Linux system,
	#
	#  useradd -m username
	#
	#  change/set password of ansible user
	#  echo "newuser:newpassword" | chpasswd
	#
	useradd -m ansible
	echo "ansible:ansible" | chpasswd
	#
	### add user with password End ###

	### provide ansible as a user root privilege start ####
	#
	echo 'ansible ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
	#
	### provide ansible as a user root privilege end ####

	##	edit /etc/ansible/ansible.cfg  start ###
	#	uncomment inventory line to enable hosts file
	#	uncomment sudo_user line
	#	replace lines by sed command 
	#	sed -i "s%old_line%new_line%g" /path/to/the/file
	#
	sed -i "s%#inventory      = /etc/ansible/hosts%inventory      = /etc/ansible/hosts%g" /etc/ansible/ansible.cfg
	sed -i "s%#sudo_user      = root%sudo_user      = root%g" /etc/ansible/ansible.cfg
	#
	##	edit /etc/ansible/ansible.cfg  End ###

	##	edit /etc/ssh/sshd_config start ###
	#
	#	uncomment PermitRootLogin yes
	#	uncomment PasswordAuthentication yes
	#	comment PasswordAuthentication no
	#	restart sshd service
	#
	sed -i "s%#PermitRootLogin yes%PermitRootLogin yes%g" /etc/ssh/sshd_config
	sed -i "s%#PasswordAuthentication yes%PasswordAuthentication yes%g" /etc/ssh/sshd_config
	sed -i "s%PasswordAuthentication no%#PasswordAuthentication no%g" /etc/ssh/sshd_config

	service sshd restart
	#
	##	edit /etc/ssh/sshd_config end ###
	#
else
		echo " you are normal user, only root user can excute this script $0"
fi
#
# ****** allow further script only if root user executing the script End*******
