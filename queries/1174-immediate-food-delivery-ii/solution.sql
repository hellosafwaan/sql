SELECT
    ROUND(
        SUM(CASE WHEN customer_pref_delivery_date = first_order_date THEN 1 ELSE 0 END)::numeric
        / COUNT(*) * 100,
        2
    ) AS immediate_percentage
FROM delivery
JOIN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM delivery
    GROUP BY customer_id
) AS d2
    ON delivery.customer_id = d2.customer_id
   AND delivery.order_date = d2.first_order_date;
