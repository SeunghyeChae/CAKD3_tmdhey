-- 사용자 생성
-- test라는 유저 생성 CDB는 C##유저이름 , PDB는 유저이름
CREATE USER C##TEST
IDENTIFIED BY test
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;     --권한, SYS권한


-- 권한 부여
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;


-- 사용자 암호 변경
ALTER USER C##TEST 
IDENTIFIED BY test1;


-- 권한 회수
REVOKE CREATE SYNONYM FROM C##TEST;     -- 별칭 사용 권한
REVOKE CREATE SESSION, CREATE TABLE, CREATE VIEW FROM C##TEST;


-- 사용자 삭제
DROP USER C##TEST;


drop user c##test cascade;


--한번에 
drop user C##TEST cascade;
create user C##TEST identified by test default TABLESPACE users
temporary tablespace temp profile default;
grant connect, resource to C##TEST;
grant create view, create synonym to C##TEST;
grant unlimited tablespace to C##TEST;
alter user C##TEST account unlock;

--PROFILE을 DEFAULT로 지정하게 되면 모든 자원을 무한정 사용할 수 있게 된다
--    단, 오라클 설치 후 DBA등에 의하여 DEFAULT PROFILE이 수정된 경우는 
--    수정된 PROFILE이 적용되게 된다



select username
,account_status
,lock_date
,expiry_date
,default_tablespace
from dba_users
where username= 'C##test';

drop user C##test cascade;
-- casecade를 사용하게 되면 사용자 이름과 관련된 모든 데이터베이스 스키마가 데이터 사전으로부터 삭제되며
-- 모든 스키마 객체들 또한 물리적으로 삭제된다. 

drop table member;
create table member(
ID varchar2(50) not null,
PWD varchar(50),
NAME varchar(50),
GENDER NCHAR(2),  --글자수
AGE number,
BIRTHDAY CHAR(10), --2000-01-02
PHONE CHAR(13), --010-2222-2222
REGDATE date
);

--INSERT INTO MEMBER(ID, PWD, NAME) VALUES(200901, 1111, 'kevin');
INSERT INTO MEMBER VALUES('shin','1111','ddd','남자',24,'1998-01-01','010-0000-0000',SYSDATE);
select * from member;


--Q. member 테이블을 복사해서 member1테이블을 생성 후 출력하세요
drop table member1;
CREATE TABLE member1 AS SELECT * FROM member;
SELECT * FROM MEMBER1;

select * from TABS;
insert into member1 (ID,PWD,NAME) VALUES('200901','111','kevin');
insert into member1 (ID,PWD,NAME,GENDER) VALUES('200902','111','dragon','남성');


--과제
--Q1.ID, NAME의 자료 크기 단위를 글자수 기준으로 변경하세요.
--Nchar , Nvarchar2	크기의 단위가 Byte가 아니라 글자수를 나타냄
ALTER TABLE MEMBER1 MODIFY( ID NVARCHAR2(50), NAME NVARCHAR2(50));

--Q2.PWD에 제약조건 NOT NULL을 추가하고 제약조건 이름은 MEMBER1_NN으로 변경하세요.
ALTER TABLE MEMBER1 MODIFY(PWD CONSTRAINT MEMBER1_NN NOT NULL);

--Q3.BIRTHDAY 컬럼 이름을 BD로 변경하세요.
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;

--Q4.AGE 컬럼을 삭제하세요.
ALTER TABLE MEMBER1 DROP COLUMN AGE;

--Q5.TEXT 컬럼을 추가하세요. 단 자료 형태는 NCLOB
ALTER TABLE MEMBER1 ADD TEXT NCLOB;
INSERT INTO MEMBER1 (ID,PWD, TEXT) VALUES('200903','234','정치는 국민을 위해 존재한다');

--Q6.ID에 제약조건 이름 MEMBER_PK로 기본키를 설정하세요.
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER_PK PRIMARY KEY (ID);

--Q7. ID에 설정된 기본키 제약조건을 삭제하세요.
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK;

--Q8. MEMBER1에 모든 행을 제거하세요.
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