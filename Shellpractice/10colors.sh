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

#installing mysql packages

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "$Y mysql is already installed $N"
fi

#installing nginx package
dnf list installed nginx
if [ $? -ne 0 ]
then
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e "$Y nginx is already installed. $N"
fi

##installing nodejs
dnf list installed nodejs
if [ $? -ne 0 ]
then 
    dnf install nodejs -y
    VALIDATE $? "nodejs"
else
    echo -e "$Y nodejs already installed $N"
fi