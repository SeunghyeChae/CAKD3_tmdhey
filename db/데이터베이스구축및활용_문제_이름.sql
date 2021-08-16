������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 21.08.13
- ���� : ä����
- ���� :

--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A.
select first_name, salary, salary*1.1
from employees;
    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
select *
from employees
where hire_date >= to_date('01/01/01', 'yy/mm/dd') and hire_date < to_date('01/07/01', 'yy/mm/dd');


--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
select *
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');

   
--Q4. manager_id �� 101���� 103�� ����� ���
--A. 
select *
from employees
where manager_id >=101 AND manager_id<=103;


--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
SELECT last_name, hire_date, next_day(add_months(hire_date,6),2) 
FROM employees;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A. trunc
SELECT employee_id ���, last_name �̸� , salary �޿� , hire_date �Ի���, TRUNC(months_between(SYSDATE, hire_date),0) �ټӿ��� 
FROM employees
ORDER BY �ټӿ��� desc;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
SELECT employee_id ���, last_name �̸� , salary �޿� , hire_date �Ի���, TRUNC(months_between(SYSDATE, hire_date)/12, 0) �ټӿ���
from employees
order by �ټӿ��� desc;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
select employee_id ���, last_name �̸�
from employees
where mod(employee_id,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
select employee_id ���, last_name �̸�, TRUNC(salary/12,2) ����
from employees;

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� 
--�ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  
--��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
SELECT employee_id ���, last_name �̸� , salary �޿� , hire_date �Ի���, 
        width_bucket(hire_date, sysdate, '01/01/01', 30)*1000 ����
from employees
order by ���� desc;


--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
SELECT count(*)
FROM employees
WHERE commission_pct is null;

--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
update employees
set department_id= '����'
where department_id is null;
--A.
SELECT department_id, NVL(department_id, '����')
FROM employees;
--A.
SELECT E.* , '����'
FROM employees E
WHERE department_id IS NULL;


--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
-- JOIN
SELECT employee_id ���, last_name �̸�, J.job_id ����, job_title ������
FROM employees E JOIN jobs J ON E.job_id = J.job_id
WHERE employee_id = 120;

-- WHERE
SELECT employee_id ���, last_name �̸�, J.job_id ����, J.job_title ������
FROM employees E, jobs J
WHERE employee_id=120 AND E.job_id = J.job_id;





--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
SELECT  E.first_name || ' ' || E.last_name NAME
FROM employees E;


--�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
--Q15. HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A. 


--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
SELECT *
FROM employees 
WHERE job_id like '%Q_A%' ESCAPE 'Q';


--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
select SALARY, LAST_NAME
from employees
order by salary, last_name;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A. 
SELECT D.department_name, E.first_name || ' ' || E.last_name 
FROM employees E, departments D
WHERE E.last_name='Seo';

--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUST ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.

CREATE TABLE cuspur(����ȣ,���űݾ�)
AS SELECT ����ȣ,sum(���űݾ�)
FROM purprd
group by ����ȣ;

SELECT * FROM cuspur;

SELECT *
FROM purprd P JOIN cust C ON P.����ȣ=C.����ȣ;


--Q20.purprd ���̺��� 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����14, ����15 �÷��� �����ϴ� AMT_YEAR ���̺��� 
--������ �� 14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ����ϼ���.
--��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��.

