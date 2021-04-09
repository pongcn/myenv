#!/bin/bash
myenvdirname="$(basename $PWD)"
inspect=$(sudo grep ${myenvdirname} $HOME/.profile)

if [ "$inspect" = "" ]; then
   echo "source $HOME/code/myenv/main.sh" >> $HOME/.profile
    echo "true"
else
    echo "false"
fi

source ./main.sh

# cp ./build/* $HOME/