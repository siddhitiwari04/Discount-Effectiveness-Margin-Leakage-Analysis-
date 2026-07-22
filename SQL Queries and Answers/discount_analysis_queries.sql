USE discount_analysis;

-- ================================================
-- Q1: Revenue and Margin by Category
-- Purpose: Compare margin % on discounted vs full price transactions
-- ================================================

SELECT
    category,
    CASE WHEN discount > 0 THEN 'Discounted' ELSE 'Full Price' END AS price_type,
    COUNT(*) AS num_transactions,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM transactions
GROUP BY category, price_type
ORDER BY category, price_type;

-- ================================================
-- Q2: Over-Discounted Sub-Categories
-- Purpose: Find sub-categories with high discounts but thin margins
-- ================================================

SELECT
    sub_category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct,
    ROUND(SUM(sales), 2) AS total_revenue,
    SUM(quantity) AS total_units_sold
FROM transactions
WHERE discount > 0
GROUP BY sub_category
ORDER BY avg_discount_pct DESC;

-- ================================================
-- Q3: Month over Month Volume Change
-- Purpose: Check if discount months actually drove more volume
-- ================================================

WITH monthly_sales AS (
    SELECT
        category,
        year,
        MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_num,
        SUM(quantity) AS total_qty,
        ROUND(AVG(discount) * 100, 2) AS avg_discount
    FROM transactions
    GROUP BY category, year, month_num
)
SELECT
    category,
    year,
    month_num,
    total_qty,
    avg_discount,
    LAG(total_qty) OVER (PARTITION BY category ORDER BY year, month_num) AS prev_month_qty,
    ROUND(
        (total_qty - LAG(total_qty) OVER (PARTITION BY category ORDER BY year, month_num))
        / LAG(total_qty) OVER (PARTITION BY category ORDER BY year, month_num) * 100
    , 2) AS qty_change_pct
FROM monthly_sales
ORDER BY category, year, month_num;

-- ================================================
-- Q4: Product Risk Labeling
-- Purpose: Flag products with high discounts and low/negative margins
-- ================================================

SELECT
    product_id,
    product_name,
    sub_category,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct,
    ROUND(SUM(sales), 2) AS total_revenue,
    SUM(quantity) AS total_units,
    CASE
        WHEN AVG(discount) > 0.3 AND SUM(profit) < 0 THEN 'High Risk'
        WHEN AVG(discount) > 0.2 AND SUM(profit) / SUM(sales) < 0.1 THEN 'Watch'
        WHEN AVG(discount) = 0 OR AVG(discount) < 0.1 THEN 'Healthy'
        ELSE 'Moderate'
    END AS discount_risk_label
FROM transactions
GROUP BY product_id, product_name, sub_category
ORDER BY avg_discount_pct DESC, total_revenue ASC;

-- ================================================
-- Q5: Rolling 30-Day Sales Average
-- Purpose: Smooth daily sales to see real trend vs short spikes
-- ================================================

SELECT
    category,
    STR_TO_DATE(order_date, '%d-%m-%Y') AS sale_date,
    SUM(quantity) AS daily_qty,
    ROUND(AVG(SUM(quantity)) OVER (
        PARTITION BY category
        ORDER BY STR_TO_DATE(order_date, '%d-%m-%Y')
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_30day_avg
FROM transactions
GROUP BY category, order_date
ORDER BY category, sale_date;