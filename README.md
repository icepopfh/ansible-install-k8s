#自动部署kubernetes集群

###前期准备
（1）请把ansible的all.yaml变量文件按要求写好！！！


1.manage_config.sh初始化ansible管理机配置
---------------------------------------
（a）安装ansible、sshpass

（b）配置ssh免密

（c）配置本机的/etc/hosts


2.all_system_config.sh初始化服务器配置
------------------------------------
（a）生成一个hosts文件，直接拷贝到其他的服务器的/etc/hosts

（b）修改服务器主机名

（c）关闭服务器防火墙firewalld

（d）关闭服务器selinux

（e）关闭服务器swap

（f）配置ipv4的流量传递到iptables上

（g）安装ntpdate，做ntp时间同步

（h）安装docker，修改daemon.json和docker.service


3.k8s_install.sh部署k8s集群(二进制部署)
------------------------------------

（a）cfssl根据不同的插件生成不同的ca证书和认证证书

（b）部署ETCD集群

（c）部署网络插件flannel（可以部署在k8s集群里，然后通过Daemonset这个资源对象去保证每个节点只有一个flannel，这样新增的节点会自动去部署flannel）

（d）部署master插件：kube-apiserver、kube-controller-manager、kube-scheduler

（e）部署node插件：kubelet、kube-proxy

（f）部署高可用的haproxy、keepalived


4.增加node节点
-------------
4-1：安装部署新的k8s-node

4-2：配置新node的flannel网络（在新节点的flannel进入running状态后再执行）


