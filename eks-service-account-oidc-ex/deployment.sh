#!/bin/sh

aws eks --region ap-northeast-2 update-kubeconfig --name tuna-eks-cluster

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.1.1/cert-manager.yaml


kubectl apply --validate=false -f ./service_account.yaml

sleep 20s
 
kubectl apply --validate=false -f ./ingress_controller.yaml

sleep 20s

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/examples/2048/2048_full.yaml
