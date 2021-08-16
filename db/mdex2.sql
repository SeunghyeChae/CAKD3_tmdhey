--절대값
SELECT ABS(-78), ABS(+78) 
FROM dual;

--반올림
SELECT ROUND(4.875,1)
FROM dual;


--Q. 고객별 평균 주문 금액을 백원단위로 반올림한 값
SELECT ROUND(SUM(saleprice)/COUNT(*),-2) AS 평균금액
FROM orders
GROUP BY custid;

--Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록, 가격을 보이시오
SELECT REPLACE(bookname,'야구','농구'), price
FROM book;

--Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자수,바이트 수를 보이시오
SELECT bookname 제목,LENGTH(bookname) 글자수,LENGTHB(bookname) 바이트수
FROM book
WHERE publisher ='굿스포츠';

--Q.
SELECT * FROM customer
INSERT INTO customer VALUES(5,'박세리','대한민국 대전',NULL);

SELECT SUBSTR(name,1,1) 성 ,count(*)인원
FROM customer 
GROUP BY SUBSTR(name,1,1);

--Q. 마다서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
SELECT	orderid 주문번호, orderdate 주문일, orderdate+10 확정
FROM	orders;

-- 22 
SELECT a.*, a.orderdate + 10 확정일자 
FROM orders a;





--Q. 마당서점이 7월 7일 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
-- 단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT	orderid 주문번호, TO_CHAR(orderdate, 'yyyy-mm-dd day') 주문일,custid 고객번호, bookid 도서번호
FROM	orders
WHERE      orderdate= TO_DATE('200707');

SELECT orderid 주문번호, TO_CHAR(orderdate,'YYYY-MM-DD DAY') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '20/07/07';



-- DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT sysdate, TO_CHAR(sysdate, 'yy/mm/dd hh:mm:ss') 
FROM dual;
--  yy/mm/dd hh:mm:ss  --> yy/mm/dd hh:mi:ss (현재시간)


 
-- [질의 4-10] 이름, 전화번호가 포함된 고객목록을 보이시오. 
-- 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시한다.
SELECT	name "이름", REPLACE(phone,NULL,'연락처없음') 전화번호
FROM	customer;


-- 현재 접속 사용자 확인 
SELECT USER FROM DUAL;




SELECT * FROM customer;

-- customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오
UPDATE customer 
SET address = '대한민국 부산'
WHERE custid =5;

--Q. customer 테이블에서 박세리 고객의 주소를 김연악 고객의 주소로 변경
UPDATE customer
SET address= (SELECT address FROM customer WHERE name= '김연아')
WHERE name='박세리';

--Q.  customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오. 
DELETE customer
WHERE custid = 5;


--Q. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오.
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

SELECT name 이름, ISNULL(phone, '연락처없음') 전화번호
FROM customer;

SELECT name 이름, COALESCE(phone, '연락처없음') 전화번호
FROM customer;

-- 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
SELECT custid, name, phone
FROM	customer
WHERE 	ROWNUM <= 2;

SELECT *
FROM customer;


-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid 주문번호, saleprice 주문금액
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. 각 고객의  평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid, custid, saleprice
FROM orders 
WHERE saleprice > (SELECT AVG (o1.saleprice) FROM orders o1
WHERE o1.custid=o1.custid );

                      
SELECT * FROM customer;
--Q. '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

--Q. 3번 고객이 주문한 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid=3);

--Q. EXISTS 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT * FROM customer WHERE address LIKE '%대한민국%' AND
orders.custid=customer.custid);

--Q> 마당서점의 고객별 판매익을 보이시오 (고객이름과 고객별 판매액 출력)     
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
ALTER TABLE orders ADD bookname VARCHAR(40);

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




CREATE VIEW vw__customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

--Q. orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 
-- '김연아'고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW	vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT	od.orderid, od.custid, cs.name,
		od.bookid, bk.bookname, od.saleprice, od.orderdate
	FROM	Orders od, customer cs, Book bk
	WHERE	od.custid=cs.custid AND od.bookid=bk.bookid;

SELECT	orderid, bookname, saleprice
FROM	vw_orders
WHERE	name ='김연아';

--과제
--Q.앞서 생성한 뷰 vw_Customer를 삭제하시오.

-- LAST FIRST 연결 
SELECT * FROM EMPLOYEES;
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name ||' is a '|| job_id FROM employees;

--중복제거
SELECT DISTINCT job_id FROM employees;
-- null값 확인
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--employees 테이블에서 commission_pct의 null값 개수를 출력
SELECT count(*)
FROM employees
WHERE commission_pct is null;

--숫자함수 number function 
SELECT MOD (10,3) FROM dual;

-- employee id 가 홀수인 것 뽑기 
SELECT * 
FROM EMPLOYEES
WHERE MOD(employee_id,2)=1;

SELECT ROUND(355.95555,0) 반올림 FROM dual;
SELECT ROUND(355.95555,2) 반올림 FROM dual;
SELECT ROUND(355.95555,-1) 반올림 FROM dual;

SELECT TRUNC(45.5555,1) 버림 FROM dual;
SELECT ROUND(45.5555,1) 반올림 FROM dual;

SELECT last_name, TRUNC(salary/12,2) 월급 FROM employees;

--width_bucket(지정값,최소값,최대값,bucket갯수)
SELECT WIDTH_BUCKET( 92,0,100,10) FROM dual;

--문자함수 Character Function 
SELECT UPPER('Hello World') FROM dual;
SELECT LOWER('Hello World') FROM dual;


-- lastname이 'seo'인 사람 찾기 
SELECT last_name, salary
FROM employees
WHERE LOWER(last_name)='seo';

