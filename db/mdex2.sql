--���밪
SELECT ABS(-78), ABS(+78) 
FROM dual;

--�ݿø�
SELECT ROUND(4.875,1)
FROM dual;


--Q. ���� ��� �ֹ� �ݾ��� ��������� �ݿø��� ��
SELECT ROUND(SUM(saleprice)/COUNT(*),-2) AS ��ձݾ�
FROM orders
GROUP BY custid;

--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�
SELECT REPLACE(bookname,'�߱�','��'), price
FROM book;

--Q. '�½�����'���� ������ ������ ����� ������ ���ڼ�,����Ʈ ���� ���̽ÿ�
SELECT bookname ����,LENGTH(bookname) ���ڼ�,LENGTHB(bookname) ����Ʈ��
FROM book
WHERE publisher ='�½�����';

--Q.
SELECT * FROM customer
INSERT INTO customer VALUES(5,'�ڼ���','���ѹα� ����',NULL);

SELECT SUBSTR(name,1,1) �� ,count(*)�ο�
FROM customer 
GROUP BY SUBSTR(name,1,1);

--Q. ���ټ����� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
SELECT	orderid �ֹ���ȣ, orderdate �ֹ���, orderdate+10 Ȯ��
FROM	orders;

-- 22 
SELECT a.*, a.orderdate + 10 Ȯ������ 
FROM orders a;





--Q. ���缭���� 7�� 7�� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
-- �� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT	orderid �ֹ���ȣ, TO_CHAR(orderdate, 'yyyy-mm-dd day') �ֹ���,custid ����ȣ, bookid ������ȣ
FROM	orders
WHERE      orderdate= TO_DATE('200707');

SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate,'YYYY-MM-DD DAY') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '20/07/07';



-- DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT sysdate, TO_CHAR(sysdate, 'yy/mm/dd hh:mm:ss') 
FROM dual;
--  yy/mm/dd hh:mm:ss  --> yy/mm/dd hh:mi:ss (����ð�)


 
-- [���� 4-10] �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. 
-- ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ѵ�.
SELECT	name "�̸�", REPLACE(phone,NULL,'����ó����') ��ȭ��ȣ
FROM	customer;


-- ���� ���� ����� Ȯ�� 
SELECT USER FROM DUAL;




SELECT * FROM customer;

-- customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�
UPDATE customer 
SET address = '���ѹα� �λ�'
WHERE custid =5;

--Q. customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� ����
UPDATE customer
SET address= (SELECT address FROM customer WHERE name= '�迬��')
WHERE name='�ڼ���';

--Q.  customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�. 
DELETE customer
WHERE custid = 5;


--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ���Ͻÿ�.
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

SELECT name �̸�, ISNULL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

SELECT name �̸�, COALESCE(phone, '����ó����') ��ȭ��ȣ
FROM customer;

-- �� ��Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
SELECT custid, name, phone
FROM	customer
WHERE 	ROWNUM <= 2;

SELECT *
FROM customer;


-- ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, saleprice �ֹ��ݾ�
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--Q. �� ����  ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid, custid, saleprice
FROM orders 
WHERE saleprice > (SELECT AVG (o1.saleprice) FROM orders o1
WHERE o1.custid=o1.custid );

                      
SELECT * FROM customer;
--Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

--Q. 3�� ���� �ֹ��� �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid=3);

--Q. EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders
WHERE EXISTS(SELECT * FROM customer WHERE address LIKE '%���ѹα�%' AND
orders.custid=customer.custid);

--Q> ���缭���� ���� �Ǹ����� ���̽ÿ� (���̸��� ���� �Ǹž� ���)     
SELECT (SELECT name FROM customer C WHERE C.custid=O.custid) name,
SUM(saleprice) total FROM orders O
GROUP BY O.custid;

SELECT C.name, SUM(O.saleprice)
FROM orders O, customer C
WHERE O.custid = C.custid
GROUP BY C.name;

