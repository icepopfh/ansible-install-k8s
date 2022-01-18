#!/usr/bin/env bash
# author:icepopfh
# data:2021-01-28

set -e

base_path=$(pwd)

docker login 192.168.15.124 -u username -p password
dockerconfigjson=$(cat ~/.docker/config.json | base64 -w 0)
sed -i "s#.*\.dockerconfigjson.*#  .dockerconfigjson: $dockerconfigjson#g" yaml/3.initialize.yaml

kubectl create -f yaml/1.rbac.yaml
kubectl create -f yaml/2.provisioner_prod.yaml
kubectl create -f yaml/3.initialize.yaml
# kubectl create -f yaml/provisioner_test.yaml
kubectl create -f yaml/4.ingress-nginx.yaml
kubectl create -f yaml/coredns.yaml
kubectl create -f yaml/metrics-server.yaml