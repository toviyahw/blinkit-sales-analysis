CREATE TABLE marketing_performance(
campaign_id TEXT PRIMARY KEY,
campaign_name TEXT,
date DATE,
target_audience TEXT,
channel TEXT,
impressions INTEGER,
clicks INTEGER,
conversions INTEGER,
spend NUMERIC(10,2),
revenue_generated NUMERIC(10,2),
roas NUMERIC(5,2)
);