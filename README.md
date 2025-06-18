# 📊 SQL Ad-Hoc Business Insights Project | Codebasics Resume Challenge

This project presents a collection of real-world ad-hoc SQL requests solved as part of the Codebasics Resume Project Challenge. The dataset simulates a consumer hardware company—**Atliq Hardware**—where we analyze business performance using SQL across sales, products, customers, and pricing.

## 🧠 Objective

To demonstrate SQL proficiency through solving realistic, business-relevant ad-hoc queries that assist stakeholders in making data-driven decisions across sales, marketing, and operations.

---

## 🛠️ Tools Used
- SQL (MySQL)
- Excel
- GitHub (for versioning)

---

## 🧩 Ad-Hoc Business Questions Solved

### 1. In which APAC markets does "Atliq Exclusive" operate?
- 📌 *Goal:* Understand regional reach of a strategic customer.
- 🔍 *How:* Filtered `dim_customer` table using `WHERE` and `DISTINCT`.

### 2. What’s the % increase in unique products (2021 vs. 2020)?
- 📌 *Goal:* Track product diversification over time.
- 🔍 *How:* Used CTEs, `COUNT(DISTINCT)` and cross join for comparison.

### 3. Product count by segment
- 📌 *Goal:* Identify segments with broadest portfolios.
- 🔍 *How:* Aggregated product data using `GROUP BY`.

### 4. Segment with highest increase in unique products
- 📌 *Goal:* Spot high-growth areas for product innovation.
- 🔍 *How:* Compared product counts year-over-year using CTEs and joins.

### 5. Products with highest and lowest manufacturing costs
- 📌 *Goal:* Analyze cost structure and pricing strategy.
- 🔍 *How:* Used `MIN`, `MAX`, and subqueries with `JOIN`s.

### 6. Top 5 customers with highest average pre-invoice discounts in India (FY2021)
- 📌 *Goal:* Assess discount strategy and customer value.
- 🔍 *How:* Aggregated discounts using `AVG()` and filtered with `LIMIT`.

### 7. Monthly gross sales for "Atliq Exclusive"
- 📌 *Goal:* Identify low/high-performing months.
- 🔍 *How:* Calculated `gross_sales = price * quantity`, grouped by `MONTH/YEAR`.

### 8. Highest sold quarter in 2020
- 📌 *Goal:* Detect peak sales periods.
- 🔍 *How:* Used `QUARTER(date)`, aggregated with `SUM(sold_quantity)`.

### 9. Channel with highest gross sales & % contribution (FY2021)
- 📌 *Goal:* Optimize channel performance.
- 🔍 *How:* Calculated total and per-channel sales to derive % share.

### 10. Top 3 products in each division by total sold quantity (FY2021)
- 📌 *Goal:* Showcase bestsellers per division.
- 🔍 *How:* Used `RANK()` with `PARTITION BY division`.

---

## 🏁 Outcome

- Gained hands-on experience with **SQL window functions, joins, CTEs**, and business problem-solving.
- Delivered insights in a structured, stakeholder-ready format.
- Created a presentation-ready output using SQL logic and BI principles.

---

## 📎 Resources
- [SQL Scripts](https://github.com/Shivtej29/SQL-Ad-Hoc-Business-Insights-Project/blob/main/atliq_hardware_queries.sql)

---

## 📬 Contact
**Shivtej Muthyala**  
📧 shivtejmuthyala0007@gmail.com  
🌐 [LinkedIn](https://www.linkedin.com/in/shivtejmuthyala) | [Portfolio](https://codebasics.io/portfolio/Shivtej-Muthyala)
