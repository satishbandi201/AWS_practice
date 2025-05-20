#!/bin/bash

DIGIT=$1
#less
if [$DIGIT -lt 20];then
    echo " given number is less than $DIGIT"
else
    echo " given number is greater than $DIGIT"
fi

##greater
if [$DIGIT -gt 20];then
    echo " given number is greater than $DIGIT"
else
    echo " given number is less than $DIGIT"
fi


# -lt  less than
# -gt  greater than
# -eq  equal
# -ne  not equal