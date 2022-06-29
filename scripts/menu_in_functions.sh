#!/bin/bash

# server name
servername=$(hostname)

echo " current server name is : $servername"

# defining the function for checking ram usage
function memory_check() {
        echo " checking memory of $servername"
        echo ""
        free -mh
        echo ""
}

# check the disk usage currently files in the directory occupying

function disk_usage_check() {
        echo " checking occupying space of current directory"
        echo ""
        du -sh
        echo ""
}

# check cpu load
function cpu_load_check() {
        echo " checking cpu load"
        echo ""
        uptime
        echo ""
}

# check os and linux kernel version
function os_and_kernel_check() {
        echo " checking os and linux kernel version"
        echo ""
        echo " operating system"
        uname
        echo " kernel version "
        uname -r
        echo ""
}

# calling all functions

function all_checks() {
        memory_check
        disk_usage_check
        os_and_kernel_check
}

#################### Colour Functions Start ##################
#	Black        0;30     Dark Gray     1;30
#	Red          0;31     Light Red     1;31
#	Green        0;32     Light Green   1;32
#	Brown/Orange 0;33     Yellow        1;33
#	Blue         0;34     Light Blue    1;34
#	Purple       0;35     Light Purple  1;35
#	Cyan         0;36     Light Cyan    1;36
#	Light Gray   0;37     White         1;37

##
# Colour Variables
##
green='\e[32m'
blue='\e[34m'
red='\e[0;31m'
clear='\e[0m'
##
# Colour Functions
##
ColourGreen(){
 echo -ne $green$1$clear
}
ColourBlue(){
 echo -ne $blue$1$clear
}

#################### Colour Functions End ##################

####### Create Menu for multiple choice checks ############

function menu() {
echo -ne "
$(ColourGreen '1)') Memory Usage
$(ColourGreen '2)') Disk Usage
$(ColourGreen '3)') Os and Kernel verion Check
$(ColourGreen '4)') Check all
$(ColourGreen '5)') Exit
$(ColourGreen ' Choose an option') "

	read a
	case $a in

	1)
	memory_check ; menu
	;;

	2)
	disk_usage_check ; menu
	;;

	3)
	os_and_kernel_check ; menu
	;;

	4)
	 all_checks ; menu
	;;

	5)
	echo "existed"
	;;

	*)
	echo -e $red'Wrong Option'$clear
	menu
	;;

	esac
}

menu
