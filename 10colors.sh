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
    exit 1
fi

#VALIDATE function

VALIDATE (){
    if [ $1 -eq 0 ]
    then 
        echo -e "$2 is installing... $G SUCCESS $N"
    else
        echo -e "$2 is installing... $R FAILED $N"
    fi    
}

#installing packages

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo "mysql is already installed"
fi