SELECT C.name ���̸�, NVL(SUM(O.saleprice),0) "���� �Ǹž�"
FROM customer C, orders O
WHERE c.custid = o.custid(+) 
GROUP BY c.name;

SELECT * FROM orders;
ALTER TABLE orders ADD bookname VARCHAR(40);

UPDATE orders
SET bookname=(SELECT bookname FROM book WHERE book.bookid=orders.bookid);

--����
--Q.����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).
SELECT	cs.name, SUM(od.saleprice) "total"
FROM	(SELECT   custid, name
		 FROM     customer
		 WHERE   custid <= 2) cs,
		Orders	od
WHERE	cs.custid=od.custid
GROUP BY	cs.name;

--Q.�ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.
DROP VIEW vw_customer;
CREATE VIEW	vw_Customer
AS SELECT		*
	FROM		Customer
	WHERE		address LIKE '%���ѹα�%';

--Q.Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, ���迬�ơ� ���� ������ 
--������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.

CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT * 
FROM vw_customer;

--Q.Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, 
--���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW	vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT	od.orderid, od.custid, cs.name,
			od.bookid, bk.bookname, od.saleprice, od.orderdate
    FROM	Orders od, Customer cs, Book bk
	WHERE	od.custid=cs.custid AND od.bookid=bk.bookid;

SELECT * FROM vw_orders;

SELECT	orderid, bookname, saleprice
FROM	vw_Orders
WHERE	name ='�迬��';
--����
--Q.�ռ� ������ �� vw_Customer�� �����Ͻÿ�.

SELECT * FROM employees;
SELECT last_name, 'is a', job_id from employees;
SELECT last_name ||' is a '|| job_id from employees;




CREATE VIEW vw__customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

--Q. orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, 
-- '�迬��'���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW	vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT	od.orderid, od.custid, cs.name,
		od.bookid, bk.bookname, od.saleprice, od.orderdate
	FROM	Orders od, customer cs, Book bk
	WHERE	od.custid=cs.custid AND od.bookid=bk.bookid;

SELECT	orderid, bookname, saleprice
FROM	vw_orders
WHERE	name ='�迬��';

--����
--Q.�ռ� ������ �� vw_Customer�� �����Ͻÿ�.

-- LAST FIRST ���� 
SELECT * FROM EMPLOYEES;
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name ||' is a '|| job_id FROM employees;

--�ߺ�����
SELECT DISTINCT job_id FROM employees;
-- null�� Ȯ��
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--employees ���̺��� commission_pct�� null�� ������ ���
SELECT count(*)
FROM employees
WHERE commission_pct is null;

--�����Լ� number function 
SELECT MOD (10,3) FROM dual;

-- employee id �� Ȧ���� �� �̱� 
SELECT * 
FROM EMPLOYEES
WHERE MOD(employee_id,2)=1;

SELECT ROUND(355.95555,0) �ݿø� FROM dual;
SELECT ROUND(355.95555,2) �ݿø� FROM dual;
SELECT ROUND(355.95555,-1) �ݿø� FROM dual;

SELECT TRUNC(45.5555,1) ���� FROM dual;
SELECT ROUND(45.5555,1) �ݿø� FROM dual;

SELECT last_name, TRUNC(salary/12,2) ���� FROM employees;

--width_bucket(������,�ּҰ�,�ִ밪,bucket����)
SELECT WIDTH_BUCKET( 92,0,100,10) FROM dual;

--�����Լ� Character Function 
SELECT UPPER('Hello World') FROM dual;
SELECT LOWER('Hello World') FROM dual;


-- lastname�� 'seo'�� ��� ã�� 
SELECT last_name, salary
FROM employees
WHERE LOWER(last_name)='seo';

--����
SELECT job_id, LENGTH(job_id) FROM employees;

== SUBSTR(���ڿ�, ������ġ, ����) : 3��° ���ں��� 3�� ���
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

-- ������ ���� �� ���ʿ� ���ڸ� ä���.
SELECT LPAD('Hello World',20,'#') FROM dual;

