SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875, 1)
FROM dual;

SELECT * FROM orders;
--Q.���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT custid, ROUND(SUM(saleprice)/COUNT(*),-2) AS ��ձݾ�
FROM orders
GROUP BY custid;

--Q.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book;

--Q.���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����,length(bookname) ���ڼ�,lengthb(bookname) ����Ʈ��
FROM book
WHERE publisher ='�½�����';

SELECT * FROM customer;
INSERT INTO Customer VALUES (5, '�ڼ���', '���ѹα� ����', NULL);
--Q.���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
--group by ������ �ݵ�� �÷����� �;��ϰ�, alias �� ����� �Ұ�
SELECT SUBSTR(name,1,1) ��, COUNT(*) �ο�
FROM customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q.���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderdate �ֹ�����, orderdate+10 Ȯ������ from orders;

SELECT a.*, a.orderdate + 10 Ȯ������ 
FROM orders a;

--Q.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';

--Q.DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE, TO_CHAR(SYSDATE,'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

-- mm�� month�� �νĵ� �� �ִ� �� ����
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD HH:mm:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q.�̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

SELECT NAME �̸�, COALESCE(PHONE,'����ó����') AS ��ȭ��ȣ
FROM CUSTOMER;
 
--Q.����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <= 2;

SELECT * FROM orders;
--Q.��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

SELECT AVG(saleprice) FROM orders GROUP BY custid;
SELECT * FROM orders;
--Q.�� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid, custid, saleprice
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o1.custid=o2.custid);


--����: Ȯ�� ��                 
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders O1
WHERE O1.saleprice > (SELECT AVG(O2.saleprice) FROM orders O2 GROUP BY O1.custid);
--�� ��ü ����� ����Ǳ� ������ ���� �߻�
SELECT O1.CUSTID, AVG(O2.saleprice) FROM orders O2, orders O1 GROUP BY O1.custid;

SELECT * FROM customer;
SELECT CUSTID, ROUND(AVG(saleprice),2) ��� FROM orders GROUP BY custid;

--Q.�����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM orders O
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

SELECT SUM(SALEPRICE) �ѱݾ�
FROM CUSTOMER C, ORDERS O
WHERE (C.CUSTID = O.CUSTID) AND (C.ADDRESS LIKE '���ѹα�%');

--Q.3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid='3');

--Q.EXISTS �����ڸ� ����Ͽ� �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) total
FROM orders O
WHERE EXISTS(SELECT * FROM customer C WHERE address LIKE '%���ѹα�%' AND O.custid=C.custid);

--Q.���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).
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
ALTER TABLE orders ADD bookname VARCHAR2(40);

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

--DISTINCT
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;

--IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

--Q.EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;

--���� �Լ� Number Function
SELECT MOD(10,3) FROM dual;

--Q.EMPLOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
SELECT *
FROM employees
WHERE MOD(employee_id,2) =1;

SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

SELECT ROUND(45.5555,1) FROM dual;
SELECT TRUNC(45.5555,1) FROM dual;

SELECT last_name, TRUNC(salary/12,2) ���� FROM employees;

--WIDTH_BUCKET(������,�ּҰ�,�ִ밪,BUCKET����)
SELECT WIDTH_BUCKET(92,0,100,10) FROM dual;

--���� �Լ� Character Function 
SELECT UPPER('Hello World') FROM dual;
SELECT LOWER('Hello World') FROM dual;

select * from employees;
SELECT last_name, salary FROM employees WHERE last_name = 'seo';
SELECT last_name, salary FROM employees WHERE LOWER(last_name) = 'seo';

--Q. job_id�� ���� ���̸� ���ϼ���.
SELECT job_id, LENGTH(job_id) FROM employees;

--SUBSTR(���ڿ�, ������ġ, ����) : 3��° ���ں��� 3�����
SELECT SUBSTR('Hello World',3,3) FROM dual;
SELECT SUBSTR('Hello World',-3,3) FROM dual;

--������ ���� �� ���ʿ� ���ڸ� ä���.
SELECT LPAD('Hello World',20,'#') FROM dual;

--���� ���� �� �����ʿ� ���ڸ� ä���.
SELECT RPAD('Hello World',20,'#') FROM dual;

SELECT last_name, trim('A' FROM last_name) A���� FROM employees;
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

SELECT LTRIM('  Hello World  ') FROM dual;
SELECT RTRIM('  Hello World  ') FROM dual;
SELECT TRIM('  Hello World  ') FROM dual;

--��¥ ���� �Լ�
SELECT SYSDATE FROM dual;

select * from employees;
SELECT last_name, TRUNC((SYSDATE-hire_date)/365,0) �ټӿ��� FROM employees;

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

--����
--Q1. 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name), ������(job_title)�� ���
SELECT E.employee_id, E.last_name, hire_date, department_name, job_title
FROM employees E, departments D, jobs J
WHERE E.department_id=D.department_id AND E.job_id = J.job_id AND hire_date >= '05/01/01' 
ORDER BY hire_date;

--Q2.job_title, department_name���� ��� ������ ���� �� ����ϼ���. 
SELECT job_title ������, department_name �μ���, ROUND(AVG(salary)) "��� ����"
FROM employees E, departments D, jobs J
WHERE E.department_id = D.department_id AND E.job_id = J.job_id
GROUP BY job_title, department_name;

--Q3.��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q4.last_name�� King�� ������ last_name, hire_date, department_id�� ����ϼ���
SELECT last_name, hire_Date, department_id
FROM employees
WHERE LOWER(last_name) = 'king';

--Q5. ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'
SELECT employee_id ���, last_name �̸�, 
CASE WHEN salary > 20000 THEN '��ǥ�̻�'
     WHEN salary > 15000 THEN '�̻�'
     WHEN salary > 10000 THEN '����'
     WHEN salary > 5000 THEN '����'
     WHEN salary > 3000 THEN '�븮'
     ELSE '���'
     END AS ����
FROM employees;

--Q6.employees ���̺�� ���� last_name, salary, �ְ����� ����ϼ���.
--��, �ְ����� first_value ~ over�� ���Ѵ�.
SELECT last_name, salary, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) �ְ���
FROM employees;

--Q7.�μ��� ���� ������ ����ϼ���.
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

--Q10.last_name�� name���� �����ϼ���.
ALTER TABLE employees_salary RENAME COLUMN last_name To name;

--Q11.employees_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� �� 
--����ϼ���.
ALTER TABLE employees_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);

--Q12.employees_salary ���̺��� employee_id���� CONSTRAINT_NAME�� ������ ���� ���θ� Ȯ���ϼ���.
ALTER TABLE employees_salary DROP CONSTRAINT ES_PK;
