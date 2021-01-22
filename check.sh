#!/usr/bin/env bash
#author:icepopfh

# ETCD集群健康检查
ETCDCTL_API=3 etcdctl  --cacert=/kubernetes/etcd/conf/etcd-ca.pem --cert=/kubernetes/etcd/conf/etcd.pem \
  --key=/kubernetes/etcd/conf/etcd-key.pem \
  --endpoints="https://192.168.15.134:2379,https://192.168.15.135:2379,https://192.168.15.136:2379"  \
  member list --write-out=table

ETCDCTL_API=3 etcdctl  --cacert=/kubernetes/etcd/conf/etcd-ca.pem --cert=/kubernetes/etcd/conf/etcd.pem \
  --key=/kubernetes/etcd/conf/etcd-key.pem \
  --endpoints="https://192.168.15.134:2379,https://192.168.15.135:2379,https://192.168.15.136:2379"  \
  endpoint health

# apiserver和kube-controller-manager健康检查
kubectl get cs