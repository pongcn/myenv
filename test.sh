#!/bin/bash
# echo "test"
# echo $(ls ./)
# echo ~
# echo $(cat .config | grep autoproxy | awk '{print $1}')
# echo $(cat .config | grep ignore)
# sudo cat ./.config | grep autoproxy | awk '{print $1}'

# sudo sed -i 's/# autoproxy=true/autoproxy=false/' >./.config
# awk 'NR==4 {$autoproxy="true"} { print }' ./.config

# sed -i -e 's/autoproxy="true"/autoproxy="false"/g' ./.config
# sudo $(cat ${HOME}/.profile | grep op.env)
# filename="env"
# inspect=$(sudo grep openv $HOME/.profile)

# if [ "$inspect" = "" ]; then
#     echo "trun"
# else
#     echo "false"
# fi

proxystatus="111"
autoproxy="true"

if [[ (${autoproxy} = "true") ]]; then
    echo "yes"
else
    echo "no"
fi