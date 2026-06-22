select person_name
from (
    select person_name,
           sum(weight) over (order by turn) as running_weight
    from queue
) sub
where running_weight <= 1000
order by running_weight desc
limit 1;
