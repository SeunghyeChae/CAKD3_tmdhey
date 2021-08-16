빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 21.08.13
- 성명 : 채승혜
- 점수 :

--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A.
select first_name, salary, salary*1.1
from employees;
    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
select *
from employees
where hire_date >= to_date('01/01/01', 'yy/mm/dd') and hire_date < to_date('01/07/01', 'yy/mm/dd');


--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
select *
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');

   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A. 
select *
from employees
where manager_id >=101 AND manager_id<=103;


--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
SELECT last_name, hire_date, next_day(add_months(hire_date,6),2) 
FROM employees;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A. trunc
SELECT employee_id 사번, last_name 이름 , salary 급여 , hire_date 입사일, TRUNC(months_between(SYSDATE, hire_date),0) 근속월수 
FROM employees
ORDER BY 근속월수 desc;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
SELECT employee_id 사번, last_name 이름 , salary 급여 , hire_date 입사일, TRUNC(months_between(SYSDATE, hire_date)/12, 0) 근속연수
from employees
order by 근속연수 desc;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
select employee_id 사번, last_name 이름
from employees
where mod(employee_id,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
select employee_id 사번, last_name 이름, TRUNC(salary/12,2) 월급
from employees;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 
--근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  
--등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
SELECT employee_id 사번, last_name 이름 , salary 급여 , hire_date 입사일, 
        width_bucket(hire_date, sysdate, '01/01/01', 30)*1000 수당
from employees
order by 수당 desc;


--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
SELECT count(*)
FROM employees
WHERE commission_pct is null;

--★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
update employees
set department_id= '신입'
where department_id is null;
--A.
SELECT department_id, NVL(department_id, '신입')
FROM employees;
--A.
SELECT E.* , '신입'
FROM employees E
WHERE department_id IS NULL;


--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
-- JOIN
SELECT employee_id 사번, last_name 이름, J.job_id 업무, job_title 업무명
FROM employees E JOIN jobs J ON E.job_id = J.job_id
WHERE employee_id = 120;

-- WHERE
SELECT employee_id 사번, last_name 이름, J.job_id 업무, J.job_title 업무명
FROM employees E, jobs J
WHERE employee_id=120 AND E.job_id = J.job_id;





--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
SELECT  E.first_name || ' ' || E.last_name NAME
FROM employees E;


--★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
--Q15. HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A. 


--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.
SELECT *
FROM employees 
WHERE job_id like '%Q_A%' ESCAPE 'Q';


--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
select SALARY, LAST_NAME
from employees
order by salary, last_name;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A. 
SELECT D.department_name, E.first_name || ' ' || E.last_name 
FROM employees E, departments D
WHERE E.last_name='Seo';

--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUST 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.

CREATE TABLE cuspur(고객번호,구매금액)
AS SELECT 고객번호,sum(구매금액)
FROM purprd
group by 고객번호;

SELECT * FROM cuspur;

SELECT *
FROM purprd P JOIN cust C ON P.고객번호=C.고객번호;


--Q20.purprd 테이블의 2년간 구매금액을 연간 단위로 분리하여 구매14, 구매15 컬럼을 포함하는 AMT_YEAR 테이블을 
--생성한 후 14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력하세요.
--단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함.

