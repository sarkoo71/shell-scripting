#!/bin/bash
LOG = /tmp/intance-create.log
rf -f $LOG
Instance_Name=$1
if [ -z "${Instance_Name}" ]; then
  echo -e "\e[1:33mInstance Name argument is needed\e[0m"
  exit

fi


AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31munable to find image AMID\e[0m"
  exit
else
  echo -e "\e[1;32mAMI_ID = ${AMI_ID}\e[0m"
fi


Private_Ip=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${Instance_Name}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)

if [ -z "${Private_Ip}" ]; then
  SG_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=allow-all-ports --query "SecurityGroups[*].GroupId" --output text)
  if [ -z "${SG_ID}" ]; then
      echo"security group allow-all-ports is not exist"
      exit
  fi
  aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${Instance_Name}}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${Instance_Name}}]"  --instance-market-options "MarketType=spot,SpotOptions={InstanceInterruptionBehavior=stop, SpotInstanceType = persistent}" --security-group-ids "${SG_ID}"
else
  echo "Instance ${Instance_Name} is already exists, hence not creating"
fi

IPADDRESS=$(aws ec2 describe-instances --filters Name=tag:Name,Values="${Instance_Name}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
echo '{
            "Comment": "CREATE/DELETE/UPSERT a record ",
            "Changes": [{
            "Action": "CREATE",
                        "ResourceRecordSet": {
                                    "Name": "DNSNAME",
                                    "Type": "A",
                                    "TTL": 300,
                                 "ResourceRecords": [{ "Value": "IPADDRESS"}]
}}]
}' | sed -e "s/DNSNAME/${Instance_Name}/" -e "s/IPADDRESS/${IPADDRESS}/"  >/tmp/record.json

ZONE_ID=$(aws route53 list-hosted-zones --query "HostedZones[*].{name:Name,ID:Id}" --output text | grep roboshop.internal  | awk '{print $1}' | awk -F / '{print $3}')
aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch file:///tmp/record.json --output text &>>$LOG