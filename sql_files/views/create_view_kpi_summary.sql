CREATE VIEW kpi_summary AS
SELECT 
    ROUND(SUM(mp.revenue_generated * 0.012), 2) AS total_revenue_usd,
    ROUND(SUM(mp.spend * 0.012), 2) AS total_spend_usd,
    SUM(mp.conversions) AS total_conversions,
    ROUND(SUM(mp.revenue_generated) / NULLIF(SUM(mp.spend), 0), 2) AS roas,
    COUNT(DISTINCT c.customer_id) AS customers_acquired,
    ROUND(SUM(mp.spend * 0.012) / NULLIF(COUNT(DISTINCT c.customer_id), 0), 2) 
	AS cac,
    ROUND(100.0 * COUNT(CASE WHEN c.total_orders > 1 THEN 1 END) / NULLIF(COUNT(c.customer_id), 0), 2) 
	AS retention_rate_pct,
    ROUND(100.0 * SUM(mp.conversions) / NULLIF(SUM(mp.clicks), 0), 2) AS avg_conversion_rate_pct

FROM marketing_performance mp
JOIN customers c
  ON DATE_TRUNC('month', c.registration_date) = DATE_TRUNC('month', mp.date);
