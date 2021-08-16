SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875, 1)
FROM dual;

SELECT * FROM orders;
--Q.고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
SELECT custid, ROUND(SUM(saleprice)/COUNT(*),-2) AS 평균금액
FROM orders
GROUP BY custid;

--Q.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price
FROM book;

--Q.‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목,length(bookname) 글자수,lengthb(bookname) 바이트수
FROM book
WHERE publisher ='굿스포츠';

SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);
--Q.마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
--group by 절에는 반드시 컬럼명이 와야하고, alias 는 사용이 불가
SELECT SUBSTR(name,1,1) 성, COUNT(*) 인원
FROM customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q.마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderdate 주문일자, orderdate+10 확정일자 from orders;

SELECT a.*, a.orderdate + 10 확정일자 
FROM orders a;

--Q.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '2020-07-07';

--Q.DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

-- mm이 month로 인식될 수 있는 점 유의
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD HH:mm:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q.이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

SELECT NAME 이름, COALESCE(PHONE,'연락처없음') AS 전화번호
FROM CUSTOMER;
 
--Q.고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <= 2;

SELECT * FROM orders;
--Q.평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

SELECT AVG(saleprice) FROM orders GROUP BY custid;
SELECT * FROM orders;
--Q.각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid, custid, saleprice
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o1.custid=o2.custid);


--과제: 확인 요                 
SELECT orderid 주문번호, custid 고객번호, saleprice 금액
FROM orders O1
WHERE O1.saleprice > (SELECT AVG(O2.saleprice) FROM orders O2 GROUP BY O1.custid);
--고객 전체 평균이 적용되기 때문에 오류 발생
SELECT O1.CUSTID, AVG(O2.saleprice) FROM orders O2, orders O1 GROUP BY O1.custid;

SELECT * FROM customer;
SELECT CUSTID, ROUND(AVG(saleprice),2) 평균 FROM orders GROUP BY custid;

--Q.‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders O
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

SELECT SUM(SALEPRICE) 총금액
FROM CUSTOMER C, ORDERS O
WHERE (C.CUSTID = O.CUSTID) AND (C.ADDRESS LIKE '대한민국%');

--Q.3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid='3');

--Q.EXISTS 연산자를 사용하여 ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) total
FROM orders O
WHERE EXISTS(SELECT * FROM customer C WHERE address LIKE '%대한민국%' AND O.custid=C.custid);

--Q.마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT (SELECT name FROM customer C WHERE C.custid=O.custid) name,
SUM(saleprice) total FROM orders O
GROUP BY O.custid;

SELECT C.name, SUM(O.saleprice)
FROM orders O, customer C
WHERE O.custid = C.custid
GROUP BY C.name;

SELECT C.name 고객이름, NVL(SUM(O.saleprice),0) "고객별 판매액"
FROM customer C, orders O
WHERE c.custid = o.custid(+) 
GROUP BY c.name;

SELECT * FROM orders;
ALTER TABLE orders ADD bookname VARCHAR2(40);

UPDATE orders
SET bookname=(SELECT bookname FROM book WHERE book.bookid=orders.bookid);

--과제
--Q.고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT	cs.name, SUM(od.saleprice) "total"
FROM	(SELECT   custid, name
		 FROM     customer
		 WHERE   custid <= 2) cs,
		Orders	od
WHERE	cs.custid=od.custid
GROUP BY	cs.name;

--Q.주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
DROP VIEW vw_customer;
CREATE VIEW	vw_Customer
AS SELECT		*
	FROM		Customer
	WHERE		address LIKE '%대한민국%';

--Q.Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 
--도서의 주문번호, 도서이름, 주문액을 보이시오.

CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

SELECT * 
FROM vw_customer;

--Q.Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 
--‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW	vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT	od.orderid, od.custid, cs.name,
			od.bookid, bk.bookname, od.saleprice, od.orderdate
    FROM	Orders od, Customer cs, Book bk
	WHERE	od.custid=cs.custid AND od.bookid=bk.bookid;

SELECT * FROM vw_orders;

SELECT	orderid, bookname, saleprice
FROM	vw_Orders
WHERE	name ='김연아';
--과제
--Q.앞서 생성한 뷰 vw_Customer를 삭제하시오.

SELECT * FROM employees;
SELECT last_name, 'is a', job_id from employees;
SELECT last_name ||' is a '|| job_id from employees;

--DISTINCT
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;

--IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--Q.EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;

--숫자 함수 Number Function
SELECT MOD(10,3) FROM dual;

