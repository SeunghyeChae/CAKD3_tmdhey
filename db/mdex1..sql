SELECT * FRom Book;
SElect bookname, price from book;

--[질의 3-2] 모든 도시의ㄷ도서번호,도서이름, 출판사,가격 검색
select bookid,bookname,publisher,price
from book;

select publisher from book;

SELECT publisher from book;

SELECT DISTINCT publisher FROM book;

SELECT *
FROM book
WHERE price<10000;

--Q. 가격 10000<x<20000 도서 검색 
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price>=10000 AND price<=20000;


--Q 출판사가 '굿스포츠'혹은 '대한미디어'인 도서 검색 
SELECT *
FROM book
WHERE (publisher='굿스포츠') OR (publisher ='대한미디어');

SELECT *
FROM book
WHERE publisher IN('굿스포츠','대한미디어');

SELECT *
FROM book
WHERE publisher NOT IN('굿스포츠','대한미디어');

-- 이런 패턴이 들어간 것 뽑기 
SELECT bookname, publisher 
FROM book
WHERE bookname LIKE '축구의 역사';

-- Q . 도서이름에 '축구' 포함된 출판사 검색 
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%축구%';


--Q . 도서이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서를 검색하세요 
SELECT bookname,publisher
FROM book
WHERE bookname LIKE '_구%';

--Q. 축구에 관한 도서중 가격이 20,000원 이상인 도서를 검색하세요.
SELECT bookname,price
FROM book
WHERE bookname LIKE '%축구%' AND price>=20000;

-- 도서를 이름순으로 정렬
SELECT *
FROM book
ORDER BY bookname; 

-- 도서를 가격순으로 검색/ 가격이 같으면 이름순으로 검색
SELECT *
FROM book
ORDER BY price,bookname; 

-- Q. 도서를 가격의 ㅐ림차순으로 검색하시오, 만약 가격이 같다면 출판사의 오름차순으로 출력하시오
SELECT *
FROM book
ORDER BY price DESC, publisher;


SELECT * FROM orders;
SELECT SUM(saleprice) AS 총매출
FROM orders;

--Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오
SELECT SUM (saleprice) AS "총 판매액"
FROM orders
WHERE custid =2;

-- 최소최대 
SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

SELECT COUNT(*)
FROM orders;


-- 총 판매액 (컬럼 지정시 콤마사용/ 함수사용 엔터/ 머자먹애 ;
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--Q. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
-- 단, 두 권 이상 구매한 고객만 구하시오.

SELECT custid, SUM(saleprice)AS 총매출
FROM orders
WHERE saleprice>=10000
GROUP BY custid
HAVING SUM(saleprice)>=30000;



SELECT *
FROM customer c, orders o
WHERE c.custid=o.custid;



-- Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

-- Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;













--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid; 

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
SELECT customer.name, book.bookname
FROM customer, Orders, Book
WHERE customer.custid =Orders.custid
AND orders.bookid =Book.bookid;



--Q. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE customer.custid =orders.custid AND orders.bookid =book.bookid
AND orders.saleprice =20000;

--SELECT C.name, B.bookname
--FROM book B, customer C, orders O
--WHERE C.custid=O.custid AND O.bookid AND B.price=20000;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
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




--Q. 가장 비싼 도서의 이름을 보이시오.
SELECT bookname
FROM book
WHERE price = ( SELECT MAX(price)) 
FROM book;






--Q. 도서를 구매한 적이 있는 고객의 이름을 검색하세요
select name
from customer
where custid in (select custid from orders);


--Q. '대한미디어'애서 출판한 도서를 구매한 고객의 이름을 보이시오.
select name
from customer
where custid in (select custid
                 from orders
                 where bookid in (select bookid
                                  from book
                                  where publisher='대한미디어'));

--''
SELECT name
FROM customer 
WHERE custid IN(SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher ='대한미디어'));


--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
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
                  
                  
 
--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT name 
FROM customer
MINUS
SELECT name 
FROM customer 
WHERE custid IN(SELECT custid FROM orders);




--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
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
bookid    NUMBER, -- 숫자형
bookname  varchar2(20) NOT NULL, --문자/20바이트 
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


--Q.Newbook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.
DESCRIBE NEWBOOK;
ALTER TABLE NewBook MODIFY isbn NUMBER;

--Q.Newbook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE NewBook DROP COLUMN isbn;

--Q.Newbook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE NewBook MODIFY bookid NUMBER NOT NULL;

--Q.Newbook 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE NewBook ADD PRIMARY KEY(bookid);

--Q.Newbook 테이블을 삭제하시오.
--DROP TABLE NewBook;




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
