-- KPI Metrics
SELECT 
    SUM(Amount) AS Total_Sales_Revenue,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Amount) / COUNT(DISTINCT `Order ID`) AS Average_Order_Value
FROM sales_data;

-- Profit Trend by Month
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%d-%m-%Y'), '%Y-%m') AS Month,
    SUM(Profit) AS Total_Profit
FROM orders_data 
JOIN sales_data ON orders_data.`Order ID` = sales_data.`Order ID`
GROUP BY Month
ORDER BY Month;

-- Top 10 Customers by Sales
SELECT 
    orders_data.CustomerName, 
    SUM(sales_data.Amount) AS Total_Sales
FROM orders_data 
JOIN sales_data ON orders_data.`Order ID` = sales_data.`Order ID`
GROUP BY orders_data.CustomerName
ORDER BY Total_Sales DESC
LIMIT 10;

-- Sales by Product Category
SELECT 
    `Product Category`, 
    SUM(Amount) AS Total_Sales
FROM sales_data
GROUP BY `Product Category`
ORDER BY Total_Sales DESC;

-- Profit by Product Sub-Category
SELECT 
    `Product Type`, 
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY `Product Type`
ORDER BY Total_Profit DESC;

-- Quantity Sold by Product Type
SELECT 
    `Product Type`, 
    SUM(Quantity) AS Total_Quantity_Sold
FROM sales_data
GROUP BY `Product Type`
ORDER BY Total_Quantity_Sold DESC;

-- Sales by Payment Mode
SELECT 
    `Payment Mode`, 
    SUM(Amount) AS Total_Sales
FROM sales_data
GROUP BY `Payment Mode`
ORDER BY Total_Sales DESC;

-- Sales Performance by Quarter
SELECT 
    CONCAT('Q', QUARTER(STR_TO_DATE(`Order Date`, '%d-%m-%Y'))) AS Quarter,
    YEAR(STR_TO_DATE(`Order Date`, '%d-%m-%Y')) AS Year,
    SUM(Amount) AS Total_Sales
FROM orders_data 
JOIN sales_data ON orders_data.`Order ID` = sales_data.`Order ID`
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
