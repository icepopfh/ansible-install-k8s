#!/usr/bin/env bash

cfssl gencert -initca etcd-ca-csr.json | cfssljson -bare etcd-ca -
cfssl gencert -ca=etcd-ca.pem -ca-key=etcd-ca-key.pem -config=etcd-ca-config.json -profile=etcd etcd-csr.json | cfssljson -bare etcd

/usr/bin/cp etcd*.pem ../../etcd/files