--길이
SELECT job_id, LENGTH(job_id) FROM employees;

== SUBSTR(문자열, 시작위치, 갯수) : 3번째 문자부터 3개 출력
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

-- 오른쪽 정렬 후 왼쪽에 문자를 채운다.
SELECT LPAD('Hello World',20,'#') FROM dual;

-- 오른쪽 정렬 후 왼쪽에 문자를 채운다.
SELECT RPAD('Hello World',20,'#') FROM dual;


SELECT last_name, trim('A' FROM last_name) A삭제 FROM employees;

SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

SELECT TRIM('   Hello WOrld   ') FROM dual;



-- 날짜 관련 함수
SELECT sysdate FROM dual;

select * from employees;
select last_name, trunc((sysdate-hire_date)/365,0) 근속연수 FROM employees;

SELECT last_name, add_months(hire_date,6) FROM employees;




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



SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'월') "6개월 후 첫번째 월요일"
FROM EMPLOYEES;

-- Q. 입사일 6개월 후 첫 번째 월요일을 직원이름별로 출력하세요.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'월') FROM employees ORDER BY last_name;


SELECT job_id, SUM(salary) 연봉합계, AVG(salary) 연봉평균, MAX(salary) 최고연봉, MIN(salary) 최저연봉
FROM employees
GROUP BY job_id;

SELECT E.employee_id, E.last_name, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id AND E.employee_id = 110;



--사원번호가 110인 사원의 부서명ㅇ을 알고싶은 경우
-- WHERE 사용
SELECT department_name FROM employees E, departments D WHERE E.department_id = D.department_id AND employee_id=110;

-- JOIN 사용
SELECT department_name FROM employees E join departments D on E.department_id=D.department_id WHERE employee_id=110;


-- WHERE 사용
SELECT department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.employee_id = 110;

-- JOIN 사용
SELECT department_name
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
WHERE employee_id = 110;



--사원번호가 110인 사원의 사번,이름,업무,업무명을 출력
-- WHERE
SELECT employee_id 사번, last_name 이름, J.job_id 업무, J.job_title 업무명
FROM employees E, jobs J
WHERE employee_id=120 AND E.job_id = J.job_id;

-- JOIN
SELECT employee_id 사번, last_name 이름, J.job_id 업무, job_title 업무명
FROM employees E JOIN jobs J ON E.job_id = J.job_id
WHERE employee_id = 120;



SELECT city, region_name, country_name
FROM countries C, regions R, locations L
WHERE C.region_id = R.region_id AND
C.country_id = L.country_id;

SELECT department_name 부서명, last_name 매니저명, street_address 주소
FROM departments D, employees E, locations L
WHERE D.location_id = L.location_id
AND D.manager_id = E.employee_id;

SELECT E.last_name, L.city, L.street_address FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.department_id = D.department_id AND L.location_id = D.location_id;

SELECT  department_name, job_title, start_date, end_date 
FROM departments D,job_history JH ,jobs J
WHERE d.department_id = jh.department_id
AND jh.job_id = j.job_id;

.




--Q. 2005년 이후에 입사한 직원의 사번, 이름, 입사일, 부서명,업무명을 출력
SELECT E.employee_id 사번, E.first_name || ' ' || E.last_name 이름, E.hire_date 입사일, D.department_name 부서명,J.job_title
FROM employees E ,jobs J,departments D
WHERE E.hire_date > '05/01/01' AND E.department_id = D.department_id AND E.job_id = J.job_id;

--''
SELECT employee_id 사번, last_name 이름, hire_date 입사일, department_name 부서명, job_title 업무명
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id AND hire_date > '2005/01/01'
ORDER BY hire_date;



--Q2. job_title, department_name 별로 평균 연봉을 구한 후 출력하세요.
SELECT j.job_title, d.department_name ,ROUND(AVG(E.salary),2) 평균연봉
FROM departments D, employees E, jobs J
WHERE j.job_id = e.job_id
AND e.department_id = d.department_id
GROUP BY j.job_title, d.department_name;

--Q3. 평균보다 많은 급여를 받는 직원 검색 후 출력
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q4. last_name이 king인 직원의 last_name, hire_date, department_id를 출력
SELECT last_name, hire_date, department_id
FROM employees
WHERE last_name = 'King';


--Q5. 사번 이름 직급 출력, 직급은 아래 기준에 의함 
-- salary > 20000 THEN '대표이사'
-- salary > 15000 THEN '이사'
-- salary > 10000 THEN '부장'
-- salary > 5000 THEN '과장'
-- salary > 3000 THEN '대리'
SELECT employee_id 사번, last_name 이름, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0) 근속연수,
CASE
WHEN salary > 20000 THEN '대표이사'
WHEN salary > 15000 THEN '이사'
WHEN salary > 10000 THEN '부장'
WHEN salary > 5000 THEN '과장'
WHEN salary > 3000 THEN '대리'
ELSE '사원'
END AS 직급
FROM employees;

-- Q6. employee 테이블로부터 last_name, salary, 최고연봉을 출력하세요
-- 단, 최고연봉은 first_value ~ over 로 구한다.
SELECT last_name, salary,  FIRST_VALUE(salary) OVER()  최고연봉
FROM employees
ORDER BY salary DESC;


--Q7. 부서별 연봉 순위 
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

--Q10. last_name을 name으로 변경하세요.
ALTER TABLE employee_salary RENAME COLUMN last_name To name;

--Q11. employees_salary테이블의 employee_id에 기본키를 적용하고 constaint_name을 es_pk로 지정후 출력
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES_SALARY';





