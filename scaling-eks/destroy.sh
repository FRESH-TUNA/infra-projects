#!/bin/sh

kubectl delete -f ./k8s_objects/deployment.yaml

kubectl delete -f ./k8s_objects/autoscaler.yaml
