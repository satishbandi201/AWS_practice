#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-03198fa0653d6dd89"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z10145872BEYXWGCKYUZ9"
DOMAIN_NAME="satish84s.site"

for instance in ${INSTANCES[@]}
do
     
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-03198fa0653d6dd89 --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
 if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)  
    fi
    echo "$instance IP Adress is : $IP"
done
