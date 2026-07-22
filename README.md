
# Discount Effectiveness & Margin Leakage Analysis

Professional analysis of promotional discounts and their impact on revenue, margin, and ROI using the Global Superstore dataset (2011–2015).

## Project Overview

This project evaluates whether discounts drive profitable volume or instead erode margins. It includes SQL queries, a Python analysis notebook that computes price elasticity and discount ROI by sub-category, a pre-rendered dashboard HTML, and the supporting cleaned transaction dataset.

## Key Files

- `cleaned_transactions.csv` — Primary cleaned transaction dataset used for analysis.
- `discount_effectiveness_python.ipynb` — Main Python notebook: loads data, computes per-transaction margin, calculates elasticity and discount ROI, produces charts, and exports `python_elasticity_roi.csv` to `sql_outputs/`.
- `discount_effectiveness_dashboard.html` — Static dashboard (HTML + CSS) illustrating executive findings, sub-category deep dives, and a product watchlist.
- `discount_analysis_queries.sql` / `analysis_queries.sql` / `discount_analysis_queries.txt` — Parametrized SQL queries used to reproduce the core analyses (Q1–Q5): revenue & margin by category, over-discounted sub-categories, month-over-month volume, product risk labelling, and rolling averages.
- `sql_outputs/python_elasticity_roi.csv` — CSV exported by the Python notebook containing elasticity and discount ROI per sub-category.
- Supporting CSVs: `q1_category_margin.csv`, `q2_subcategory_discount.csv`, `q3_monthly_volume.csv`, `q4_product_risk.csv`, `q5_rolliing_avg.csv` — precomputed query outputs for convenience.
- `elasticity_roi_chart.png` — Visualization exported from the notebook.

## Summary of Findings (from dashboard)

- Discounted transactions show substantially lower margins (dashboard: ~42% lower margin vs full price).
- Some sub-categories (Labels, Paper, Accessories) show positive discount ROI and relatively high elasticity — discounts are profitable there.
- Categories such as Tables, Bookcases, and Binders show deep discounts with negative ROI and represent margin leakage.
- The analysis produces a product watchlist of SKUs that are high risk (high discount + low/negative margin).

## How to Reproduce Locally

Prerequisites

- Python 3.8+ with: `pandas`, `numpy`, `matplotlib`, `seaborn`, `jupyter` (for the notebook).
- A SQL environment (optional) for the provided `.sql` files.

Steps

1. Open and run the notebook: `discount_effectiveness_python.ipynb` (the notebook expects `cleaned_transactions.csv` in the repository root). Run all cells to generate `sql_outputs/python_elasticity_roi.csv` and `elasticity_roi_chart.png`.
2. To reproduce SQL analyses, run the queries in `discount_analysis_queries.sql` (or `analysis_queries.sql`) against a database containing the `transactions` table (the SQL assumes a `discount_analysis` schema/database).
3. Open `discount_effectiveness_dashboard.html` in a browser to view the static presentation of findings.

Example: installing Python dependencies quickly

```bash
python -m pip install pandas numpy matplotlib seaborn jupyter
```

## Notes & Methodology

- Elasticity: estimated as the percent change in average quantity divided by percent change in average price between discounted and full-price transactions per sub-category.
- Discount ROI: compares incremental profit from extra units sold under discounting to margin given up on baseline units (see `discount_effectiveness_python.ipynb` for the exact implementation).
- SQL queries (Q1–Q5) are documented with purpose comments at the top of `discount_analysis_queries.sql`.

## Outputs

- `sql_outputs/python_elasticity_roi.csv` — final per-sub-category metrics (elasticity, discount ROI) produced by the notebook.
- `elasticity_roi_chart.png` — saved charts used in the dashboard.

## Next steps & suggestions

- Parameterize and wrap notebook logic into a script or small module for scheduled runs.
- Convert the static HTML into an interactive dashboard (Dash/Streamlit) to enable filters and drilldowns.
- Add unit tests for calculation functions (elasticity, ROI) if extracting to a library.
