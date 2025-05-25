#!/bin/bash

USER=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SCRIPT_DIR=$PWD

##user access checking

if [ $USER -ne 0 ]
then
    echo -e "you are running with $G root access $N"
else
    echo -e "$R you are not a root user $N"
    exit 1
fi

##VALIDATING COMMAND

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$2 is $G SUCCESS $N"
    else
        echo "$2 is $R FAILED $N"
    fi
}

##installing packages

dnf module disable nginx -y
VALIDATE $? "dsiabiling nginx"

dnf module enable nginx:1.24 -y
VALIDATE $? "enabiling nginx:1.24"

dnf install nginx -y
VALIDATE $? "Installing nginx"

systemctl enable nginx
VALIDATE $? "enable nginx"

systemctl start nginx
VALIDATE $? "start nginx"

rm -rf /usr/share/nginx/html/*
VALIDATE $? "remove html default content"

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
VALIDATE $? "download frontend zip_folder content"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip
VALIDATE $? "Unzip html content"

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "copying nginx.conf file"

systemctl restart nginx 
VALIDATE $? "restarting nginx"




