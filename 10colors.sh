#!/bin/bash

USER=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#user access checking

if [ $USER -eq 0 ] 
then 
    echo "you are running with root user"
else
    echo -e "$R Error: you are not a root user $N"
fi
