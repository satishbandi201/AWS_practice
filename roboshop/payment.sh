#!/bin/bash

source ./common.sh
appname=payment

dnf install python3 gcc python3-devel -y
VALIDATE $? "install python3"


id roboshop
    if [ $? -eq 0 ]
    then
        echo -e "roboshop user already $G Exist $N" | tee -a $LOG_FILE
    else
        useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
        VALIDATE $? "roboshop user creation"
    fi

mkdir -p /app
    cd /tmp
    rm -rf /tmp/*.zip
    curl -o /tmp/$appname.zip https://roboshop-artifacts.s3.amazonaws.com/$appname-v3.zip &>>$LOG_FILE
    VALIDATE $? "get zip code from git"

cd /app 
pip3 install -r requirements.txt
VALIDATE $? "install requirements"

systemctl daemon-reload
VALIDATE $? "daemon reload"

systemctl enable payment
VALIDATE $? "enable payment"

systemctl start payment
VALIDATE $? "start payment"

