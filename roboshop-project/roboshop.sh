#!/bin/bash

if [ -f components/$1.sh ]
then
  bash components/$1.sh
else
    echo -e "\e[1;31mWrong input\e[0m"
fi