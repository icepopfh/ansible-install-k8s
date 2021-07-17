#!/usr/bin/env bash
# author:icepopfh
# date:2021-04-10

ansible-playbook playbook/replace_certificate.yaml -i /etc/ansible/hosts
ansible all -m shell -a "systemctl restart kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy flanneld etcd"
ansible all -m shell -a "systemctl restart docker"
echo "所有涉及证书认证的都需要删掉重新创建！"