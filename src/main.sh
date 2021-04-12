#!/bin/bash
# development enviroment
# export WSL_HOST=$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)

source ../.config

# export localhost=$WSL_HOST_IP

# modulespath=""

echo "welcome my environment."
# ls $HOME/code/myenv/modules

for i in ${search_components}; do
    sudo sh -c "$i"
done

# . ${env_path}/wsl2-ubuntu-map-win-localhost.sh
# . ${env_path}/wsl2_proxy.sh
# . ${env_path}/java_env.sh
# . ${env_path}/flutter_env.sh # adb & emulator no working, wsl cup unsupport virtulization