--Q.EMPLOYEES 테이블에서 employee_id가 홀수인 것만 출력하세요.
SELECT *
FROM employees
WHERE MOD(employee_id,2) =1;

SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

SELECT ROUND(45.5555,1) FROM dual;
SELECT TRUNC(45.5555,1) FROM dual;

SELECT last_name, TRUNC(salary/12,2) 월급 FROM employees;

--WIDTH_BUCKET(지정값,최소값,최대값,BUCKET갯수)
SELECT WIDTH_BUCKET(92,0,100,10) FROM dual;

--문자 함수 Character Function 
SELECT UPPER('Hello World') FROM dual;
SELECT LOWER('Hello World') FROM dual;

select * from employees;
SELECT last_name, salary FROM employees WHERE last_name = 'seo';
SELECT last_name, salary FROM employees WHERE LOWER(last_name) = 'seo';

--Q. job_id의 문자 길이를 구하세요.
SELECT job_id, LENGTH(job_id) FROM employees;

--SUBSTR(문자열, 시작위치, 갯수) : 3번째 문자부터 3개출력
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

--오른쪽 정렬 후 왼쪽에 문자를 채운다.
SELECT LPAD('Hello World',20,'#') FROM dual;

--왼쪽 정렬 후 오른쪽에 문자를 채운다.
SELECT RPAD('Hello World',20,'#') FROM dual;

SELECT last_name, trim('A' FROM last_name) A삭제 FROM employees;
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

SELECT LTRIM('  Hello World  ') FROM dual;
SELECT RTRIM('  Hello World  ') FROM dual;
SELECT TRIM('  Hello World  ') FROM dual;

--날짜 관련 함수
SELECT SYSDATE FROM dual;

select * from employees;
SELECT last_name, TRUNC((SYSDATE-hire_date)/365,0) 근속연수 FROM employees;

--특정 개월 수를 더한 날짜를 구한다.
SELECT last_name, ADD_MONTHS(hire_date,6) FROM employees;

--해당 날짜가 속한 월의 말일을반환하는 함수
SELECT LAST_DAY(SYSDATE) FROM dual;
--다음달 말일
SELECT last_name,hire_date,LAST_DAY(ADD_MONTHS(hire_date,1)) FROM employees; 
--해당 날짜를 기준으로 명시된 요일에 해당하는 날짜를 반환(일 ~ 토, 1 ~ 7)
SELECT hire_date, next_day(hire_date,'월') FROM employees;
SELECT hire_date, next_day(hire_date,2) FROM employees;

-- months_between()		날짜와 날짜 사이의 개월수를 구한다.
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) 근속월수 FROM employees;

--Q.입사일 6개월 후 첫 번째 월요일을 직원이름별로 출력하세요.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),2) D_DAY FROM employees;

--집합함수 Aggregate Functions : sum() avg() max() min()
--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
SELECT job_id, SUM(salary) 연봉합계, AVG(salary) 연봉평균, MAX(salary) 최고연봉, MIN(salary) 최저연봉
FROM employees
GROUP BY job_id;
--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 포함
SELECT job_id, SUM(salary) 연봉합계, AVG(salary) 연봉평균, MAX(salary) 최고연봉, MIN(salary) 최저연봉
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000;
--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 내림차순으로 정렬
SELECT job_id, SUM(salary) 연봉합계, AVG(salary) 연봉평균, MAX(salary) 최고연봉, MIN(salary) 최저연봉
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

--조인 Join
--사원번호가 110인 사원의 부서명을 알고 싶은 경우
SELECT * FROM employees WHERE employee_id=110;
SELECT * FROM departments WHERE department_id=100;

SELECT employee_id, department_name FROM employees E, departments D 
WHERE E.department_id = D.department_id AND employee_id=110;

-- JOIN 사용
SELECT employee_id, department_name 
FROM employees E 
join departments D on E.department_id=D.department_id 
WHERE employee_id=110;

--Q.사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력.
--join~on, where 로 조인하는 두 가지 방법 모두.
SELECT E.employee_id, E.last_name, E.job_id, J.job_title
FROM employees E, jobs J
WHERE E.job_id = J.job_id AND E.employee_id = 120;

SELECT employee_id, last_name, E.job_id, job_title
FROM employees E JOIN jobs J ON E.job_id=J.job_id 
WHERE employee_id=120;

--세개의 테이블 조인
SELECT employee_id, job_title, department_name 
FROM employees E, jobs J, departments D
WHERE E.job_id = J.job_id
AND E.department_id = D.department_id;

