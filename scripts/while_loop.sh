#!/bin/bash

#########  loop contineus until value becomes less than 10

value=0

while [[ $value -lt 10 ]]
do
	echo $value
	((value++))  # add +1 increment to the value varible
done

############

#### ask user their  name do not allow empty name"

read -p "Hey what is your name : " name

while [[ -z $name ]]
do
	echo " You havent enter your name , plz try again"
	read -p "Hey what is your name : " name
done

echo "Hello $name"

################
