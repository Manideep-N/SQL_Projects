SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
where transactions_id is null;

SELECT * FROM retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

	delete from retail_sales
	where transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

-- how many sales we have
select count(*) as total_sales
from retail_sales;

-- how many unique customers we have
SELECT COUNT(DISTINCT customer_id) as customers
from retail_sales;

-- how many unique catogery we have?
SELECT DISTINCT category
FROM retail_sales;

-- data analysis 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
where category = 'Clothing' 
and quantiy >= 4 
and to_char(sale_date, 'yyyy-mm') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, sum(total_sale) as total_sales
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT round(avg(age),2) as avg_age from retail_sales
where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender,
count(*) as total_tras
FROM retail_sales
group by category, gender order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY year, month
) as t1
WHERE rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,
sum(total_sale) as total_sales 
from retail_sales
group by customer_id
order by total_sales desc 
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category, 
count(distinct customer_id) as unique_customers
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN extract(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN extract(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    count(*) AS Orders
FROM 
    Retail_sales
GROUP BY Shift;