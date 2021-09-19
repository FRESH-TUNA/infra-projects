1. launch_template 업데이트 테스트
2. 테라폼 테그 테스트


# 실습기록
1. launch template의 새로운 버전을 만들어도 auto scaling group에 변화가 보이지 않는다. (latest 태그가 있는데도 불구하고)
2. auto scaling group의 launch template 버전의 최신인 2로 설정시도 -> 아무 변화 없음
3. desired capacity를 2로 설정 -> 기존의 버전 1 한개, 새로운 버전 2 한개가 생성됨
4. desired capacity를 1로 설정 -> 쿨다운시간 지난후 옜날 버전 삭제

5. nat instance, source/destination check false후 NAT 정상동작확인, apache 동작 확인

6. nat instance가 뜨기 전까지 인터넷 확인 연결 체크 코드가 있으면 좋을것 같다.
7. target tracking with 부하테스트, elb 인터페이스, source/destination check
8. step scaling with 부하테스트
