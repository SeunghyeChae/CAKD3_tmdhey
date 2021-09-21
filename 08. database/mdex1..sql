SELECT * FRom Book;
SElect bookname, price from book;

--[���� 3-2] ��� �����Ǥ�������ȣ,�����̸�, ���ǻ�,���� �˻�
select bookid,bookname,publisher,price
from book;

select publisher from book;

SELECT publisher from book;

SELECT DISTINCT publisher FROM book;

SELECT *
FROM book
WHERE price<10000;

--Q. ���� 10000<x<20000 ���� �˻� 
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price>=10000 AND price<=20000;


--Q ���ǻ簡 '�½�����'Ȥ�� '���ѹ̵��'�� ���� �˻� 
SELECT *
FROM book
WHERE (publisher='�½�����') OR (publisher ='���ѹ̵��');

SELECT *
FROM book
WHERE publisher IN('�½�����','���ѹ̵��');

SELECT *
FROM book
WHERE publisher NOT IN('�½�����','���ѹ̵��');

-- �̷� ������ �� �� �̱� 
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '�౸�� ����';

-- Q . �����̸��� '�౸' ���Ե� ���ǻ� �˻� 
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%�౸%';


--Q . �����̸��� ���� �ι�° ��ġ�� '��'��� ���ڿ��� ���� ������ �˻��ϼ��� 
SELECT bookname,publisher
FROM book
WHERE bookname LIKE '_��%';

--Q. �౸�� ���� ������ ������ 20,000�� �̻��� ������ �˻��ϼ���.
SELECT bookname,price
FROM book
WHERE bookname LIKE '%�౸%' AND price>=20000;

-- ������ �̸������� ����
SELECT *
FROM book
ORDER BY bookname; 

-- ������ ���ݼ����� �˻�/ ������ ������ �̸������� �˻�
SELECT *
FROM book
ORDER BY price,bookname; 

-- Q. ������ ������ ������������ �˻��Ͻÿ�, ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�
SELECT *
FROM book
ORDER BY price DESC, publisher;


SELECT * FROM orders;
SELECT SUM(saleprice) AS �Ѹ���
FROM orders;

--Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
SELECT SUM (saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid =2;

-- �ּ��ִ� 
SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

SELECT COUNT(*)
FROM orders;


-- �� �Ǹž� (�÷� ������ �޸����/ �Լ���� ����/ ���ڸԾ� ;
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--Q. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
-- ��, �� �� �̻� ������ ���� ���Ͻÿ�.

SELECT custid, SUM(saleprice)AS �Ѹ���
FROM orders
WHERE saleprice>=10000
GROUP BY custid
HAVING SUM(saleprice)>=30000;



SELECT *
FROM customer c, orders o
WHERE c.custid=o.custid;



-- Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

-- Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;













--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid; 

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
SELECT customer.name, book.bookname
FROM customer, Orders, Book
WHERE customer.custid =Orders.custid
AND orders.bookid =Book.bookid;



--Q. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE customer.custid =orders.custid AND orders.bookid =book.bookid
AND orders.saleprice =20000;

--SELECT C.name, B.bookname
--FROM book B, customer C, orders O
--WHERE C.custid=O.custid AND O.bookid AND B.price=20000;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
SELECT customer.name, saleprice
FROM customer LEFT OUTER JOIN
orders ON customer.custid= orders.custid;

-- ''
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid=O.custid(+);


-- ''
SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;




--Q. ���� ��� ������ �̸��� ���̽ÿ�.
SELECT bookname
FROM book
WHERE price = ( SELECT MAX(price)) 
FROM book;






--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���
select name
from customer
where custid in (select custid from orders);


--Q. '���ѹ̵��'�ּ� ������ ������ ������ ���� �̸��� ���̽ÿ�.
select name
from customer
where custid in (select custid
                 from orders
                 where bookid in (select bookid
                                  from book
                                  where publisher='���ѹ̵��'));

--''
SELECT name
FROM customer 
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher ='���ѹ̵��'));


--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                  from book b2
                  where b2.publisher=b1.publisher); 
                  
-- ''
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT  avg(b2.price)
FROM book b2 WHERE b2.publisher=b1.publisher);
                  
                  
 
--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT name 
FROM customer
MINUS
SELECT name 
FROM customer 
WHERE custid IN(SELECT custid FROM orders);




--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name, address
FROM customer cs
WHERE custid EXISTS (SELECT *
              FROM orders od
              WHERE cs.custid=od.custid);
              
              
--''
SELECT DISTINCT c.name , c.address
FROM customer c, orders o
WHERE o.custid = c.custid;







-- ------------------------------------------------------
CREATE TABLE newbook(
bookid    NUMBER, -- ������
bookname  varchar2(20) NOT NULL, --����/20����Ʈ 
publisher varchar2(20)UNIQUE,
price     NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));
DROP TABLE newbook;

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
adress VARCHAR2(40),
phone VARCHAR2(30));


CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NO
PRIMARY KEY (orderid), FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE
);



ALTER TABLE newbook ADD isbn VARCHAR2(15);


--Q.Newbook ���̺��� isbn �Ӽ��� ������ Ÿ���� NUMBER������ �����Ͻÿ�.
DESCRIBE NEWBOOK;
ALTER TABLE NewBook MODIFY isbn NUMBER;

--Q.Newbook ���̺��� isbn �Ӽ��� �����Ͻÿ�.
ALTER TABLE NewBook DROP COLUMN isbn;

--Q.Newbook ���̺��� bookid �Ӽ��� NOT NULL ���������� �����Ͻÿ�.
ALTER TABLE NewBook MODIFY bookid NUMBER NOT NULL;

--Q.Newbook ���̺��� bookid �Ӽ��� �⺻Ű�� �����Ͻÿ�.
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

--Q.Newbook ���̺��� �����Ͻÿ�.
--DROP TABLE NewBook;




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
