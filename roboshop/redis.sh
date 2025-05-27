#!/bin/bash

source ./common.sh

dnf module disable redis -y
VALIDATE $? "disable redis"

dnf module enable redis:7 -y
VALIDATE $? "enable redis"

dnf install redis -y
VALIDATE $? "install redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
VALIDATE $? "replace ip in config file"

systemctl enable redis
VALIDATE $? "enable redis"

systemctl start redis
VALIDATE $? "start redis"