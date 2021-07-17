#!/usr/bin/env bash
# author:icepopfh
# date:2020-11-23

set -e

base_path=$(pwd)

echo -e "配置网络！"
ansible all -m copy -a "src=${base_path}/playbook/roles/docker/files/docker.service dest=/usr/lib/systemd/system" -i k8s_hosts
ansible all -m shell -a "systemctl daemon-reload" -i k8s_hosts
ansible all -m shell -a "systemctl restart docker" -i k8s_hosts

#master unschedulable
kubectl cordon $(kubectl get node | grep master | awk '{print $1}')