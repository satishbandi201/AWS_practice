#!/bin/bash

source ./common.sh

dnf install rabbitmq-server -y
VALIDATE $? "install rabbitmq"

systemctl enable rabbitmq-server
VALIDATE $? "enable rabbitmq"

systemctl start rabbitmq-server
VALIDATE $? "start rabbitmq"

rabbitmqctl add_user roboshop roboshop123
VALIDATE $? "add user"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "set password"

