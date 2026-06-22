-- Case 2: employees belonging to exactly one department (it's their primary by default)
select employee_id, min(department_id) as department_id
from employee
group by employee_id
having count(department_id) = 1

union

-- Case 1: employees with an explicitly flagged primary department
select employee_id, department_id
from employee
where primary_flag = 'Y';
