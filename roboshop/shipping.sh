#!/bin/bash

source ./common.sh
appname=shipping

dnf install maven -y &>>LOG_FILE
VALIDATE $? "install maven"

getcode

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

mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/schema.sql &>>LOG_FILE
mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/app-user.sql &>>LOG_FILE
mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/master-data.sql &>>LOG_FILE
VALIDATE $? "load mysql data"

systemctl restart shipping &>>LOG_FILE
VALIDATE $? "restart mysql"


