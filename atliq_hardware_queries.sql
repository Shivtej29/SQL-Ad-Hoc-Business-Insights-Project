-- Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.
SELECT 
    DISTINCT market
FROM
    dim_customer
WHERE
    customer = 'Atliq Exclusive'
        AND region = 'APAC';

#2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020, unique_products_2021, percentage_chg
with 
unq2020 as (select count(distinct(product_code)) as unique_products_2020 from fact_sales_monthly
where fiscal_year = 2020),
unq2021 as (select count(distinct(product_code)) as unique_products_2021 from fact_sales_monthly
where fiscal_year = 2021)
select *,round((unique_products_2021-unique_products_2020)/unique_products_2020 * 100,2) as percentage_chg
from unq2020 
join unq2021;

-- Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. 
-- The final output contains 2 fields - segment, product_count
SELECT 
    segment, COUNT(DISTINCT (product_code)) AS product_count
FROM
    dim_product
GROUP BY segment
ORDER BY product_count DESC;

-- 4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,
-- segment
-- product_count_2020
-- product_count_2021
-- difference

with temp_table as 
(select 
		p.segment,
		fiscal_year,
		COUNT(DISTINCT sm.Product_code) as product_count 
from fact_sales_monthly sm
	join dim_product p
	on p.product_code=sm.product_code
group by p.segment,sm.fiscal_year)
select 
		up_2020.segment,
		up_2020.product_count as productcount_2020,
		up_2021.product_count as productcount_2021,
		up_2021.product_count - up_2020.product_count as difference 
from temp_table UP_2020
		join temp_table UP_2021
		on UP_2020.segment=UP_2021.segment
		and UP_2020.fiscal_year= 2020
		and UP_2021.fiscal_year = 2021
order by difference DESC;

-- 5. Get the products that have the highest and lowest manufacturing costs.The final output should contain these fields,
-- product_code
-- product
-- manufacturing_cost
SELECT 
    m.product_code, product, m.cost_year, manufacturing_cost
FROM
    fact_manufacturing_cost m
        JOIN
    dim_product p ON p.product_code = m.product_code
WHERE
    manufacturing_cost = (SELECT 
            MAX(manufacturing_cost)
        FROM
            fact_manufacturing_cost)
        OR manufacturing_cost = (SELECT 
            MIN(manufacturing_cost)
        FROM
            fact_manufacturing_cost)
ORDER BY manufacturing_cost DESC;


-- 6. Generate a report which contains the top 5 customers who received an
-- average high pre_invoice_discount_pct for the fiscal year 2021 and in the
-- Indian market. The final output contains these fields,
-- customer_code
-- customer
-- average_discount_percentage

SELECT 
    c.customer_code,
    c.customer,
    ROUND(AVG(pre_invoice_discount_pct), 4) AS average_discount_percentage
FROM
    fact_pre_invoice_deductions d
        JOIN
    dim_customer c ON c.customer_code = d.customer_code
WHERE
    fiscal_year = 2021 AND market = 'India'
GROUP BY c.customer_code , c.customer
ORDER BY average_discount_percentage
LIMIT 5;

-- 7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. 
-- This analysis helps to get an idea of low and high-performing months and take strategic decisions.
-- The final report contains these columns:
-- Month
-- Year
-- Gross sales Amount

with temp_table as (SELECT 
    MONTHNAME(date) AS month,
    YEAR(date) AS year,
    SUM(sm.sold_quantity * gp.gross_price) AS gross_sales
FROM
    dim_customer c
        JOIN
    fact_sales_monthly sm ON c.customer_code = sm.customer_code
        JOIN
    fact_gross_price gp ON sm.product_code = gp.product_code
WHERE
    customer = 'Atliq exclusive'
GROUP BY month , year
ORDER BY gross_sales ,year desc)
select month,year,concat(round(gross_sales/1000000,2),"M") from temp_table;


-- 8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,
-- Quarter
-- total_sold_quantity

with cte1 as 
(select 
		quarter(date) as Quarter_2020, 
		concat(round(sum(sold_quantity)/1000000,2)," M") as total_sold_quantity 
from fact_sales_monthly
where year(date) = 2020
group by quarter(date))
select * from cte1
order by total_sold_quantity desc
limit 1;

-- 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
-- channel
-- gross_sales_mln
-- percentage
WITH temp_table AS (
      SELECT c.channel,sum(s.sold_quantity * g.gross_price) AS total_sales
  FROM
  fact_sales_monthly s 
  JOIN fact_gross_price g ON s.product_code = g.product_code
  JOIN dim_customer c ON s.customer_code = c.customer_code
  WHERE s.fiscal_year= 2021
  GROUP BY c.channel
  ORDER BY total_sales DESC
)
SELECT 
  channel,
  round(total_sales/1000000,2) AS gross_sales_in_millions,
  round(total_sales/(sum(total_sales) OVER())*100,2) AS percentage 
FROM temp_table ;


-- 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
-- division
-- product_code
-- product
-- total_sold_quantity
-- rank_order

WITH temp_table AS (
    SELECT 
        p.division,
        s.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity, 
        RANK() OVER (PARTITION BY p.division ORDER BY SUM(s.sold_quantity) DESC) AS rank_order
    FROM  
        fact_sales_monthly s
    JOIN 
        dim_product p ON s.product_code = p.product_code
    WHERE 
        s.fiscal_year = 2021
    GROUP BY 
        p.division, s.product_code, p.product
)
SELECT * 
FROM temp_table
WHERE rank_order IN (1, 2, 3);









