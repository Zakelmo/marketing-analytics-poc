-- staging_load.sql
-- Load raw data into staging tables
-- Marketing Data Warehouse & BI Analytics Platform

PRAGMA foreign_keys = OFF;

------------------------------------------------------------
-- 1. Clear existing staging data (idempotent loads)
------------------------------------------------------------
DELETE FROM stage_tiktok_ads;
DELETE FROM stage_meta_ads;
DELETE FROM stage_orders;

------------------------------------------------------------
-- 2. CSV IMPORT (SQLite CLI EXAMPLE)
-- NOTE:
-- These commands are for sqlite3 CLI.
-- If you're using DBeaver / DB Browser / another DB, 
-- import the CSVs using its UI, but into these tables.
------------------------------------------------------------

-- Example usage in terminal (NOT executed inside SQL engine):
--   sqlite3 marketing_dw.db
--   .mode csv
--   .headers on
--   .import tiktok_ads_raw.csv stage_tiktok_ads
--   .import meta_ads_raw.csv stage_meta_ads
--   .import orders_raw.csv stage_orders

-- If using other engines (e.g., Postgres, MySQL), replace this
-- section with COPY / LOAD DATA commands.

------------------------------------------------------------
-- 3. BASIC NORMALIZATION / SANITY CHECKS
------------------------------------------------------------

-- Trim whitespace
UPDATE stage_tiktok_ads
SET campaign_id   = TRIM(campaign_id),
    campaign_name = TRIM(campaign_name),
    adset_id      = TRIM(adset_id),
    adset_name    = TRIM(adset_name),
    creative_id   = TRIM(creative_id),
    creative_name = TRIM(creative_name),
    country       = UPPER(TRIM(country));

UPDATE stage_meta_ads
SET campaign_id   = TRIM(campaign_id),
    campaign_name = TRIM(campaign_name),
    adset_id      = TRIM(adset_id),
    adset_name    = TRIM(adset_name),
    creative_id   = TRIM(creative_id),
    creative_name = TRIM(creative_name),
    country       = UPPER(TRIM(country));

UPDATE stage_orders
SET order_id        = TRIM(order_id),
    customer_id     = TRIM(customer_id),
    campaign_id     = TRIM(campaign_id),
    adset_id        = TRIM(adset_id),
    creative_id     = TRIM(creative_id),
    country         = UPPER(TRIM(country));

------------------------------------------------------------
-- 4. DATA QUALITY PRE-CHECKS (OPTIONAL REPORTING QUERIES)
------------------------------------------------------------

-- Example checks (for manual review):

-- Clicks > Impressions (invalid)
-- SELECT 'TikTok' AS src, * FROM stage_tiktok_ads WHERE clicks > impressions
-- UNION ALL
-- SELECT 'Meta' AS src, * FROM stage_meta_ads WHERE clicks > impressions;

-- Negative spend
-- SELECT 'TikTok' AS src, * FROM stage_tiktok_ads WHERE spend < 0
-- UNION ALL
-- SELECT 'Meta' AS src, * FROM stage_meta_ads WHERE spend < 0;

-- Missing primary identifiers
-- SELECT * FROM stage_tiktok_ads WHERE campaign_id IS NULL OR campaign_id = '';
-- SELECT * FROM stage_meta_ads   WHERE campaign_id IS NULL OR campaign_id = '';

PRAGMA foreign_keys = ON;
