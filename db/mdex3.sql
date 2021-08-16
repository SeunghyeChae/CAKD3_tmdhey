-- ����� ����
-- test��� ���� ���� CDB�� C##�����̸� , PDB�� �����̸�
CREATE USER C##TEST
IDENTIFIED BY test
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;     --����, SYS����


-- ���� �ο�
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;


-- ����� ��ȣ ����
ALTER USER C##TEST 
IDENTIFIED BY test1;


-- ���� ȸ��
REVOKE CREATE SYNONYM FROM C##TEST;     -- ��Ī ��� ����
REVOKE CREATE SESSION, CREATE TABLE, CREATE VIEW FROM C##TEST;


-- ����� ����
DROP USER C##TEST;


drop user c##test cascade;


--�ѹ��� 
drop user C##TEST cascade;
create user C##TEST identified by test default TABLESPACE users
temporary tablespace temp profile default;
grant connect, resource to C##TEST;
grant create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;
alter user C##TEST account unlock;

--PROFILE�� DEFAULT�� �����ϰ� �Ǹ� ��� �ڿ��� ������ ����� �� �ְ� �ȴ�
--    ��, ����Ŭ ��ġ �� DBA� ���Ͽ� DEFAULT PROFILE�� ������ ���� 
--    ������ PROFILE�� ����ǰ� �ȴ�



select username
,account_status
,lock_date
,expiry_date
,default_tablespace
from dba_users
where username= 'C##test';

drop user C##test cascade;
-- casecade�� ����ϰ� �Ǹ� ����� �̸��� ���õ� ��� �����ͺ��̽� ��Ű���� ������ �������κ��� �����Ǹ�
-- ��� ��Ű�� ��ü�� ���� ���������� �����ȴ�. 

drop table member;
create table member(
ID varchar2(50) not null,
PWD varchar(50),
NAME varchar(50),
GENDER NCHAR(2),  --���ڼ�
AGE number,
BIRTHDAY CHAR(10), --2000-01-02
PHONE CHAR(13), --010-2222-2222
REGDATE date
);

--INSERT INTO MEMBER(ID, PWD, NAME) VALUES(200901, 1111, 'kevin');
INSERT INTO MEMBER VALUES('shin','1111','ddd','����',24,'1998-01-01','010-0000-0000',SYSDATE);
select * from member;


--Q. member ���̺��� �����ؼ� member1���̺��� ���� �� ����ϼ���
drop table member1;
CREATE TABLE member1 AS SELECT * FROM member;
SELECT * FROM MEMBER1;

select * from TABS;
insert into member1 (ID,PWD,NAME) VALUES('200901','111','kevin');
insert into member1 (ID,PWD,NAME,GENDER) VALUES('200902','111','dragon','����');


--����
--Q1.ID, NAME�� �ڷ� ũ�� ������ ���ڼ� �������� �����ϼ���.
--Nchar , Nvarchar2	ũ���� ������ Byte�� �ƴ϶� ���ڼ��� ��Ÿ��
ALTER TABLE MEMBER1 MODIFY( ID NVARCHAR2(50), NAME NVARCHAR2(50));

--Q2.PWD�� �������� NOT NULL�� �߰��ϰ� �������� �̸��� MEMBER1_NN���� �����ϼ���.
ALTER TABLE MEMBER1 MODIFY(PWD CONSTRAINT MEMBER1_NN NOT NULL);

--Q3.BIRTHDAY �÷� �̸��� BD�� �����ϼ���.
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;

--Q4.AGE �÷��� �����ϼ���.
ALTER TABLE MEMBER1 DROP COLUMN AGE;

--Q5.TEXT �÷��� �߰��ϼ���. �� �ڷ� ���´� NCLOB
ALTER TABLE MEMBER1 ADD TEXT NCLOB;
INSERT INTO MEMBER1 (ID,PWD, TEXT) VALUES('200903','234','��ġ�� ������ ���� �����Ѵ�');

--Q6.ID�� �������� �̸� MEMBER_PK�� �⺻Ű�� �����ϼ���.
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER_PK PRIMARY KEY (ID);

--Q7. ID�� ������ �⺻Ű ���������� �����ϼ���.
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK;

--Q8. MEMBER1�� ��� ���� �����ϼ���.
TRUNCATE TABLE MEMBER1;

--
drop table Users;
Create table users(
    id   number,
    name varchar2(20),
    age number);
    
insert into users values (1, 'HONG GILDONG',30);
select * from users;
delete from users where id=1;

rollback;
commit;