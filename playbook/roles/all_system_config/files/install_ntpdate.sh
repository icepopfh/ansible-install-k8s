#!/usr/bin/env bash
#author:wuqitai
#date:2020-11-23

install_ntpdate() {
    #install ntpdate
    if command -v ntpdate > /dev/null 2>&1;then
        echo "ansible is already installed."
    else
        code=`curl -I -s --connect-timeout 2 www.baidu.com -w %{http_code} | tail -n1`
        if [ $code == "200" ];then
            yum install ntpdate -y
            echo "ntpdate install successfully."
        else
            echo "Online installation of ansible fails,please ensure the network is smooth."
        fi
    fi
}

install_ntpdate
