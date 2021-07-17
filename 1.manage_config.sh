#!/usr/bin/env bash
# author:icepopfh
# date:2020-11-23

set -e

install_ansible() {
    #install ansible
    if command -v ansible > /dev/null 2>&1;then
        echo "ansible is already installed."
    else
        code=$(curl -I -s --connect-timeout 2 www.baidu.com -w %{http_code} | tail -n1)
        if [ $code == "200" ];then
            rpm -Uvh http://mirrors.ustc.edu.cn/epel/epel-release-latest-7.noarch.rpm && \
            yum install epel-release -y  && \
            yum install -y ansible
            ansible --version
        else
            echo "Online installation of ansible fails,please ensure the network is smooth."
        fi
    fi
}

ssh_auth() {
    #generate new public-key
    if [ ! -f $HOME/.ssh/id_rsa ];then
        ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
    fi
    #install sshpass
    if command -v sshpass > /dev/null 2>&1;then
        echo "sshpass is already installed."
    else
        code=$(curl -I -s --connect-timeout 2 www.baidu.com -w %{http_code} | tail -n1)
        if [ $code == "200" ];then
            yum install sshpass -y
        else
            echo "Online installation of sshpass fails, please ensure the network is smooth."
        fi
    fi
    #Distribute the public key
    ansible-playbook playbook/system_config.yaml --tags ssh_auth
    echo "Distribute public-key successfully."
}

echo -e "###################################### \033[41m install ansible \033[0m ######################################"
install_ansible
echo -e "################################### \033[41m generate ansible hosts \033[0m ##################################"
ansible-playbook playbook/generate_ansible_hosts.yaml --extra-vars "mode=new"
echo -e "##################################### \033[41m update /etc/hosts \033[0m #####################################"
ansible-playbook playbook/system_config.yaml --tags manage_config
echo "update /etc/hosts for all hosts successfully."
echo -e "######################## \033[41m SSH secret free authentication configuration \033[0m #######################"
ssh_auth
