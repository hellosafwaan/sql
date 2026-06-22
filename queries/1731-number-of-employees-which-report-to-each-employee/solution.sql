-- Derived-table approach: aggregate reportees per manager, join back for name
select
    managers.employee_id,
    employees.name,
    managers.reports_count,
    managers.average_age
from
    employees
        inner join (
            select
                reports_to as employee_id,
                count(*) as reports_count,
                round(avg(age)) as average_age
            from employees
            where reports_to is not null
            group by reports_to
        ) as managers
        on managers.employee_id = employees.employee_id
order by managers.employee_id asc;

-- Cleaner equivalent: direct self-join (no subquery needed)
-- select m.employee_id, m.name, count(e.employee_id) as reports_count, round(avg(e.age)) as average_age
-- from Employees m
-- inner join Employees e on e.reports_to = m.employee_id
-- group by m.employee_id, m.name
-- order by m.employee_id;
