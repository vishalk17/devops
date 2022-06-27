#!/bin/bash

for input in {1..10}
do
        if [ $input -eq 5 ]
        then
                echo " break the loop at  5th number"

                break   # break or stop the loop
        fi
        echo $input
done
