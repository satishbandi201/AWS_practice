#!/bin/bash

source ./common.sh

mongorepo

dnf install mongodb-org -y 
VALIDATE $? "installing mongod"

systemctl enable mongod
VALIDATE $? "enabiling mongod"

systemctl start mongod
VALIDATE $? "starting mongod"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "replace ip in mongo.conf file"

systemctl restart mongod
VALIDATE $? "restart mongod service"