-- ������ ���� �� ���ʿ� ���ڸ� ä���.
SELECT RPAD('Hello World',20,'#') FROM dual;


SELECT last_name, trim('A' FROM last_name) A���� FROM employees;

SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

SELECT TRIM('   Hello WOrld   ') FROM dual;



-- ��¥ ���� �Լ�
SELECT sysdate FROM dual;

select * from employees;
select last_name, trunc((sysdate-hire_date)/365,0) �ټӿ��� FROM employees;

SELECT last_name, add_months(hire_date,6) FROM employees;




--Ư�� ���� ���� ���� ��¥�� ���Ѵ�.
SELECT last_name, ADD_MONTHS(hire_date,6) FROM employees;

--�ش� ��¥�� ���� ���� ��������ȯ�ϴ� �Լ�
SELECT LAST_DAY(SYSDATE) FROM dual;
--������ ����
SELECT last_name,hire_date,LAST_DAY(ADD_MONTHS(hire_date,1)) FROM employees; 
--�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ(�� ~ ��, 1 ~ 7)
SELECT hire_date, next_day(hire_date,'��') FROM employees;
SELECT hire_date, next_day(hire_date,2) FROM employees;

-- months_between()		��¥�� ��¥ ������ �������� ���Ѵ�.
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) �ټӿ��� FROM employees;

--Q.�Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),2) D_DAY FROM employees;

--�����Լ� Aggregate Functions : sum() avg() max() min()
--Q.job_id ���� �����հ� ������� �ְ��� �������� ���
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ����
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ������������ ����
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;

--���� Join
--�����ȣ�� 110�� ����� �μ����� �˰� ���� ���
SELECT * FROM employees WHERE employee_id=110;
SELECT * FROM departments WHERE department_id=100;

SELECT employee_id, department_name FROM employees E, departments D 
WHERE E.department_id = D.department_id AND employee_id=110;

-- JOIN ���
SELECT employee_id, department_name 
FROM employees E 
join departments D on E.department_id=D.department_id 
WHERE employee_id=110;

--Q.����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
--join~on, where �� �����ϴ� �� ���� ��� ���.
SELECT E.employee_id, E.last_name, E.job_id, J.job_title
FROM employees E, jobs J
WHERE E.job_id = J.job_id AND E.employee_id = 120;

SELECT employee_id, last_name, E.job_id, job_title
FROM employees E JOIN jobs J ON E.job_id=J.job_id 
WHERE employee_id=120;

--������ ���̺� ����
SELECT employee_id, job_title, department_name 
FROM employees E, jobs J, departments D
WHERE E.job_id = J.job_id
AND E.department_id = D.department_id;

SELECT R.region_name ��� , C.country_id ����, L.street_address �ּ�
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

--self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
SELECT E.employee_id ���, E.last_name �̸�, M.last_name, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id;

--outer join : ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
SELECT E.employee_id ���, E.last_name �̸�, M.last_name ���, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+);

--UNION( ������ ) INTERSECT( ������ ) MINUS( ������ ) UNION ALL( �ߺ� ���� )
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
UNION
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary > 15000
MINUS
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary > 15000
INTERSECT
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

--all : ���� ������ �� ������ ���� ������ �˻� ������� ��� ��ġ�ϸ� ��.
--Q.100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ����� ���
SELECT last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id =100);

--any : ���� ������ �� ������ ���� ������ �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
SELECT last_name, salary FROM employees WHERE salary > any
(SELECT salary FROM employees WHERE department_id = 100);



SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE,6),'��') "6���� �� ù��° ������"
FROM EMPLOYEES;

-- Q. �Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'��') FROM employees ORDER BY last_name;


SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������
FROM employees
GROUP BY job_id;

SELECT E.employee_id, E.last_name, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id AND E.employee_id = 110;



--�����ȣ�� 110�� ����� �μ����� �˰���� ���
-- WHERE ���
SELECT department_name FROM employees E, departments D WHERE E.department_id = D.department_id AND employee_id=110;

