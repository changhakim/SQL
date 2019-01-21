-- Employees ���̺�
--[ employee_id = ��� ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = �Ի��� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = �Ŵ������̵�]
--[ department_id = �μ��ڵ�]

--  Jobs ���̺�

-- job_id �����ڵ�
-- job_title ����Ÿ��Ʋ
-- min_salary  �����޿�
-- max_salary �ְ�޿�
select * from jobs;
desc EMPLOYEES;
CREATE VIEW EMP AS
SELECT EMPLOYEE_ID EID, 
FIRST_NAME FNAME,
LAST_NAME LNAME,
EMAIL,
PHONE_NUMBER PHONE,
HIRE_DATE HDATE,
JOB_ID JID,
SALARY SAL,
COMMISSION_PCT PCT,
MANAGER_ID MID,
DEPARTMENT_ID DID 
FROM EMPLOYEES;
DROP VIEW  EMP;

desc jobs;
CREATE VIEW JOB AS
SELECT
    JOB_ID JID,
    JOB_TITLE TITLE,
    MIN_SALARY MINSAL,
    MAX_SALARY MAXSAL
FROM JOBS;    

DESC JOB_HISTORY;
CREATE VIEW HIS AS
SELECT
EMPLOYEE_ID EID,
START_DATE SDATE,
END_DATE EDATE,
JOB_ID JID,
DEPARTMENT_ID DID
FROM JOB_HISTORY;

DROP VIEW HIS;

desc DEPARTMENTS;
CREATE VIEW DEP AS
SELECT
DEPARTMENT_ID did,
DEPARTMENT_NAME dname,
MANAGER_ID mid,
LOCATION_ID lid
FROM DEPARTMENTS;    

DESC LOCATIONS;
CREATE VIEW LOC AS
SELECT
LOCATION_ID LID,
STREET_ADDRESS ADDR,
POSTAL_CODE ZIP,
CITY,
STATE_PROVINCE PROV,
COUNTRY_ID CID
from LOCATIONS;


-- *******************
-- [����021]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- *******************    
SELECT e.first_name �̸�,e.hire_date �Ի���,j.job_title ������
FROM jobs j
INNER JOIN employees e ON
 e.JOB_ID LIKE j.JOB_ID
where j.job_title IN('Programmer','Sales Manager')
ORDER BY e.FIRST_NAME;

-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- ******************
SELECT d.department_name �μ���,e.first_name "�Ŵ��� �̸�"
from employees e
inner join departments d on d.manager_id LIKE e.EMPLOYEE_ID
WHERE d.MANAGER_ID is NOT NULL;


SELECT * FROM JOBS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM employees;
-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  

SELECT D.DID
    FROM DEF D
    WHERE D.NAME LIKE 'Marketing';

SELECT E.EID ���, J.TITLE ��å, E.FNAME �̸�,
        H.EDATE - H.SDATE �ټ��ϼ�
 FROM HIS H 
     JOIN JOB J
            ON H.JID LIKE J.JID
     JOIN EMP E
            ON E.EID LIKE H.EID
  WHERE E.DID LIKE (SELECT D.DID
                    FROM DEP D
                    WHERE D.DNAME LIKE 'Marketing');
       


--- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ���
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************
-- *******************  
SELECT d.DEPARTMENT_NAME  �μ���,e.FIRST_NAME||' '||e.LAST_NAME �̸�
FROM employees e
JOIN DEPARTMENTS d on d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE d.DEPARTMENT_NAME like 'IT';

-- *******************
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************
SELECT D.DNAME �μ���, E.FNAME ||''|| E.LNAME"������ �̸�",L.CITY "�μ���ġ ����"
FROM DEP D 
JOIN EMP E ON D.MID LIKE E.EID
JOIN LOC L
    USING(LID)
 ORDER BY DNAME;
 -- *******************
-- [����026]
-- �μ��� ��� �޿��� ����Ͻÿ�
-- *******************
SELECT D.DNAME �μ��� ,ROUND(AVG(E.SAL),2)"�μ��� ��� �޿�"
FROM EMP E
    JOIN DEP D
    ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME   
HAVING   ROUND(AVG(E.SAL),2)>= 10000 
    ;
    
    -- *******************
-- [����028]
-- ���� �������� 10% �λ�� �޾��� ���� ��������
-- å���Ǿ����ϴ�. ���� ������� ����޿���
-- ����ϼ���.
-- ��, ���� = �޿� * 12 �Դϴ�
-- *********************

SELECT E.FNAME ����̸�,E.SAL ����޿�, ((((E.SAL*12)*0.1)+(E.SAL*12))/12) �޿�
FROM EMP E;


-- *******************
-- [����029]
-- �μ����� ����ϴ� �����ڿ� ������ 
-- �ѹ����� ����Ͻÿ� (20��)
-- *********************
SELECT D.DNAME �μ�,E.FNAME ������,J.TITLE ����
FROM EMP E
JOIN DEP D ON D.MID LIKE E.EID
JOIN JOB J ON J.JID = E.JID
GROUP BY E.FNAME,J.TITLE,D.DNAME;

-- *******************
-- [����030]
-- �̹� �б⿡ IT�μ�(�μ���: IT)������ �ű� ���α׷��� �����ϰ� 
-- �����Ͽ� ȸ�翡 �����Ͽ���. 
-- �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��Ͽ� �����մϴ�.
-- ������(�ݿø�) ǥ���Ͽ� ������ �ۼ��Ͻÿ�. 
-- ������ �����ȣ, ���� �̸�(�̸�), 
-- �޿�, ���� �޿� ������ ����Ͻÿ�
-- �޾��� õ��������
-- *********************
SELECT E.EID �����ȣ,E.FNAME||''||E.LNAME �̸�,E.SAL �޿�, 
ROUND((((E.SAL*0.123)+E.SAL)),0) "�λ�� �޿�"
FROM EMP E
JOIN DEP D ON D.MID LIKE E.EID
WHERE D.DNAME LIKE 'IT';

SELECT *
FROM EMP E
JOIN DEP D ON D.DID = E.DID;
SELECT *
FROM EMP E;

