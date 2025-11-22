# Model-Car-Analysis

## Overview
Model-Car-Analysis is a comprehensive SQL-driven analytics project for a model car business. It leverages a relational database to generate actionable insights about customers, orders, products, payments, employees, and offices. All reporting, analysis, and business intelligence tasks are completed through SQL scripts; insights and recommendations are documented and visualized in slides.

## Database Structure

| Table         | Description                                              |
|---------------|---------------------------------------------------------|
| Customers     | Customer data, credit limits, contact info              |
| Products      | Scale model cars catalog, prices, inventory             |
| ProductLines  | Product categories                                      |
| Orders        | Order placements by customers                           |
| OrderDetails  | Items and prices for each order                         |
| Payments      | Payment records and credit tracking                     |
| Employees     | Employee details and org chart                          |
| Offices       | Sales office locations                                  |

## Analysis Scripts (SQL)

**Customer-Data-Analysis.sql**
- Top customers by credit limit and total sales
- Average credit limit by country and region
- Detects dormant customers (no orders)
- Customer-sales rep associations
- Payment recency and credit alerts
- Product line segmentation (procedure)
- Customers who purchased premium products

**Order-Analysis.sql**
- Computes average order value per customer
- Tracks monthly order volumes
- Flags pending shipments and statuses
- Joins customer/order details for reporting
- Identifies profitable and recent orders
- Calculates order-based sales and product combos
- Automation via triggers for credit/inventory policies

**Product-Data-Analysis.sql**
- Counts by product line, pricing bands
- Flags low inventory (<10 units), need for restock
- Analyzes product and product line sales performance
- Identifies most/least expensive and most popular items

**Employee-Data-Analysis.sql**
- Total staff and distribution by job title
- Reports-to structure (leadership mapping)
- Sales representative ranking by total generated revenue
- Lists office-wise top performers
- Benchmarks profitability

**Office-Data-Analysis.sql**
- Employee counts per office/city
- Gaps and clusters in office staffing
- Territory coverage and office regions
- Flags offices with no active employees
- Shows most profitable office locations and average customer credit

## Presentation (`SQL-Project-PPT.pptx`)
- Executive summary, DB structure (ER diagram)
- Workforce and sales hierarchy across 7 offices
- Sales performance highlights (top reps, offices)
- Customer segmentation, dormant accounts, and payment trends
- Office territory and regional efficiency
- Product lines: sales volume, premium markets
- Inventory/stock alerts, product profitability
- Order analysis: trends, peak months, best orders
- Automation via triggers; impact on operations
- Strategic takeaways, recommendations

## Key Business Findings
- Julie Firrelli is the top sales rep ($491K revenue), Boston office leads globally, Paris = top revenue ($1.04M+)
- March & November are high-sales months, dormant customer pool detected, premium product buyers clustered by region
- Classic Cars are top revenue line, motorcycles = niche premium market
- Automation reduces errors, enforces credit/inventory policies, boosts reporting accuracy

## Files Included

- `DS1_C2_S9_Database_modelcarsdb.sql` (full schema + sample data)
- `Customer-Data-Analysis.sql`
- `Order-Analysis.sql`
- `Product-Data-Analysis.sql`
- `Employee-Data-Analysis.sql`
- `Office-Data-Analysis.sql`
- `Summary.docx` (findings + recommendations)
- `SQL-Project-PPT.pptx` (visual slides)
- `Data Dictionary.png` (field overview)
- `ER Diagram.png` (database relationships)

## Getting Started

2. Set up the database:
- Use `DS1_C2_S9_Database_modelcarsdb.sql` in MySQL/MariaDB
3. Analyze:
- Run any supplied `.sql` file using your SQL client
4. Review:
- Open Summary and PPT for business recommendations and visualization

## Usage

- Learn/practice SQL analytics and business intelligence
- Refer to a complete case for BI reporting and database design
- Extend for dashboards, triggers, or additional analytics

--

**Author:** Santhosh (Chandra Sekar)

