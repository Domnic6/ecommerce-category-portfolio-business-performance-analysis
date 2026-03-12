# Ecommerce Category Portfolio & Business Performance Analysis

This project analyzes ecommerce product category performance using the **thelook_ecommerce** Google BigQuery public dataset.

The objective of this analysis is to evaluate the structure of the product portfolio by examining revenue contribution, order distribution, pricing tiers, and operational stability across product categories.

SQL transformations were used to build structured analytical tables which were then visualized in **Power BI** to enable category-level performance analysis.

---

## Tools Used

- SQL (Google BigQuery)
- Power BI

---

## Analysis Performed

- Built category-level analytical tables combining transactional order data with product dimension data.
- Calculated key category performance metrics including:
  - Total Revenue
  - Total Orders
  - Average Order Value (AOV)
  - Revenue per User
  - Cancellation Rate
  - Revenue Share and Order Share
- Evaluated pricing tiers across product categories using AOV comparisons.
- Analyzed revenue concentration patterns across the product portfolio.
- Assessed operational stability through cancellation rate comaprisions.

---

## Key Insights

- The **Top 5 product categories contribute approximately 43.5% of total revenue**, indicating moderate revenue concentration within the portfolio.
- **Outwear & Coats** generate a disproportionately high share of revenue relative to order volume, indicating a premium pricing segment.
- **Tops & Tees and Intimates** generate the highest order volumes, acting as traffic-driving categories.
- Cancellation rates remain relatively stable across categories (**14-16%**), indicating constitent operational performance without major risk segments.
- The portfolio contains a balanced mix of **premium categories and high-volume categories**, supporting diversified revenue generation.

---

## Repository Contains

- `category_portfolio_queries.sql` --SQL queries used to generate category-level performance metrics.
- `category_portfolio_dashboard.png` -- Power BI dashboard visualizing category revenue distribution, order volume, pricing tiers, and operational stability.












