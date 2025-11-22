# Model-Car-Analysis

## Overview
Model-Car-Analysis is a comprehensive, SQL-driven analytics project for a model car business. The database design, queries, and analysis files together provide actionable insights into customers, sales orders, products, payments, employee performance, and office operations.

## Database Structure

| Table         | Description                                              |
|---------------|---------------------------------------------------------|
| Customers     | Customer data                                           |
| Products      | Scale model car catalog                                 |
| ProductLines  | Categories for product organization                     |
| Orders        | Sales orders from customers                             |
| OrderDetails  | Line items for each order                               |
| Payments      | Customer payments, credit tracking                      |
| Employees     | Staff data, org structure, sales reps                   |
| Offices       | Sales office locations                                  |

(Relation details and attributes are shown in the ER Diagram.)

## Business Analysis & Insights

**Customer Analysis (`Customer-Data-Analysis.sql`)**
- Top 10 customers by credit limit
- Average credit limit per country
- Customer count by region/state
- Unengaged customers without orders
- Total sales per customer
- Customer/sales rep relationships
- Recent payments per customer
- Credit limit exceeders
- Customers buying by product line (procedure)
- Customers who bought the most expensive product

**Order Analysis (`Order-Analysis.sql`)**
- Average order amounts and total sales per order
- Orders placed per month
- Pending shipments and order tracking
- Recent orders and profitable orders
- Most frequently ordered products
- Revenue, profit calculations, and triggers for credit/inventory updates
- Popular product combinations

**Product Analysis (`Product-Data-Analysis.sql`)**
- Count per product line, high-value lines
- Price and inventory analysis
- Top-selling products (procedure)
- Products ordered by most customers
- Low inventory flagging for specific lines

**Employee Analysis (`Employee-Data-Analysis.sql`)**
- Employee and job title counts
- Leadership structure
- Sales rep performance and profit contributions
- Employees exceeding office average sales

**Office Analysis (`Office-Data-Analysis.sql`)**
- Employee count per office/location
- Most/least staffed offices
- Office territory and location mapping
- Profitable office locations
- Average customer credit per office

## Core Files

- `DS1_C2_S9_Database_modelcarsdb.sql` — SQL schema and demo dataset
- `/Analysis/` — Modular SQL scripts for each business area (see above)
- `Summary.docx` — Extracted insights and business recommendations
- `Data Dictionary.png` — Data table summary
- `ER Diagram.png` — Full entity-relationship diagram
- `SQL Project PPT.pptx` — Slideshow covering project logic and results

## Getting Started

1. **Clone the Repository**
