#!/bin/bash

AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ];then
  echo -e "\e[1;31munable to find image AMID\e[0m"
else
  echo -e "\e[1;32mAMI_ID = ${AMI_ID}\e[0m"
fi

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text