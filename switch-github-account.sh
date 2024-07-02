#!/bin/bash

if [ "$1" == "work" ]; then
    git config --global user.name "vikaskumarp10"
    git config --global user.email "vikas.p@ambertag.com"
    echo "Switched to work account successfully."
elif [ "$1" == "personal" ]; then
    git config --global user.name "vikaskumarp1061"
    git config --global user.email "vikaskumarp1061@gmail.com"
    echo "Switched to personal account successfully."
else
    echo "Usage: switch_account [work|personal]"
fi

