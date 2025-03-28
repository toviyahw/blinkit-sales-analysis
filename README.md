# Blinkit-Sales

### Purpose:
This project aims to analyze sales data to uncover trends, optimize inventory management, and evaluate marketing effectiveness. By leveraging Python libraries like Pandas, Matplotlib, and NumPy, I will explore patterns in sales, delivery efficiency, and marketing effeciency in order to produce a concise report containing actionable insights and recommendations.

### Dataset Description:
Blinkit is an online grocery delivery service based in India. For familiarity purposes, I converted all prices from the Indian Rupee to the United States Dollar. The exchange rate used is current as of March 2025. The original Blinkit Sales dataset consists of 9 different CSV files containing information in different categories such as products, deliveries, and customers. The EDA process document is organized by file, where the cleaning, manipulation, and exploration process is repeated for each one. Each file has been cleaned and explored individually, which allowed me to lay out all of my findings at the end to produce a comprehensive summary containing key business insights and recommendations. The dataset can be previewed and downloaded here: https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset/data.

### Data Description & Research Questions
**File 1: Blinkit Products**
This file contains key product information regarding pricing, profit margins, as well as stock and inventory. 
*Note: the 'mrp' column stands for 'Maximum Retail Price'.*
Research Questions:
- What is the average list price and profit margin across all products, and how do these vary across different categories?
- Which products have the highest and lowest profit margins?
- In which categories do we see the highest and lowest levels of product?

**File 2: Blinkit Deliveries**
This file contains information on order totals, delivery dates, times, and on-time status.
Research Questions:
- How frequently are deliveries late?
- Is there a correlation between order total and delivery time delays?
- Are any delivery partners, customers, or stores having repeated issues with deliveries?

**File 3: Blinkit Units**
This file contains information on unit sales and pricing.
Research Questions:
- fill

**File 4: Blinkit Marketing Performance**
This file contains key information on the marketing performance of the business.
- Optimize ad spend allocation
- Spot seasonal trends
- Understand audience behavior
- Detect correlations and key drivers
- Classify campaigns based on ROAS to prioritize high-performing ones:
- App channel has highest budget but Social Media returns the most revenue.\

**File 5: Blinkit Inventory**
This file contains *may be ommited*
- Optimize ad spend allocation
- Spot seasonal trends
- Understand audience behavior


-OMIT-
File 6 is a file containing information on inventory
File 7 contiained blinkit delivery times much like file 2 with one additional column that listed "Naan" or "Traffic" if there was a delivery delay.


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
- (FIX)Lack of variability in the number or orders placed at each store and deliveries made by each partner. Across the board the values for both of these instances is 1 or 0, leaving analysis of stores or partners who are experiencing frequent delivery issues or success up in the air. Either a store had a late delivery or they did not, all stores only recieved 1 order.

### Tools & Technologies:
- Python Libraries: Pandas, NumPy, Matplotlib, Seaborn.
- Jupyter Notebook: For code execution and analysis.
