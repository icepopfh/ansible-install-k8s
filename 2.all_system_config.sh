#!/usr/bin/env bash
# author:icepopfh
# date:2020-11-23

set -e

echo -e "##### \033[41m update /etc/hosts & Turn off the firewalld & Close the selinux & Close swap space \033[0m #####"
echo -e "##################### \033[41m create /etc/sysctl.d/kubernetes.conf & time sync \033[0m ######################"
ansible-playbook playbook/system_config.yaml --tags all_system_config -i k8s_hosts
echo -e "############################### \033[41m update hostname for all hosts \033[0m ###############################"
ansible-playbook playbook/system_config.yaml --tags hostname -i k8s_hosts
echo "update hostname successfully."
echo -e "###################################### \033[41m install docker \033[0m ############## ########################"
echo -e "建议提前安装好docker，否则此处会执行比较长的时间用于安装docker(因为暂时未实现离线安装)"
ansible-playbook playbook/system_config.yaml --tags docker_install -i k8s_hosts
echo -e "################################## \033[41m helm & kubectl & kubeadm \033[0m ##################################"
ansible-playbook playbook/system_config.yaml --tags k8s_command -i k8s_hosts
echo -e "###################################### \033[41m reboot all hosts \033[0m #####################################"
ansible-playbook playbook/reboot.yaml -i k8s_hosts
