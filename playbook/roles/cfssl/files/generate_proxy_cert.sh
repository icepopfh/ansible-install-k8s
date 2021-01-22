#!/usr/bin/env bash

cfssl gencert -ca=apiserver-ca.pem -ca-key=apiserver-ca-key.pem -config=apiserver-ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy

cd roles/cfssl/files/
/usr/bin/cp kube-proxy*.pem ../../kube-proxy/files
