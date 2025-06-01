#!/bin/bash

source ./common.sh
appname=shipping

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

dnf install maven -y &>>LOG_FILE
VALIDATE $? "install maven"

getcode

cd /app 
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service
VALIDATE $? "copying shipping service"

systemctl daemon-reload &>>LOG_FILE
VALIDATE $? "reload mysql"

systemctl enable shipping &>>LOG_FILE
VALIDATE $? "enable shipping"

systemctl start shipping &>>LOG_FILE
VALIDATE $? "start shipping"


dnf install mysql -y &>>LOG_FILE
VALIDATE $? "install mysql"

mysql -h mysql.satish84s.site -u root -p$MYSQL_ROOT_PASSWORD -e 'use cities' &>>$LOG_FILE
if [ $? -ne 0 ]
then
    mysql -h mysql.satish84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h mysql.satish84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql  &>>$LOG_FILE
    mysql -h mysql.satish84s.site -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "Loading data into MySQL"
else
    echo -e "Data is already loaded into MySQL ... $Y SKIPPING $N"
fi

systemctl restart shipping &>>LOG_FILE
VALIDATE $? "restart mysql"


