#!/bin/bash

########################

for input in {1..10}
do
        if [ $input -eq 5 ]
        then
                echo " break the loop at  5th number"

                break   # break or stop the loop
        fi
        echo $input
done

###########################

for (( a=1; a < 10; a++ ))
do
        echo "current value of outer loop a :  $a"
        for (( b=1; b < 8; b++ ))
        do
        echo "current value of inner loop b : $b"
                if [[ $b -eq 5 ]]
                then
                echo " b value is equal to 5  break the loop"
                break 2
                fi
        done
done
