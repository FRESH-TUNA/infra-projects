#!/bin/sh

# load generator 생성
kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh

# load test
while true; do wget -q -O- http://php-apache; done

# hpa 상태 확인
kubectl get hpa
