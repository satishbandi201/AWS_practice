#!/bin/bash

source ./common.sh

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




