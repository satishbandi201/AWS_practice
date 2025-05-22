#!/bin/bash

DIGIT=$1
#less
if [ $DIGIT -lt 20 ]
then
    echo " given number is less than 20"
else
    echo " given number is greater than 20"
fi

##greater
if [ $DIGIT -gt 100 ]
then
    echo " given number is greater than 100"
else
    echo " given number is less than 100"
fi


# -lt  less than
# -gt  greater than
# -eq  equal
# -ne  not equal