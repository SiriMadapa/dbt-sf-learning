{{ config(
    materialized='table'
) }}

SELECT
    o.Order_ID,
    c.Customer_ID,
    c.Customer_Name,
    p.Product_ID,
    p.Product_Name,
    o.Quantity,
    o.Order_Date AS original_date,
    EXTRACT(YEAR FROM o.Order_Date) AS year,
    EXTRACT(MONTH FROM o.Order_Date) AS month,
    EXTRACT(DAY FROM o.Order_Date) AS day,
    EXTRACT(DAYOFWEEK FROM o.Order_Date) AS day_of_week,
    EXTRACT(DAYOFYEAR FROM o.Order_Date) AS day_of_year,
    EXTRACT(WEEK FROM o.Order_Date) AS week,
    EXTRACT(QUARTER FROM o.Order_Date) AS quarter
FROM
    {{ source('practice_schema', 'orders') }} o
JOIN
    {{ ref('stg_customers') }} c 
    ON o.Customer_ID = c.Customer_ID
JOIN
    {{ source('practice_schema', 'products') }} p 
    ON o.Product_ID = p.Product_ID
