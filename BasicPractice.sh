#!/bin/bash

# Welcome message
echo "Hello World"

# User promt
read -p "Enter your name: " name

# Show user name based on conditions
if [ "$name" = "Ritesh" ]; then
    echo "Hey Admin, \n Welcome to Shell Script"
elif [ "$name" = "Vidhya" ]; then
    echo "Hey VSS, Now you are my team member"
else
    echo "Hey $name"
fi

# Loop Practice
for i in {1..5}; do
    echo "Looping..  $i"
done
