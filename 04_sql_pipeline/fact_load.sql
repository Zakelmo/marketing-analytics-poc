-- fact_load.sql
-- Populate fact_marketing_performance from staging + dimensions
-- Marketing Data Warehouse & BI Analytics Platform

PRAGMA foreign_keys = ON;

------------------------------------------------------------
-- 1. Clear existing fact data (full reload)
------------------------------------------------------------
DELETE FROM fact_marketing_performance;

------------------------------------------------------------
-- 2. Reuse stage_all_ads if not present
------------------------------------------------------------

-- If dim_load.sql already created stage_all_ads, this is not needed.
-- But for robustness, we recreate/ensure it exists.

DROP TABLE IF EXISTS stage_all_ads;
CREATE TABLE stage_all_ads AS
SELECT
    'TikTok' AS platform_name,
    t.report_date,
    t.campaign_id,
    t.campaign_name,
    t.adset_id,
    t.adset_name,
    t.creative_id,
    t.creative_name,
    t.country,
    t.impressions,
    t.clicks,
    t.spend,
    t.conversions,
    t.revenue
FROM stage_tiktok_ads t
UNION ALL
SELECT
    'Meta' AS platform_name,
    m.report_date,
    m.campaign_id,
    m.campaign_name,
    m.adset_id,
    m.adset_name,
    m.creative_id,
    m.creative_name,
    m.country,
    m.impressions,
    m.clicks,
    m.spend,
    m.conversions,
    m.revenue
FROM stage_meta_ads m;

------------------------------------------------------------
-- 3. Build key mapping for all ads rows
------------------------------------------------------------

DROP TABLE IF EXISTS stage_ads_with_keys;
CREATE TABLE stage_ads_with_keys AS
SELECT
    a.platform_name,
    a.report_date,
    a.campaign_id,
    a.adset_id,
    a.creative_id,
    UPPER(TRIM(a.country)) AS country_code,
    p.platform_key,
    c.campaign_key,
    d.adset_key,
    cr.creative_key,
    co.country_key,
    a.impressions,
    a.clicks,
    a.spend,
    a.conversions,
    a.revenue
FROM stage_all_ads a
JOIN dim_platform p
  ON p.platform_name = a.platform_name
JOIN dim_campaign c
  ON c.platform_key    = p.platform_key
 AND c.campaign_id_src = a.campaign_id
JOIN dim_adset d
  ON d.campaign_key    = c.campaign_key
 AND d.adset_id_src    = a.adset_id
JOIN dim_creative cr
  ON cr.adset_key      = d.adset_key
 AND cr.creative_id_src = a.creative_id
JOIN dim_country co
  ON co.country_code   = UPPER(TRIM(a.country));

------------------------------------------------------------
-- 4. Aggregate ads performance to fact grain
------------------------------------------------------------

WITH agg_ads AS (
    SELECT
        report_date,
        platform_key,
        campaign_key,
        adset_key,
        creative_key,
        country_key,
        SUM(impressions) AS impressions,
        SUM(clicks)      AS clicks,
        SUM(spend)       AS spend,
        SUM(conversions) AS conversions,
        SUM(revenue)     AS revenue
    FROM stage_ads_with_keys
    GROUP BY
        report_date,
        platform_key,
        campaign_key,
        adset_key,
        creative_key,
        country_key
),

------------------------------------------------------------
-- 5. Aggregate new_customers from orders
------------------------------------------------------------

orders_enriched AS (
    SELECT
        o.order_date,
        o.campaign_id,
        o.adset_id,
        o.creative_id,
        UPPER(TRIM(o.country)) AS country_code,
        SUM(o.is_new_customer) AS new_customers
    FROM stage_orders o
    GROUP BY
        o.order_date,
        o.campaign_id,
        o.adset_id,
        o.creative_id,
        UPPER(TRIM(o.country))
),
orders_with_keys AS (
    SELECT
        oe.order_date,
        sa.platform_key,
        sa.campaign_key,
        sa.adset_key,
        sa.creative_key,
        sa.country_key,
        oe.new_customers
    FROM orders_enriched oe
    JOIN stage_ads_with_keys sa
      ON sa.report_date  = oe.order_date
     AND sa.campaign_id  = oe.campaign_id
     AND sa.adset_id     = oe.adset_id
     AND sa.creative_id  = oe.creative_id
     AND sa.country_code = oe.country_code
),

agg_orders AS (
    SELECT
        order_date AS report_date,
        platform_key,
        campaign_key,
        adset_key,
        creative_key,
        country_key,
        SUM(new_customers) AS new_customers
    FROM orders_with_keys
    GROUP BY
        order_date,
        platform_key,
        campaign_key,
        adset_key,
        creative_key,
        country_key
)

------------------------------------------------------------
-- 6. Final insert into fact_marketing_performance
------------------------------------------------------------
INSERT INTO fact_marketing_performance (
    date_key,
    platform_key,
    campaign_key,
    adset_key,
    creative_key,
    country_key,
    impressions,
    clicks,
    spend,
    conversions,
    revenue,
    new_customers
)
SELECT
    CAST(REPLACE(a.report_date, '-', '') AS INTEGER) AS date_key,
    a.platform_key,
    a.campaign_key,
    a.adset_key,
    a.creative_key,
    a.country_key,
    a.impressions,
    a.clicks,
    a.spend,
    a.conversions,
    a.revenue,
    COALESCE(o.new_customers, 0) AS new_customers
FROM agg_ads a
LEFT JOIN agg_orders o
  ON o.report_date   = a.report_date
 AND o.platform_key  = a.platform_key
 AND o.campaign_key  = a.campaign_key
 AND o.adset_key     = a.adset_key
 AND o.creative_key  = a.creative_key
 AND o.country_key   = a.country_key;
