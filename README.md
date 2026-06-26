# Day9_Frequency_Analysis_Pivot_Charts_&_SQL_Aggregation

# 🏪 E-Commerce Insights & Database Optimization

An analytical review of sales data patterns and search performance optimization benchmarks on a transactional retail dataset (`Day09_practice.db`) using SQLite.

---

## 📈 Core Performance Indicators

* **Top Sales Volume:** The NCR territory leads platform engagement with 67 overall transactions, compared to Mindanao (27), Visayas (19), and Luzon (7).
* **Primary Revenue Anchor:** Electronics is the highest-grossing product segment, generating 1,289,500.00 in total sales revenue. 
* **Regional Buying Maturity:** NCR leads individual customer spending with an Average Order Value (AOV) of 17,621.00. Visayas follows with an AOV of 12,300.00.
* **Peak Sales Window:** May 2025 stands as the most lucrative calendar month on record, contributing 329,000.00 to global lifetime metrics.

---

## 🛍️ Operational & Audience Segmentation

### Product Portfolio Performance
Laptops and Desktop PCs are the cornerstone financial drivers for the platform. A small volume of premium items accounts for the vast majority of gross value. Conversely, high-frequency checkout accessories—such as headsets, mechanical keyboards, and extended mousepads—sustain order frequencies but maintain minor individual margin footprints. 

### Customer Loyalty & Profiles
Five core power-shoppers cross the loyalty threshold of 8 or more distinct checked-out orders, led by Grace Domingo with 14 lifetime transactions. NCR features a highly diversified customer pool of 10 unique individuals sharing its 67 regional orders, while Luzon's entire regional sales volume is driven by a single customer footprint.

---

## ⚡ Database Performance Audit

A critical piece of this optimization project focused on testing database search speeds when tracking monthly revenue timelines. 

To analyze monthly performance, data fields had to be calculated via runtime text function modifications rather than raw timestamp records. Implementing a standard database B-Tree index onto the raw column attribute had zero effect on the query's layout, forcing the database engine to fall back on a full sequential table scan. 

This behavior highlights a core rule of database indexing: traditional B-Tree models only optimize unmodified column value queries. To scale time-series transformations efficiently across enterprise footprints, an expression-based index must be deployed instead.

---

## 🧠 Strategic Engineering Insights

### WHERE vs. HAVING Filtering Scopes
A `WHERE` clause serves as an early gatekeeper, filtering individual row entries before they undergo mathematical summary evaluations or grouping modifications. In contrast, a `HAVING` clause operates exclusively down the database pipeline, filtering aggregated buckets after they have already been structured in engine memory.

### The Value of Quantity Frequency Distributions
Relying solely on mathematical averages risks hiding localized inventory spikes and true consumer behavior. Utilizing a quantity frequency distribution reveals the exact shape of your dataset: orders on the platform heavily cluster around checkout groupings of 1 or 2 units (accounting for 96 combined orders), establishing a predictable transactional rhythm that outliers completely conceal in a generic average.

### Data-Driven Dashboard Architecture
When designing key metrics for corporate stakeholders, a "Top 5 Customers by Total Spend" visualization provides immense value. Rather than overwhelming leadership with rows of text, immediately bubbling up the highest-value accounts surfaces high-impact client retention and strategic planning insights.
