select signups.user_id,
    round(coalesce(avg((confirmations.action = 'confirmed')::integer), 0), 2) as confirmation_rate
from signups
left join confirmations on signups.user_id = confirmations.user_id
group by signups.user_id;
