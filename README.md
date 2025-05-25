# Blinkit-Sales

### Purpose:
This project aims to analyze sales data to uncover trends and evaluate marketing effectiveness. By leveraging Python libraries like Pandas, Seaborn, Matplotlib, and NumPy, I will explore patterns in sales, delivery, and marketing effeciency to produce actionable insights and recommendations.

### Dataset Description:
Blinkit is an online grocery delivery service based in India. For familiarity purposes, I converted all prices from the Indian Rupee to the United States Dollar. The exchange rate used is current as of March 2025. The original Blinkit Sales dataset consists of 9 different CSV files containing information in different categories such as products, deliveries, and customers. The EDA process document is organized by file, where the cleaning, manipulation, and exploration process is repeated for each one. Each file has been cleaned and explored individually, which allowed me to lay out all of my findings at the end to produce a comprehensive summary containing key business insights and recommendations. The dataset can be previewed and downloaded here: https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset/data.

The project uses multiple CSV files:
- `blinkit_order_items.csv` — Order-level data including product, quantity, and sales
- `blinkit_delivery_performance.csv` — Delivery metrics like time and distance
- `blinkit_inventory.csv` & `blinkit_inventoryNew.csv` — Inventory stock data
- `blinkit_marketing_performance.csv` — Campaign metrics such as reach and conversions
- `blinkit_customers.csv` & `blinkit_customer_feedback.csv` - Deails on customers and feedback given by them.


### Methodology:
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

### Challenges & Limitations
- There is a lack of variability in the number or orders placed at each store and deliveries made by each partner. Across the board the values for both of these instances is 1 or 0, leaving analysis of stores or partners who are experiencing frequent delivery issues or successes up in the air. Either a store had a late delivery or they did not, all stores only recieved 1 order, all partners delivered only one order.

### Tools & Technologies:
- Python Libraries: Pandas, NumPy, Matplotlib, Seaborn.
- Jupyter Notebook: For code execution and analysis.

### Business Recommendations:

- Inventory Management: Focus restocking efforts on high-demand SKUs and monitor low turnover items to reduce holding costs.
- Marketing Strategy: Refine ad targeting based on conversion performance rather than reach alone.
- Promotional Timing: Schedule discounts or ads during peak demand hours identified in order data.
