#!/bin/bash
source ./common.sh

nodejs

mongorepo

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "install mongosh"

mongosh --host mongodb.satish84s.site </app/db/master-data.js &>>$LOG_FILE
VALIDATE $? "load the mongo db"






