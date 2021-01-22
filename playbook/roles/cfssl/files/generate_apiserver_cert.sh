#!/usr/bin/env bash

cfssl gencert -initca apiserver-ca-csr.json | cfssljson -bare apiserver-ca -
cfssl gencert -ca=apiserver-ca.pem -ca-key=apiserver-ca-key.pem -config=apiserver-ca-config.json -profile=kubernetes apiserver-csr.json | cfssljson -bare apiserver

cd roles/cfssl/files/
/usr/bin/cp apiserver*.pem ../../kube-apiserver/files
/usr/bin/cp etcd*.pem ../../kube-apiserver/files
/usr/bin/cp apiserver-ca.pem ../../kubelet/files
