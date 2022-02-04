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


echo -e "\e31mRED\e[0m"