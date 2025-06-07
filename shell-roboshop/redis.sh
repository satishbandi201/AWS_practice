#!/bin/bash

source ./common.sh

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "disable redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "enable redis"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "install redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "replace ip in config file"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "enable redis"

systemctl start redis &>>$LOG_FILE
VALIDATE $? "start redis"