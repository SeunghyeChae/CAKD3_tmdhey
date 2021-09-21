-- [system 계정에서 - Oracle 12c 이상인 경우] - hr 스키마 생성
-- ORACLE 12C 이상 CDB 환경에서 사용
-- CDB user 사용, 사용자 이름에 c##을 붙이고, GRANT UNLIMITED 명령을 추가
-- id: c##hr , password: hr
DROP USER C##HR CASCADE; 
CREATE USER C##HR IDENTIFIED BY HR DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO C##HR;
GRANT CREATE VIEW, CREATE SYNONYM TO C##HR;
GRANT UNLIMITED TABLESPACE TO C##HR;
ALTER USER C##HR ACCOUNT UNLOCK;
--------------------------------------------------------
-- 여기서부터 hr 사용자로 접속
-- 스키마 생성
--------------------------------------------------------
connect C##HR/HR;
--------------------------------------------------------
SELECT * FROM EMPLOYEES;

