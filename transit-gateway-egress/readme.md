# Centralized outbound routing

## 개요
각각 개별의 VPC에서 NAT 게이트웨이를 생성할 필요없이, NAT 게이트웨이와 인터넷 게이트웨이가 포함된 중앙 VPC를 생성하고 outbound 트래픽을 라우팅하도록 Transit Gateway를 구성하는 예제
<a href="https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-nat-igw.html">https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-nat-igw.html</a>

## 주의사항
1. organizations 생성후 ram/설정 들어가서 org 와 리소스 공유 설정 허용해야함

2. ssh 키 bastion 으로 복사시 이름을 변경하면 안된다

3. 중앙 네트워킹 퍼블릭 서브넷에서 다른 서브넷을 향한 Transit Gateway의 경로를 생성해야함

4. bastion 호스트 연결 및 키 복사 예제, 안될시 sudo로 해본다.
```bash
# ssh 접속
ssh -i test.pem ec2-user@X.X.X.X
# scp copy
scp -i ./test.pem ./test.pem ec2-user@X.X.X.X:/home/ec2-user
```

5. network -> client 순으로 apply 해야 한다.

5. 실습이 끝나면 client -> network 순으로 delete 한다.

6. 조직 계정 삭제절차가 생각보다 까다롭다. 신용카드를 등록한후 삭제하는것이 가능한것으로 보인다.
