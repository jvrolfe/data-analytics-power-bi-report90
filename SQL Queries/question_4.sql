CREATE VIEW "store_type_sales_and_percent" AS
SELECT
    store_type,
    CAST(SUM(p.sale_price * o.product_quantity) AS NUMERIC(10, 2)) AS 'sales',
    CAST((SUM(p.sale_price * o.product_quantity) / NULLIF(SUM(SUM(p.sale_price * o.product_quantity)) OVER (), 0)) * 100 AS NUMERIC(10, 2)) AS 'sales_percentage',
    COUNT(order_date_uuid) AS 'total_orders'
FROM
    dim_store AS s
JOIN orders AS o ON s.store_code = o.store_code
JOIN dim_product AS p ON o.product_code = p.product_code
GROUP BY
    store_type;


