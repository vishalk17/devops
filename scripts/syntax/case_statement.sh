#!/bin/bash

#check car brand

read -p "what is your car brand : " brand

case $brand in

	tesla)
	echo " $brand is not available in showroom"
	;;

	"tata nano")
	echo "$brand is availble in showroom"
	;;

	eicher| vish)
	echo " $brand plz find in 2nd branch office"
	;;

	*)
	read -p " Your name ?  " name
	echo " $name  you havent selected the brand try again later"
	;;
esac
