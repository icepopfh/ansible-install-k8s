#自动部署kubernetes集群

###前期准备
请把ansible的all.yaml变量文件按要求写好！！！

manage_config.sh初始化ansible管理机配置
---------------------------------------
1. 安装ansible、sshpass
2. 配置ssh免密
3. 配置本机的/etc/hosts

all_system_config.sh初始化服务器配置
------------------------------------
1. 生成一个hosts文件，直接拷贝到其他的服务器的/etc/hosts
2. 修改服务器主机名
3. 关闭服务器防火墙firewalld
4. 关闭服务器selinux
5. 关闭服务器swap
6. 配置ipv4的流量传递到iptables上
7. 安装ntpdate，做ntp时间同步
8. 安装docker，修改daemon.json和docker.service

k8s_install.sh部署k8s集群(二进制部署)
------------------------------------
1. cfssl根据不同的插件生成不同的ca证书和认证证书
2. 部署ETCD集群
3. 部署网络插件flannel（可以部署在k8s集群里，然后通过Daemonset这个资源对象去保证每个节点只有一个flannel，这样新增的节点会自动去部署flannel）
4. 部署master插件：kube-apiserver、kube-controller-manager、kube-scheduler
5. 部署node插件：kubelet、kube-proxy
6. 部署高可用的haproxy、keepalived

增加node节点
-------------
(1) 4-1.add_cluster_node.sh安装部署新的k8s-node
(2) 4-2.add_cluster_node.sh配置新node的flannel网络（在新节点的flannel进入running状态后再执行）

更新自签名证书
-------------
(1) 5.replace_certificate.sh更新自签名证书

