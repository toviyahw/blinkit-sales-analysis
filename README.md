# Blinkit Sales Analysis

## Purpose:
This project aims to analyze sales data to uncover trends and evaluate marketing effectiveness. By leveraging Python libraries like Pandas, Seaborn, Matplotlib, and NumPy, I will explore patterns in sales, delivery, and marketing effeciency to produce actionable insights and recommendations.

## Dataset Description:
Blinkit is an online grocery delivery service based in India. For familiarity purposes, I converted all prices from the Indian Rupee to the United States Dollar. The exchange rate used is current as of March 2025. The original Blinkit Sales dataset consists of 9 different CSV files containing information in different categories such as products, deliveries, and customers. The EDA process document is organized by file, where the cleaning, manipulation, and exploration process is repeated for each one. Each file has been cleaned and explored individually, which allowed me to lay out all of my findings at the end to produce a comprehensive summary containing key business insights and recommendations. The dataset can be previewed and downloaded here: https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset/data.

The project uses multiple CSV files:
- `blinkit_order_items.csv` — Order-level data including product, quantity, and sales
- `blinkit_delivery_performance.csv` — Delivery metrics like time and distance
- `blinkit_inventory.csv` & `blinkit_inventoryNew.csv` — Inventory stock data
- `blinkit_marketing_performance.csv` — Campaign metrics such as reach and conversions

## Methodology:
1. Data Cleaning & Preprocessing:
Load and inspect the datasets using Pandas.
Handle missing values and inconsistent data entries if necessary.
Convert categorical data into appropriate formats.

2. Exploratory Data Analysis (EDA):
Generate summary statistics for key numerical and categorical variables.
Analyze sales distribution and seasonal trends.
Identify top-selling and least-selling products.
Investigate correlations between pricing, sales volume, and marketing efforts.

3. Data Visualization:
Create bar charts and histograms to show sales trends across different categories.
Develop time-series plots to analyze seasonal patterns in sales.
Use heatmaps to identify relationships between different features (e.g., sales and marketing spend).
Visualize inventory turnover and stockout trends.

## Challenges and Limitations:
- There is a lack of variability in the number or orders placed at each store and deliveries made by each partner. Across the board the values for both of these instances is 1 or 0, leaving analysis of stores or partners who are experiencing frequent delivery issues or successes up in the air. Either a store had a late delivery or they did not, all stores only recieved 1 order, all partners delivered only one order.

## Tools and Technologies:
- Python Libraries: Pandas, NumPy, Matplotlib, Seaborn.
- Jupyter Notebook: For code execution and analysis.

## Business Insights and Recommendations:

### 1. Product Pricing and Margins
- The **average product price** is **$5.86**, and the **average margin** is **27.77%**.
- Categories with the highest margins:
  - *Instant & Frozen Food (40%)*
  - *Personal Care (35%)*
  - *Pet Care (35%)*
  - *Snacks & Munchies* (35%)*
- The lowest-margin category is *Fruits & Vegetables*.

 **Recommendation:**\
  Target promotions towards high-margin categories to maximize profits. Re-evaluate pricing or sourcing strategies for products in the lower-margin categories.

### 2. Product Popularity vs. Revenue
- The most frequently ordered items and the items generating the most revenue do not fully overlap
- Product_id `51036` is a strong performer, appearing at the top for order freqency and revenue generation
- Some of the most ordered products generate lower revenue, suggesting low prices or margins

 **Recommendation:**\
  Prioritize markering for products that are both high-frequency and high-revenue. Review pricing or bundling strategies for high-volume but low-revenue items.

### 3. Order Value and Size (Blinkit_Units)
- **Average order value** is **$11.73**.
- Customers typically purchase **2 items** per order, with low variance

 **Recommendation:**\
  Introduce offers like 'buy 2, get 1 free' or small discounts for orders containing 3+ items to increase average order size and value.

### 4. Inventory Loss
- Highest rates of overall damaged stock received occurred in:
  - *August 2023 (24.4%)*
  - *October 2023 (19.2%)*
  - *June 2023 (16.6%)*
- Frequently damaged products include:
  - *`124290` (12.26%)*
  - *`317242`, `661577`, `897083`, etc. (above 8%)*
 
   **Recommendation:**
  Investigate packaging, handling, or supplier practices during high-damage months. Apply quality checks or consider different suppliers for persistently damaged SKU's.

### 5. Delivery Performance and Customer Ordering Behavior
- **61.96% of deliveries were late**
- **Average delivery time** across all orders: **4.44 minutes**
- **On-time orders** average only **2.47 minutes**
- There is no observed correlation betwen order total and delivery speed

 **Recommendation (Limited due to little variation in Store and Partner delivery data):**
 Conduct root-cause analysis on logistics delays. Consider:
 - Revising delivery staff scheduling/coverage
 - Adjusting ETA shown to customers
 - Optimize routes for high-traffic areas
Though all customers deserve fast delivery, consider premium delivery perks for ** loyal or high-spend customers** to increase satisfacton and retention.

### 6. Customer Spending and Order Frequency
- **Average total spend per customer: $26.31**
- **Spending varies widely**, typically by about $11.99 above or below the average spend
- **Customers place an average of 2.3 orders**
- **Top customers placed a similar number of orders**. The top customer placed 9 orders, followed by two customers placing 8, and many others placing 7.

 **Recommendation:**
 Identify top repeat customers and offer **excusive deals or early access** promotions. These users are beneficial for word-of-mouth marketing and retention.
 Segment customers by spending tiers. Develop personlized marketing for:
 - High-frequency buyers (loyaly program or tiered rewards)
 - Low-spend customers (incentives to re-engage with the service)

### 7. 
  
