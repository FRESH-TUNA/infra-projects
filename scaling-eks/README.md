# EKS 구축을 위한 인프라 구성

## 프로젝트 구조
![Image Alt 텍스트](./EKS_final_architecture.png)

## 블로그 링크
<a href="https://lunacircle4.github.io/infra/2021/08/08/eks/">https://lunacircle4.github.io/infra/2021/08/08/eks/</a>

## 과정
배포가 정상적으로 되는지 확인
다운스케일링 확인
업스케일링 확인
---------------------
hpa 적용
hpa 테스트
---------------------
vpa 적용
vpa 테스트

## 로그 확인
kubectl -n kube-system logs -f deployment.apps/cluster-autoscaler