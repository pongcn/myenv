#!/bin/bash
myenvdirname="$(basename $PWD)"

sudo rm -rf "./build"
sudo mkdir "build"
sudo -s touch "./build/.${myenvdirname}"
sudo sh -c "cat .config > ./build/.${myenvdirname}"
for i in "./modules/*.sh"; do
    sudo sh -c "cat $i >> ./build/.${myenvdirname}"
done

