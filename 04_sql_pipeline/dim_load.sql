-- dim_load.sql
-- Populate dimension tables from staging
-- Marketing Data Warehouse & BI Analytics Platform

PRAGMA foreign_keys = ON;

------------------------------------------------------------
-- 1. Clear existing dimension data (full reload scenario)
------------------------------------------------------------
DELETE FROM dim_country;
DELETE FROM dim_campaign;
DELETE FROM dim_adset;
DELETE FROM dim_creative;

-- NOTE: dim_platform is static, seeded in ddl_tables.sql
-- (TikTok = 1, Meta = 2)

------------------------------------------------------------
-- 2. Populate dim_country
------------------------------------------------------------

INSERT INTO dim_country (country_code, country_name)
SELECT DISTINCT
    country_code,
    CASE country_code
        WHEN 'KSA' THEN 'Saudi Arabia'
        WHEN 'KW'  THEN 'Kuwait'
        ELSE 'Unknown'
    END AS country_name
FROM (
    SELECT UPPER(TRIM(country)) AS country_code FROM stage_tiktok_ads
    UNION
    SELECT UPPER(TRIM(country)) AS country_code FROM stage_meta_ads
    UNION
    SELECT UPPER(TRIM(country)) AS country_code FROM stage_orders
) AS c
WHERE country_code IS NOT NULL AND country_code <> '';

------------------------------------------------------------
-- 3. Create unified ads staging (union TikTok + Meta)
------------------------------------------------------------

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
-- 4. Populate dim_campaign
------------------------------------------------------------

-- Join stage_all_ads with dim_platform to get platform_key
WITH distinct_campaigns AS (
    SELECT DISTINCT
        p.platform_key,
        a.campaign_id,
        a.campaign_name
    FROM stage_all_ads a
    JOIN dim_platform p
      ON p.platform_name = a.platform_name
    WHERE a.campaign_id IS NOT NULL AND a.campaign_id <> ''
)
INSERT INTO dim_campaign (platform_key, campaign_id_src, campaign_name)
SELECT
    platform_key,
    campaign_id,
    campaign_name
FROM distinct_campaigns;

------------------------------------------------------------
-- 5. Populate dim_adset
------------------------------------------------------------

-- We need campaign_key, so first join campaign on platform+campaign_id
WITH campaign_map AS (
    SELECT
        c.campaign_key,
        c.platform_key,
        c.campaign_id_src
    FROM dim_campaign c
),
distinct_adsets AS (
    SELECT DISTINCT
        cm.campaign_key,
        a.adset_id,
        a.adset_name
    FROM stage_all_ads a
    JOIN dim_platform p
      ON p.platform_name = a.platform_name
    JOIN campaign_map cm
      ON cm.platform_key = p.platform_key
     AND cm.campaign_id_src = a.campaign_id
    WHERE a.adset_id IS NOT NULL AND a.adset_id <> ''
)
INSERT INTO dim_adset (campaign_key, adset_id_src, adset_name)
SELECT
    campaign_key,
    adset_id,
    adset_name
FROM distinct_adsets;

------------------------------------------------------------
-- 6. Populate dim_creative
------------------------------------------------------------

WITH adset_map AS (
    SELECT
        a.adset_key,
        a.campaign_key,
        a.adset_id_src
    FROM dim_adset a
),
distinct_creatives AS (
    SELECT DISTINCT
        am.adset_key,
        ads.creative_id,
        ads.creative_name
    FROM stage_all_ads ads
    JOIN dim_platform p
      ON p.platform_name = ads.platform_name
    JOIN dim_campaign c
      ON c.platform_key     = p.platform_key
     AND c.campaign_id_src  = ads.campaign_id
    JOIN adset_map am
      ON am.campaign_key    = c.campaign_key
     AND am.adset_id_src    = ads.adset_id
    WHERE ads.creative_id IS NOT NULL AND ads.creative_id <> ''
)
INSERT INTO dim_creative (adset_key, creative_id_src, creative_name)
SELECT
    adset_key,
    creative_id,
    creative_name
FROM distinct_creatives;
