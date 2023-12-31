SELECT
    full_region,
    p.category,
    CAST(SUM(p.sale_price * o.product_quantity - p.cost_price * o.product_quantity) AS NUMERIC(10, 2)) AS profit
FROM
    orders AS o
JOIN dim_store AS s
     ON o.store_code = s.store_code
JOIN
    dim_product AS p ON o.product_code = p.product_code
WHERE
    TRIM(full_region) = 'Wiltshire, UK'
GROUP BY
    full_region, p.category
ORDER BY 
    profit DESC
LIMIT 1;