-- JOIN ���
SELECT department_name FROM employees E join departments D on E.department_id=D.department_id WHERE employee_id=110;


-- WHERE ���
SELECT department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.employee_id = 110;

-- JOIN ���
SELECT department_name
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
WHERE employee_id = 110;



--�����ȣ�� 110�� ����� ���,�̸�,����,�������� ���
-- WHERE
SELECT employee_id ���, last_name �̸�, J.job_id ����, J.job_title ������
FROM employees E, jobs J
WHERE employee_id=120 AND E.job_id = J.job_id;

-- JOIN
SELECT employee_id ���, last_name �̸�, J.job_id ����, job_title ������
FROM employees E JOIN jobs J ON E.job_id = J.job_id
WHERE employee_id = 120;



SELECT city, region_name, country_name
FROM countries C, regions R, locations L
WHERE C.region_id = R.region_id AND
C.country_id = L.country_id;

SELECT department_name �μ���, last_name �Ŵ�����, street_address �ּ�
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




--Q. 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���,�������� ���
SELECT E.employee_id ���, E.first_name || ' ' || E.last_name �̸�, E.hire_date �Ի���, D.department_name �μ���,J.job_title
FROM employees E ,jobs J,departments D
WHERE E.hire_date > '05/01/01' AND E.department_id = D.department_id AND E.job_id = J.job_id;

--''
SELECT employee_id ���, last_name �̸�, hire_date �Ի���, department_name �μ���, job_title ������
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id AND hire_date > '2005/01/01'
ORDER BY hire_date;



--Q2. job_title, department_name ���� ��� ������ ���� �� ����ϼ���.
SELECT j.job_title, d.department_name ,ROUND(AVG(E.salary),2) ��տ���
FROM departments D, employees E, jobs J
WHERE j.job_id = e.job_id
AND e.department_id = d.department_id
GROUP BY j.job_title, d.department_name;

--Q3. ��պ��� ���� �޿��� �޴� ���� �˻� �� ���
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q4. last_name�� king�� ������ last_name, hire_date, department_id�� ���
SELECT last_name, hire_date, department_id
FROM employees
WHERE last_name = 'King';


--Q5. ��� �̸� ���� ���, ������ �Ʒ� ���ؿ� ���� 
-- salary > 20000 THEN '��ǥ�̻�'
-- salary > 15000 THEN '�̻�'
-- salary > 10000 THEN '����'
-- salary > 5000 THEN '����'
-- salary > 3000 THEN '�븮'
SELECT employee_id ���, last_name �̸�, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0) �ټӿ���,
CASE
WHEN salary > 20000 THEN '��ǥ�̻�'
WHEN salary > 15000 THEN '�̻�'
WHEN salary > 10000 THEN '����'
WHEN salary > 5000 THEN '����'
WHEN salary > 3000 THEN '�븮'
ELSE '���'
END AS ����
FROM employees;

-- Q6. employee ���̺�κ��� last_name, salary, �ְ����� ����ϼ���
-- ��, �ְ����� first_value ~ over �� ���Ѵ�.
SELECT last_name, salary,  FIRST_VALUE(salary) OVER()  �ְ���
FROM employees
ORDER BY salary DESC;


--Q7. �μ��� ���� ���� 
SELECT last_name, salary, job_id, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC) "���� ����"
FROM employees
ORDER BY job_id;

--Q8.employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����ϼ���.
CREATE TABLE employees_salary
AS SELECT employee_id, salary
FROM employees;
SELECT * FROM employees_salary;

--Q9.employees_salary ���̺� first_name, last_name �÷��� �߰��ϼ���.
ALTER TABLE employees_salary ADD (first_name VARCHAR2(40) , last_name VARCHAR2(40));
desc employees_salary;

--Q10. last_name�� name���� �����ϼ���.
ALTER TABLE employee_salary RENAME COLUMN last_name To name;

--Q11. employees_salary���̺��� employee_id�� �⺻Ű�� �����ϰ� constaint_name�� es_pk�� ������ ���
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES_SALARY';





