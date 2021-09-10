#!/bin/sh

aws eks --region ap-northeast-2 update-kubeconfig --name tuna-eks-cluster

kubectl apply -f ./k8s_objects/autoscaler.yaml

kubectl apply -f https://k8s.io/examples/application/php-apache.yaml

# metric server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

# 최소 1개에서 최대 10개 HPA autoscaler 생성
# 평균 CPU 로드가 50퍼센트 이하인 경우 자동 조정기는 배포 시 포드의 수를 최소 1개
# 로드가 50퍼센트보다 큰 경우 자동 조정기는 배포 시 포드의 수를 최대 10개
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
