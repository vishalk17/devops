#!/bin/bash

for input in {1..10}
do
        if [ $input -eq 5 ]
        then
                echo " skipping the 5th number"

                continue        #skipping the current iteration & continue further
        fi
        echo $input
done
