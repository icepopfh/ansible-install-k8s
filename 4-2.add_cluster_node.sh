#!/usr/bin/env bash
# author:icepopfh
# date:2021-01-22

set -e
base_path=$(pwd)

# 配置docker和flannel网络
echo -e "Configure the flannel"
ansible new_node -m copy -a "src=${base_path}/playbook/roles/docker/files/docker.service dest=/usr/lib/systemd/system" -i k8s_hosts
ansible new_node -m shell -a "systemctl daemon-reload" -i k8s_hosts
ansible new_node -m shell -a "systemctl restart docker" -i k8s_hosts