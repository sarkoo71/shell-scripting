#!/bin/bash

echo Hello World

##To print something in color

# Syntax : echo -e "\e[COLmMESS\e[0m"

  #-e - to enable esc or \e seq
  #\e - to enable colour
  #[COLm - COL is color number
  #\e[0m - To disable the colour

# COL Name      Col Code
# Red           31
# Green         32
# Yellow        33
# Blue          34
# Magenta       35
# Cyan          36


echo -e "\e[31mRED\e[32mGreen\e[33mYellow\e[34mBlue\e[35mMagenta\e[36mCyan\e[0m"

echo -e "\e[1;31mRED\e[1;32mGreen\e[1;33mYellow\e[1;34mBlue\e[1;35mMagenta\e[1;36mCyan\e[0m"