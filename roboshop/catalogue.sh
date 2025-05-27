#!/bin/bash
source ./common.sh

nodejs

mongorepo

dnf install mongodb-mongosh -y
VALIDATE $? "install mongosh"

mongosh --host mongodb.satish84s.site </app/db/master-data.js
VALIDATE $? "load the mongo db"






