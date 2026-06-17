select t2.id
from weather t1
join weather t2 on t2.recordDate = t1.recordDate + 1
where t2.temperature > t1.temperature;

-- Note: on real Postgres use t1.recordDate + INTERVAL '1 day' instead of + 1
