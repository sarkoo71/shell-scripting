#!/bin/bash
Instance_Name=$1
if [ -z "${Instance_Name}" ]; then
  echo -e "\e[1:33mInstance Name argument is needed\e[0m"
  exit

fi


AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ];then
  echo -e "\e[1;31munable to find image AMID\e[0m"
  exit
else
  echo -e "\e[1;32mAMI_ID = ${AMI_ID}\e[0m"
fi


Private_Ip=$(aws ec2 describe-instances --filters Name=tag:Name,Values=frontend --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

if [-z '${Private_Ip}']; then
  aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${Instance_Name}}]"
else
  echo "Instance ${Instance_Name} is already exists, hence not creating"
  exit
fi