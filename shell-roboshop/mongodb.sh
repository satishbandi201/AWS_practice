#!/bin/bash

source ./common.sh

mongorepo

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "installing mongod"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "enabiling mongod"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting mongod"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf 
VALIDATE $? "replace ip in mongo.conf file"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restart mongod service"
