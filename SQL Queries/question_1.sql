SELECT SUM(staff_numbers), country
FROM dim_store
WHERE TRIM(country) = 'UK'
GROUP BY country;

