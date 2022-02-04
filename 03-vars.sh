#!/bin/bash


student_name="Raju"

echo student_name = $student_name

DATE=2022-02-03

echo Good Morning $student_name, Today Date is $DATE

## Command substitution
DATE=$(date +%F)

echo Good Morning $student_name, Today Date is $DATE