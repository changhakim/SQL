SELECT E.LAST_NAME �̸�, D.DEPARTMENT_NAME �μ���
FROM employees e
INNER JOIN departments d on d.DEPARTMENT_ID LIKE e.DEPARTMENT_ID;


select department_id
from employees
where last_name like 'Fay';

select department_name "���� �μ�"
from departments
where department_id like 
    (select department_id
    from employees
    where last_name like 'Fay');