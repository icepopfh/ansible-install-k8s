#!/usr/bin/env bash
# author:icepopfh
# date:2020-11-23

set -e

base_path=$(pwd)
token=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ')
sed -i "s#.*token.*#token: \"$token\"#g" playbook/group_vars/all.yaml

echo -e "################################### \033[41m generate certificate \033[0m ####################################"
ansible-playbook playbook/k8s_plugins.yaml --tags cfssl -i k8s_hosts
echo -e "####################################### \033[41m install etcd \033[0m ########################################"
ansible-playbook playbook/k8s_plugins.yaml --tags etcd -i k8s_hosts
echo -e "##################################### \033[41m install flanneld \033[0m ######################################"
ansible-playbook playbook/k8s_plugins.yaml --tags flanneld -i k8s_hosts
echo -e "################################## \033[41m install kube-apiserver \033[0m ###################################"
ansible-playbook playbook/k8s_plugins.yaml --tags kube-apiserver -i k8s_hosts
echo -e "##################################### \033[41m install haproxy \033[0m #######################################"
ansible-playbook playbook/k8s_plugins.yaml --tags haproxy -i k8s_hosts
echo -e "#################################### \033[41m install keepalived \033[0m #####################################"
ansible-playbook playbook/k8s_plugins.yaml --tags keepalived -i k8s_hosts
echo -e "############################## \033[41m install kube-controller-manager \033[0m ##############################"
ansible-playbook playbook/k8s_plugins.yaml --tags kube-controller-manager -i k8s_hosts
echo -e "################################## \033[41m install kube-scheduler \033[0m ###################################"
ansible-playbook playbook/k8s_plugins.yaml --tags kube-scheduler -i k8s_hosts
echo -e "###################################### \033[41m install kubelet \033[0m ######################################"
ansible-playbook playbook/k8s_plugins.yaml --tags kubelet -i k8s_hosts
echo -e "#################################### \033[41m install kube-proxy \033[0m #####################################"
ansible-playbook playbook/k8s_plugins.yaml --tags kube-proxy -i k8s_hosts

echo -e "pass all nodes"
kubectl certificate approve $(kubectl get csr | awk 'NR!=1 {print $1}')

#echo -e "Install the flannel"
#cd playbook/roles/addons
#kubectl create -f flannel.yaml
#ansible all -m copy -a "src=${base_path}/playbook/roles/docker/files/docker.service dest=/usr/lib/systemd/system" -i k8s_hosts
#ansible all -m shell -a "systemctl daemon-reload" -i k8s_hosts
#ansible all -m shell -a "systemctl restart docker" -i k8s_hosts

echo -e "Create the icepopfh clusterrolebinding"
kubectl create clusterrolebinding icepopfh --clusterrole=cluster-admin --user=icepopfh

#master unschedulable
#kubectl cordon $(kubectl get node | grep master | awk '{print $1}')

#install addons
#cd playbook/roles/addons
#kubectl create -f coredns.yaml
#kubectl create -f kuboard.yaml
#kubectl create -f metrics-server.yaml
#kubectl create clusterrolebinding system:anonymous --clusterrole=cluster-admin --user=system:anonymous
