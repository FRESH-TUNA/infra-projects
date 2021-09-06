#!/bin/sh

aws eks --region ap-northeast-2 update-kubeconfig --name tuna-eks-cluster

kubectl apply -f ./k8s_objects/autoscaler.yaml
