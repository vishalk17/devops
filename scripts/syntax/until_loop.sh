#!/bin/bash

##### continue the loop until value becomes less than 20

vish=30

until [[ $vish -lt 20 ]]
do
        echo " $vish "
        (( vish-- ))   #decrement by -1
done
