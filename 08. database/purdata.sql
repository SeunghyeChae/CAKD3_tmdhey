SELECT * FROM PURPRD;

-- 고객 속성정보
SELECT * FROM CUST;

-- 유통채널- 온라인,모바일 :: 최근 3개월 
SELECT 제휴사, SUM(이용횟수) FROM CHANNEL
GROUP BY 제휴사;

-- 경쟁사 이용 현황
SELECT * FROM COMPUSE;

-- 멤버십
SELECT 멤버십명, COUNT(*) 개수 FROM MEMBERSHIP
GROUP BY 멤버십명;

-- 제품 분류
SELECT * FROM PRODCAT;


SELECT 고객번호, SUM(구매금액)
FROM PURPRD;

-- PURPRD :트랜잭션 데이터 
SELECT * FROM PURPRD;
SELECT 고객번호, SUM(구매금액)
FROM PURPRD 
GROUP BY 고객번호
