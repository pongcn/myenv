#!/bin/bash
# let's code into ~/.profile at this file
# let's those alias commend resisent ~/.profile
# called alias, let's mutiply bash can be used
# autoproxy="false"
# proxystatus=""
# sudo cat ../.config | grep autoproxy | awk '{print $1}'

port=7890

PROXY_HTTP="http://${WSL_HOST_IP}:${port}"
PROXY_HTTP="http://${WSL_HOST_IP}:${port}"

set_proxy() {
    echo "starting proxy"
    export http_proxy="${PROXY_HTTP}"
    export HTTP_PROXY="${PROXY_HTTP}"
    export https_proxy="${PROXY_HTTP}"
    export HTTPS_proxy="${PROXY_HTTP}"
    export proxystatus="true"
    echo "Successfully! proxy:" ${https_proxy}
}

unset_proxy() {
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    export proxystatus="false"
    echo "unset proxy successfully:"
}

see_proxy() {
    echo "Host ip:" ${WSL_HOST_IP}
    echo "WSL ip:" ${wslip}
    echo "Current proxy:" $https_proxy
}

if [[ (${proxystatus} = "true" && ${proxystatus} = "") ]]; then
    unset_proxy
else
    set_proxy
fi


alias setproxy=set_proxy
alias unsetproxy=unset_proxy
alias seeproxy=see_proxy
