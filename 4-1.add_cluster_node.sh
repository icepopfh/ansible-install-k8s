#!/usr/bin/env bash
# author:icepopfh
# date:2021-01-18

set -e

# 重新生成add node的hosts文件
echo -e "generate add node hosts"
ansible-playbook playbook/generate_ansible_hosts.yaml --extra-vars "mode=add_node" -i k8s_hosts
cat add_node_hosts >> k8s_hosts

# 服务器配置
echo -e "Configure, install, restart"
ansible-playbook playbook/add_node.yaml -i k8s_hosts

echo -e "pass add nodes"
kubectl certificate approve $(kubectl get csr | awk 'NR!=1 {print $1}')

echo -e "reboot new node"
ansible-playbook playbook/reboot_new_node.yaml -i k8s_hosts

