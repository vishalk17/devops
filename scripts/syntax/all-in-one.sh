name=vishal

echo " hi $name "

###
#
echo "what is your name"
read named

echo " your name is $named"
##
##
#
# array
#
array=("vishal" "manoj" "anjali" "ruhi")

echo ${array[-1]}	#use curly brackets
##
#
if [[ $? -eq 0 ]]
then
	echo " command was successful "
else
	echo " command was not successful"
fi
####
# check authenticated  user or not
#

authenticated_user=vishalk17
admin_user=admin

read -p " checking authenticated user or admin or not " user

if [[ ${authenticated_user} == ${user}|| ${admin_user} == ${user} ]]
then
	echo " you are allow "
else
	echo " you are not allow "
fi
####
#

### case statement ##

read -p " are you using which operating system " operating_system

case ${operating_system} in

	apple | mac )
		echo " you are using ${operating_system} os"
	;;

        android | google )
                echo  " you are using ${operating_system} os"
        ;;

        huwai | harmony )
                echo " you are using ${operating_system} os"
        ;;
	
        microsoft | windows )
                echo " you are using ${operating_system} os"
        ;;

        *)
                echo  " input is empty or undesirable input"
        ;;
esac

### case statement end
#

## for loop start ##
#
list="vishal ruhi anjali manoj amol"

for friend_name in ${list}
do
	echo " frd name is ${friend_name} "
done

###
#
for num in {1..10}   # Loop through the numbers 1 to 10 using the variable 'num'
do

        if [[ $num -gt 10 ]]; then   # Check if 'num' is greater than 10
                break   # If it is, break out of the loop
        fi

        echo $num   # Print the value of 'num'
done
##
#

## 
# while loop ##
#

i=0

while [[ i -lt 10 ]]
do
	echo $i

	((i++))
done

#
#
read -p " enter your name ! " name_while

while [[ -z ${name_while} ]]
do
	echo " please enter your name again ?"
	read -p read -p " enter your name ! " name_while
done

if [[ -z ${name_while} ]]  ## if name is not empty then print name 
then
	echo " hello ${name_while} "
fi
## while loop end ##
#

############################## break statement start #################################


num=1  # Initialize the value of "num" to 1

while [[ ${num} -le 12 ]]  # Start a while loop that will run as long as "num" is less than or equal to 12
do
        if [[ 5 -eq ${num} ]]  # Check if the value of "num" is equal to 5
        then
                echo ""  				# Print a blank line
                echo " 5 got equal break the look"  	# Print a message indicating that the value of "num" is equal to 5 and will break the loop
                break  					# Exit the loop using the "break" statement
        fi

        ((num++))  		# Increment the value of "num" by 1 using the "((num++))" notation

        echo "${num}"  		# Print the current value of "num"
done  				# End the while loop

# End of script



for (( i=0 ; i < 12 ; i++ ))
do
	echo "outer loop value $i"

	for (( b=2 ; b != 8 ; b++ ))
	do
		echo " current value of inner loop $b "

		if [[ 4 -eq $b ]]
		then
			echo " 4 value came"

			break 2			## exist two level of loop 
		fi
	done
done

############################## break statement End #################################

### continue statment start ###
#

val={1..10}

for num in $val
do
	if [[ 6 -eq $num ]]
	then
		echo "value 6 skipping current iteration"

		continue
	fi
	
	echo "$num"
done

### continue statment End ###