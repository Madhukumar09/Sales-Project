use Sales_db;

select * from sales;

use sales_db;


select * from sales;

 -- . data cleaning 
 -- check null values

select count(*) as total_rows,
count(sales) as sales_count,
count(profit) as profit_count from sales;

-- update sales 
-- set profit=0
-- where profit is null;

-- 3.basic sales analysis
-- total sales & profit
select 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales;

-- sales and losess
select sales,profit from sales
where profit < 0;

-- total orders

select count(distinct order_id) as total_orders from sales;

-- average order value

select round(sum(sales)/count(distinct order_id),2) as avg_order_value from sales;

-- 4.time based analysis
-- sales by year

select year(order_date) as year,
round(sum(sales),2) as total_sales from sales
group by order_date
order by year;

--select round(sum(sales),2) as total_sales from sales
--where order_date = 2014;

-- monthly sales

select month(order_date) as month,
round(sum(sales),2) as total_sales from sales
group by order_date
order by month;

-- 5.product analysis
-- top 10 best-selling product

select product_name, 
round(sum(sales),2) as total_sales from sales
group by product_name
order by total_sales desc;
-- limit 10;

-- category-wise sales and profit

select category, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
-- where category = 'Office Supplies'
group by category;

-- sub_category-wise sales and profit

select sub_category, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
-- where category = 'Office Supplies'
group by sub_category
--having sum(profit) < 0;

-- region-wise sales and profit

select region, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
group by region;

-- loss-making products

select product_name,
round(sum(profit),2) as total_profit from sales
group by product_name
-- order by total_profit desc
having sum(profit) < 0;

-- segment-wise sales and profit

select segment, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
group by segment;

-- state-wise sales and profit

select state, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
group by state;

-- city-wise sales and profit

select city, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
group by city;

-- region-wise sales and losess

select region, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_losess from sales
group by region
having sum(profit) < 0;

-- state-wise sales and loses

select state,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_loses from sales
--round(sum(profit),2) as total_profit from sales
group by state
having sum(profit) < 0;

-- city-wise sales and loses

select city,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_loses from sales
group by city
having sum(profit) < 0;

-- product-wise sales and loses

select product_name,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_loses from sales
-- round(sum(profit),2) as total_profit from sales
group by product_name
having sum(profit) < 0;

-- category-wise sales and losess

select category, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
-- where category = 'Office Supplies'
group by category
having sum(profit) < 0;

-- sub_category-wise sales and losess

select sub_category, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_losess from sales
-- where category = 'Office Supplies'
group by sub_category
having sum(profit) < 0;

-- product-wise sales and losess

select product_name,
round(sum(sales),2) as tatal_sales,
round(sum(profit),2) as total_losess from sales
group by product_name
having sum(profit) < 0;

-- product-wise sales and profit

select product_name, 
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit from sales
group by product_name;

-- 7.shipping analysis

-- category-wise orders,sales and profit

select category,
count(*) as orders,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by category;

-- ship-mode sales and profit

select ship_mode,
count(*) as orders,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by Ship_Mode;

-- region-wise orders,sales and profit

select region,
count(*) as orders,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by region;

-- product_wise orders, sales and profit

select product_name,
count(*) as orders,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by product_name;

-- segment_wise orders, sales and profit

select segment,
count(*) as orders,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by segment;

-- 8.Discount impact analysis

select discount,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
group by discount
order by discount;


select year(2014) as year,
round(sum(sales),2) as total_sale,
round(sum(profit),2) as total_profit from sales
where year(order_date) = 2014
group by order_date;
-- order by year;

select * from sales;

-- year on year sales growth

SELECT
    year,
    total_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY year) AS sales_growth,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY year)) 
        / LAG(total_sales) OVER (ORDER BY year) * 100, 2
    ) AS growth_percentage
FROM (
    SELECT 
        YEAR(order_date) AS year,
        round(SUM(sales),3) AS total_sales
    FROM sales
    GROUP BY YEAR(order_date)
) t;


SELECT 
    year(order_date) as year,
    round(SUM(sales),3) AS total_sales,
    ROUND(
        (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY year(order_date))) 
        / LAG(SUM(sales)) OVER (ORDER BY year(order_date)) * 100, 2
    ) AS yoy_growth_percent
FROM sales
GROUP BY year(order_date)
ORDER BY year(order_date);