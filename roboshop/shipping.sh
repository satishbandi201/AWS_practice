#!/bin/bash

source ./common.sh
appname=shipping

dnf install maven -y
VALIDATE $? "install maven"

getcode

cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service
VALIDATE $? "copying shipping service"

systemctl daemon-reload
VALIDATE $? "reload mysql"

systemctl enable shipping
VALIDATE $? "enable shipping"

systemctl start shipping
VALIDATE $? "start shipping"


dnf install mysql -y
VALIDATE $? "install mysql"

mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h mysql.satish84s.site -uroot -pRoboShop@1 < /app/db/master-data.sql
VALIDATE $? "load mysql data"

systemctl restart shipping
VALIDATE $? "restart mysql"


