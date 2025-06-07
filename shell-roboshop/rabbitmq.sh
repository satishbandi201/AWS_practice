#!/bin/bash

source ./common.sh

echo "Please enter rabbitmq password to setup"
read -s RABBITMQ_PASSWD

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Adding rabbitmq repo"

dnf install rabbitmq-server -y &>>LOG_FILE
VALIDATE $? "install rabbitmq"

systemctl enable rabbitmq-server &>>LOG_FILE
VALIDATE $? "enable rabbitmq"

systemctl start rabbitmq-server &>>LOG_FILE
VALIDATE $? "start rabbitmq"

rabbitmqctl add_user roboshop $RABBITMQ_PASSWD &>>LOG_FILE
VALIDATE $? "add user"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>LOG_FILE
VALIDATE $? "set password"

