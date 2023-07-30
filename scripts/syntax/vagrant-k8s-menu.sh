location="/home/vishal/kubernetes-vagrant-ubuntu"
current_dir="$pwd"


echo "Welcome to the vishalk17 world"

function k8s-start (){
	echo "starting k8s cluster"
	cd $location
	vagrant up
	echo "k8s cluster started"
	cd $current_dir
}

function k8s-stop (){
        echo "stopping k8s cluster"
        cd $location
        vagrant halt
        echo "k8s cluster stopped"
        cd $current_dir
}

#################### Colour Functions Start ##################
#       Black        0;30     Dark Gray     1;30
#       Red          0;31     Light Red     1;31
#       Green        0;32     Light Green   1;32
#       Brown/Orange 0;33     Yellow        1;33
#       Blue         0;34     Light Blue    1;34
#       Purple       0;35     Light Purple  1;35
#       Cyan         0;36     Light Cyan    1;36
#       Light Gray   0;37     White         1;37

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


function menu () {
	echo -ne "
	$(ColourGreen '1)') Start k8s Cluster
	$(ColourGreen '2)') Stop k8s Cluster
	$(ColourGreen '3)') Exit
	$(ColourGreen ' Choose an option') "

        read a
        case $a in
        1)
        k8s-start ; menu
        ;;

        2)
        k8s-stop ; menu
        ;;

        3)
        echo "existed"
        ;;

        *)
        echo -e $red'Wrong Option'$clear
        menu
        ;;

        esac
}

menu
