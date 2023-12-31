SELECT CAST(SUM(o.product_quantity * p.sale_price) AS NUMERIC(10,2)) AS "revenue", month_name
FROM orders as o 
JOIN dim_date as dd  
    ON o.order_date = dd.date
JOIN dim_product as p 
    ON o.product_code = p.product_code
WHERE year = 2022
GROUP BY month_name
ORDER BY revenue DESC
LIMIT 1;