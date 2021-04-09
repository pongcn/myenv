#!/bin/bash
# development enviroment
# export WSL_HOST=$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)

# env_path=./

# ignore=(
#     install.sh
#     test.sh
# )

modulespath=$HOME/code/myenv/modules

echo "welcome developer environment. config path:'$PWD/code/myenv'"
# ls $HOME/code/myenv/modules
for i in ${modulespath}/*.sh; do
    . $i
done
# . ${env_path}/wsl2-ubuntu-map-win-localhost.sh
# . ${env_path}/wsl2_proxy.sh
# . ${env_path}/java_env.sh
# . ${env_path}/flutter_env.sh # adb & emulator no working, wsl cup unsupport virtulization
