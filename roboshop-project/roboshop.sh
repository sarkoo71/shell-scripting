#!/bin/bash

if [ -f components/$1.sh ]
then
  bash components/$1.sh
else
  echo "\e[1;mWrong input\e[0m"
fi