SELECT * FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data` LIMIT 1000;

-- Total Revenue
select sum(Total_Amount) as Revenue from `e-commerce-operation-analysis.ecommerce_project_1.retail_data`;

-- Total Revenue by Product Category
select Product_Category, ROUND(SUM(total_amount) / 1000000, 2)as Revenue from `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
where Total_Amount is not null and
Product_Category is not null
group by Product_Category
order by Revenue DESC;

-- Revenue trend by month, ignoring NULLs
SELECT
  month,
  ROUND(SUM(total_amount)/1000000, 2) AS revenue_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE total_amount IS NOT NULL
GROUP BY month
ORDER BY revenue_millions DESC;


-- Top 10 customers based on spending
SELECT
  customer_id,
  ROUND(SUM(total_amount)/1000000, 2) AS total_spent_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE total_amount IS NOT NULL
GROUP BY customer_id
ORDER BY total_spent_millions DESC
LIMIT 10;


-- Categorize age groups and compute revenue
SELECT
  CASE
    WHEN age < 25 THEN '18-24'
    WHEN age < 35 THEN '25-34'
    WHEN age < 50 THEN '35-49'
    ELSE '50+'
  END AS age_group,
  ROUND(SUM(total_amount)/1000000, 2) AS revenue_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE total_amount IS NOT NULL
  AND age IS NOT NULL
GROUP BY age_group
ORDER BY revenue_millions DESC;


-- Revenue by gender, excluding NULLs
SELECT
  gender,
  ROUND(SUM(total_amount)/1000000, 2) AS revenue_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE total_amount IS NOT NULL
  AND gender IS NOT NULL
GROUP BY gender
ORDER BY revenue_millions DESC;


-- Top ten best selling brands by revenue
SELECT
  product_brand,
  ROUND(SUM(total_amount)/1000000, 2) AS revenue_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE total_amount IS NOT NULL
  AND product_brand IS NOT NULL
GROUP BY product_brand
ORDER BY revenue_millions DESC
LIMIT 10;


-- Average Rating by  Product Category
SELECT
  product_category,
  ROUND(AVG(ratings), 2) AS avg_rating
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE ratings IS NOT NULL
  AND product_category IS NOT NULL
GROUP BY product_category
ORDER BY avg_rating DESC;


-- Most used Payment Method 

SELECT
  payment_method,
  COUNT(*) AS transaction_count
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE payment_method IS NOT NULL
GROUP BY payment_method
ORDER BY transaction_count DESC;


-- Shipping performance order by shipping method 

SELECT
  shipping_method,
  COUNT(*) AS order_count
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE shipping_method IS NOT NULL
GROUP BY shipping_method
ORDER BY order_count DESC;


-- Cancelled order analysis

SELECT
  order_status,
  COUNT(*) AS order_count,
  ROUND(SUM(total_amount)/1000000, 2) AS revenue_millions
FROM `e-commerce-operation-analysis.ecommerce_project_1.retail_data`
WHERE order_status IS NOT NULL
GROUP BY order_status
ORDER BY order_count DESC;