#!/usr/bin/env bash
# author:icepopfh

#部署calico
kubectl apply -f calico.yaml

#把ippool的配置导出并修改cidr，如ippool.yaml.example
calicoctl get ippool -o yaml > ippool.yaml
calicoctl apply -f ippool.yaml

#默认是nodeToNodeMesh模式，修改为RR模式应用bgpRR.yaml
#bgpRR.yaml里面的asNumber查看: calicoctl get node --output=wide
calicoctl apply -f bgpRR.yaml

#为RR节点打上标签
kubectl label node k8s-master1 network-calico-RR=true

#导出calico节点的配置，并添加routeReflectorClusterID，如RR-node.yaml.example
calicoctl get node k8s-master1 -o yaml > RR-node.yaml
calicoctl apply -f RR-node.yaml