SELECT R.region_name 대륙 , C.country_id 나라, L.street_address 주소
From COUNTRIES C , regions R , LOCations L
where C.country_id = L.country_id 
AND R.region_id = C.region_id;

SELECT E.last_name, L.city, L.street_address 
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.department_id = D.department_id AND L.location_id = D.location_id;

select * from employees;

SELECT employee_id, job_title, last_name, hire_date, salary, city, country_id
FROM employees E, jobs J, departments D, locations L
WHERE E.job_id = J.job_id 
AND E.department_id = D.department_id 
AND D.location_id = L.location_id 
AND job_title = 'President';

--self join 하나의 테이블이 두 개의 테이블인 것처럼 조인
SELECT E.employee_id 사번, E.last_name 이름, M.last_name, M.manager_id 부서장
FROM employees E, employees M
WHERE E.employee_id = M.manager_id;

--outer join : 조인 조건에 만족하지 못하더라도 해당 행을 나타내고 싶을 때 사용
SELECT E.employee_id 사번, E.last_name 이름, M.last_name 사원, M.manager_id 부서장
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+);

--UNION( 합집합 ) INTERSECT( 교집합 ) MINUS( 차집합 ) UNION ALL( 중복 포함 )
SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
UNION
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name 이름, salary 급여 FROM employees
WHERE salary > 15000
MINUS
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name 이름, salary 급여 FROM employees
WHERE salary > 15000
INTERSECT
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '02/01/01';

--all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과값과 모두 일치하면 참.
--Q.100번 부서의 구성원 모두의 급여보다 더 많은 급여를 받는 사원을 출력
SELECT last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id =100);

--any : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상 일치하면 참
SELECT last_name, salary FROM employees WHERE salary > any
(SELECT salary FROM employees WHERE department_id = 100);

--과제
--Q1. 2005년 이후에 입사한 직원의 사번, 이름, 입사일, 부서명(department_name), 업무명(job_title)을 출력
SELECT E.employee_id, E.last_name, hire_date, department_name, job_title
FROM employees E, departments D, jobs J
WHERE E.department_id=D.department_id AND E.job_id = J.job_id AND hire_date >= '05/01/01' 
ORDER BY hire_date;

--Q2.job_title, department_name별로 평균 연봉을 구한 후 출력하세요. 
SELECT job_title 업무명, department_name 부서명, ROUND(AVG(salary)) "평균 연봉"
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id
GROUP BY job_title, department_name;

--Q3.평균보다 많은 급여를 받는 직원 검색 후 출력하세요.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q4.last_name이 King인 직원의 last_name, hire_date, department_id를 출력하세요
SELECT last_name, hire_Date, department_id
FROM employees
WHERE LOWER(last_name) = 'king';

--Q5. 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'
SELECT employee_id 사번, last_name 이름, 
CASE WHEN salary > 20000 THEN '대표이사'
     WHEN salary > 15000 THEN '이사'
     WHEN salary > 10000 THEN '부장'
     WHEN salary > 5000 THEN '과장'
     WHEN salary > 3000 THEN '대리'
     ELSE '사원'
     END AS 직급
FROM employees;

--Q6.employees 테이블로 부터 last_name, salary, 최고연봉을 출력하세요.
--단, 최고연봉은 first_value ~ over로 구한다.
SELECT last_name, salary, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) 최고연봉
FROM employees;

--Q7.부서별 연봉 순위를 출력하세요.
SELECT last_name, salary, job_id, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC) "연봉 순위"
FROM employees
ORDER BY job_id;

--Q8.employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하세요.
CREATE TABLE employees_salary
AS SELECT employee_id, salary
FROM employees;
SELECT * FROM employees_salary;

--Q9.employees_salary 테이블에 first_name, last_name 컬럼을 추가하세요.
ALTER TABLE employees_salary ADD (first_name VARCHAR2(40) , last_name VARCHAR2(40));
desc employees_salary;

--Q10.last_name을 name으로 변경하세요.
ALTER TABLE employees_salary RENAME COLUMN last_name To name;

--Q11.employees_salary 테이블의 employee_id에 기본키를 적용하고 CONSTRAINT_NAME을 ES_PK로 지정 후 
--출력하세요.
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);

--Q12.employees_salary 테이블의 employee_id에서 CONSTRAINT_NAME을 삭제후 삭제 여부를 확인하세요.
ALTER TABLE employees_salary DROP CONSTRAINT ES_PK;
