#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo -e "\e[1;31m You should be root user \e[0m"
  exit 1
fi

if [ -f components/$1.sh ]
then
  bash components/$1.sh
else
    echo -e "\e[1;31mWrong input\e[0m"
    echo -e "\e[1;32m Available inputs are - frontend|mongodb|catalogue|cart|dispatch|mysql|payment|rabbimq|redis|shipping|user\e[0m"
    exit 1
fi