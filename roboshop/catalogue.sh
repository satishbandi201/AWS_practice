#!/bin/bash
source ./common.sh

##installing packages
dnf module disable nodejs -y
VALIDATE $? "disabiling nodejs"

dnf module enable nodejs:20 -y
VALIDATE $? "enabiling nodejs:20"

dnf install nodejs -y
VALIDATE $? "install nodejs"

#user creation check
id roboshop
if [ $? -eq 0 ]
then
    echo -e "roboshop user already $G Exist $N"
else
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "roboshop user creation"
fi

mkdir -p /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
VALIDATE $? "get zip code from git"

cd /app
unzip /tmp/catalogue.zip
VALIDATE $? "unzip the code in app folder"

npm install
VALIDATE $? "installing npm"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "copying configuration file"

systemctl daemon-reload
VALIDATE $? "reload"

systemctl enable catalogue
VALIDATE $? "enable the catalogue"

systemctl start catalogue
VALIDATE $? "Start catalogue"

mongorepo

dnf install mongodb-mongosh -y
VALIDATE $? "install mongosh"

mongosh --host mongodb.satish84s.site </app/db/master-data.js
VALIDATE $? "load the mongo db"






