--����� ���� TEST
CREATE USER C##TEST
IDENTIFIED BY TEST
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

--���� �ο�
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;

--����� ��ȣ ����
ALTER USER C##TEST
IDENTIFIED BY TEST1;

--���� ȸ��
REVOKE CREATE SYNONYM FROM C##TEST;
REVOKE CREATE SESSION, CREATE TABLE, CREATE VIEW  FROM C##TEST;

--����
DROP USER C##TEST;

DROP USER C##TEST CASCADE;
CREATE USER C##TEST IDENTIFIED BY TEST DEFAULT TABLESPACE users 
TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;
ALTER USER C##TEST ACCOUNT UNLOCK;  
--PROFILE�� DEFAULT�� �����ϰ� �Ǹ� ��� �ڿ��� ������ ����� �� �ְ� �ȴ�.
--  : ��, ����Ŭ ��ġ�� DBA� ���Ͽ� DEFAULT PROFILE�� ������ ���� ������
--    PROFILE�� ����ǰ� �ȴ�.

SELECT USERNAME
,ACCOUNT_STATUS
,LOCK_DATE
,EXPIRY_DATE
,DEFAULT_TABLESPACE
FROM DBA_USERS
WHERE USERNAME = 'C##TEST';

DROP USER C##TEST CASCADE;
--CASCADE�� ����ϰ� �Ǹ� ����� �̸��� ���õ� ��� �����ͺ��̽� ��Ű���� ������ �������κ��� �����Ǹ� 
--��� ��Ű�� ��ü�� ���� ���������� ���� �ȴ�.

DROP TABLE MEMBER;
CREATE TABLE MEMBER 
(
   ID                VARCHAR2(50) NOT NULL,
   PWD               VARCHAR2(50),
   NAME              VARCHAR2(50),
   GENDER            NCHAR(2),  --���ڼ�
   AGE               NUMBER,
   BIRTHDAY          CHAR(10),  --2000-01-02 
   PHONE             CHAR(13), --010-1234-2345
   REGDATE           DATE
);

INSERT INTO MEMBER (ID, PWD, NAME) VALUES('200901','111','kevin');
INSERT INTO MEMBER VALUES('200901','111','shin','����',24,'1998-01-01','010-0000-0000',SYSDATE);

SELECT * FROM MEMBER;

--Q. MEMBER ���̺��� �����ؼ� MEMBER1 ���̺��� ���� �� ����ϼ���.
DROP TABLE MEMBER1;
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
SELECT * FROM MEMBER1;

SELECT * FROM TABS;
INSERT INTO MEMBER1 (ID, PWD, NAME) VALUES('200901','111','kevin');
INSERT INTO MEMBER1 (ID, PWD, NAME, GENDER) VALUES('200902','123','dragon','����');

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

--COMMIT, ROLLBACK
Drop TABLE Users;
CREATE TABLE Users 
( id	NUMBER,
  name	VARCHAR2(20),
  age	NUMBER);
  
INSERT INTO Users VALUES (1, 'HONG GILDONG', 30);
SELECT * FROM users;
DELETE FROM users WHERE id=1;
ROLLBACK;
COMMIT;
