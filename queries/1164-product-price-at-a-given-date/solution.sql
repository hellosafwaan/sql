-- Case 1: products with a price change on or before the date — use the most recent price
select p1.product_id, p1.new_price as price
from products p1
    inner join (
        select product_id, max(change_date) as recent_price
        from products
        where change_date <= '2019-08-16'
        group by product_id
    ) as p2 on p2.product_id = p1.product_id and p2.recent_price = p1.change_date

union

-- Case 2: products with no price change on or before the date — default price is 10
select distinct p.product_id, 10 as price
from products p
left join (
    select product_id from products where change_date <= '2019-08-16'
) sub on sub.product_id = p.product_id
where sub.product_id is null;
