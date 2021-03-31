#!/usr/bin/env bash
#author:icepopfh

echo -e "remove docker?"
read option
if [ "$option" == "y" ] || [ "$option" == "Y" ] || [ "$option" == "" ]; then
  ansible all -m shell -a "systemctl stop docker && yum remove docker-ce -y && rpm -e docker-ce-cli-20.10.2-3.el7.x86_64"
fi

ansible all -m shell -a "systemctl stop kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy flanneld etcd"

ansible all -m shell -a "rm -rf etcd.service kube-apiserver.service kube-controller-manager.service kube-scheduler.service kubelet.service kube-proxy.service flanneld.service"

ansible all -m shell -a "rm -rf /kubernetes"

ansible all -m shell -a "sed -i "/k8s/d" /etc/hosts"