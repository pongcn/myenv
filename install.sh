#!/bin/bash
sudo chmod +x ./install.sh

source ./.config

inspect=$(grep ${pj_name} $HOME/.profile)
inprofile="$HOME/.${pj_name}"

cp -f "${MYENV_ROOT_PATH}/build/.${pj_name}" $HOME/

# homemyenv=${HOME}/.${pjname}

# inprotext=`$(echo "source $HOME/.${pjname}")`

if [ "$inspect" = "" ]; then
    echo "source $inprofile" | tee -a $HOME/.profile
    echo "newset"
else
    sed -i -e "s|${inspect}|source ${inprofile}|g" $HOME/.profile
fi

