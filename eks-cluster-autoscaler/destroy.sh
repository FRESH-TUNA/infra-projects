#!/bin/sh

# kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/examples/2048/2048_full.yaml


kubectl delete -f ./ingress_controller.yaml

kubectl delete -f ./service_account.yaml

kubectl delete \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.1.1/cert-manager.yaml
