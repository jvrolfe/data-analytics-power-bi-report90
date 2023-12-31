SELECT
    CAST(SUM(o.product_quantity * p.sale_price) AS NUMERIC(10, 2)) AS revenue,
    store_type
FROM
    dim_store AS s
JOIN
    orders AS o ON s.store_code = o.store_code
JOIN
    dim_product AS p ON o.product_code = p.product_code
WHERE
    s.country = 'Germany'
GROUP BY
    store_type
ORDER BY
    revenue DESC
LIMIT 1;
