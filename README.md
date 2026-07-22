# Superstore Discount & Margin Analysis

End-to-end analysis of the Global Superstore dataset — from raw data cleaning to SQL-based margin analysis, Excel elasticity modeling, and a Power BI dashboard — focused on one question: **is discounting actually helping or hurting profitability?**

## Project Structure

```
├── Data cleaning, feature engineering n analysis/
│   ├── SuperStoreOrders.csv          # Raw source data
│   ├── super_store_orders.ipynb      # Data cleaning & feature engineering (Python/Pandas)
│   ├── superstore_updated.csv        # Cleaned dataset with engineered features
│   ├── cleaned_transactions.csv      # Final cleaned transactions table (used for SQL)
│   └── discount_margin_analysis.xlsx # Excel elasticity, breakeven & recommendations
│
├── SQL Queries and Answers/
│   ├── discount_analysis_queries.sql # 5 SQL queries (margin, discount, trend, risk)
│   ├── q1_category_margin.csv
│   ├── q2_subcategory_discount.csv
│   ├── q3_monthly_volume.csv
│   ├── q4_product_risk.csv
│   └── q5_rolliing_avg.csv
│
└── Power BI Dashboard/
    └── Screenshot ....png             # Dashboard screenshot
```

## 1. Data Cleaning & Feature Engineering (Python)

Using `super_store_orders.ipynb`:
- Loaded raw `SuperStoreOrders.csv` and inspected structure/data types
- Cleaned `sales`, `profit`, and `discount` columns (removed comma separators, converted to numeric)
- Engineered two new features:
  - **`unit_price`** = sales / quantity
  - **`unit_cost`** = (sales − profit) / quantity
- Exported the cleaned, feature-enriched dataset as `superstore_updated.csv` / `cleaned_transactions.csv`

## 2. SQL Analysis

Queries in `discount_analysis_queries.sql`, run against the cleaned transactions table:

| Query | Purpose |
|---|---|
| **Q1 – Category Margin** | Compares margin % for discounted vs. full-price transactions, by category |
| **Q2 – Sub-Category Discount** | Flags sub-categories with high average discount but thin margins |
| **Q3 – Monthly Volume** | Checks whether discount months actually drove more sales volume (month-over-month) |
| **Q4 – Product Risk Labeling** | Tags products as Healthy / Moderate / Watch / High Risk based on discount level vs. margin |
| **Q5 – Rolling 30-Day Average** | Smooths daily sales to reveal real trend vs. short-term spikes |

## 3. Excel Analysis (`discount_margin_analysis.xlsx`)

Three-sheet workbook:
- **Elasticity** – Price elasticity of demand for products sold at both full price and discount (Tables vs. Copiers)
- **Breakeven** – Breakeven discount % calculator (List Price vs. Cost) compared against actual discount given, with a verdict per product
- **Recommendations** – Business recommendations synthesizing the SQL + Excel findings

## Key Business Insights

- **Discounting is eroding margin overall.** Full-price transactions earn ~24–26% margin across every category; every category flips to *negative* margin once discounted.
- **Furniture / Tables is the worst offender.** –25.15% margin at a 38.33% average discount. Breakeven analysis confirms products like the Lesro Computer Table are discounted (56%) well past their breakeven point (~32%).
- **Technology / Copiers is the exception.** +7.37% margin even at ~19.5% average discount — there's cushion to safely maintain or slightly increase discounting here.
- **Regional discipline varies.** West Region hits its 15% margin target almost exactly and can serve as the governance benchmark; South Region falls well short (8.77% vs. 12% target), pointing to weaker discount controls.
- **Discount tiers show a near-linear profit decline** — average profit per order drops from ~$44.58 (no discount) to ~$35.01 (low discount) to **–$135.72** (high discount, >40%).

**Recommendation:** Introduce a company-wide discount ceiling tied to each product's breakeven threshold, with mandatory manager approval for discounts above ~40%, especially in Furniture and Office Supplies.

## 4. Power BI Dashboard

📊 *Add your Power BI dashboard screenshot below:*

<!-- ![Power BI Dashboard](Power%20BI%20Dashboard/Screenshot%202026-07-22%20144139.png) -->
![alt text](<Screenshot 2026-07-22 144139.png>)



## 5. Excel Analysis Screenshot & Insights


![alt text](<Screenshot 2026-07-23 010725.png>)
![alt text](<Screenshot 2026-07-23 010741.png>)
![alt text](<Screenshot 2026-07-23 010755.png>)

## Tools Used
- **Python (Pandas, NumPy)** – data cleaning & feature engineering
- **SQL** – margin, discount, and trend analysis
- **Excel** – elasticity & breakeven modeling
- **Power BI** – interactive dashboard & visualization
