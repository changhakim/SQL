SELECT E.LAST_NAME 이름, D.DEPARTMENT_NAME 부서명
FROM employees e
INNER JOIN departments d on d.DEPARTMENT_ID LIKE e.DEPARTMENT_ID;


select department_id
from employees
where last_name like 'Fay';

select department_name "페이 부서"
from departments
where department_id like 
    (select department_id
    from employees
    where last_name like 'Fay');