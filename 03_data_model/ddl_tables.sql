-- DDL for Marketing Data Warehouse
-- Marketing Data Warehouse & BI Analytics Platform

PRAGMA foreign_keys = ON;

--------------------------------------------------
-- 1. STAGING TABLES
--------------------------------------------------

DROP TABLE IF EXISTS stage_tiktok_ads;
CREATE TABLE stage_tiktok_ads (
    report_date   TEXT,
    campaign_id   TEXT,
    campaign_name TEXT,
    adset_id      TEXT,
    adset_name    TEXT,
    creative_id   TEXT,
    creative_name TEXT,
    country       TEXT,
    impressions   INTEGER,
    clicks        INTEGER,
    spend         REAL,
    conversions   INTEGER,
    revenue       REAL
);

DROP TABLE IF EXISTS stage_meta_ads;
CREATE TABLE stage_meta_ads (
    report_date   TEXT,
    campaign_id   TEXT,
    campaign_name TEXT,
    adset_id      TEXT,
    adset_name    TEXT,
    creative_id   TEXT,
    creative_name TEXT,
    country       TEXT,
    impressions   INTEGER,
    clicks        INTEGER,
    spend         REAL,
    conversions   INTEGER,
    revenue       REAL
);

DROP TABLE IF EXISTS stage_orders;
CREATE TABLE stage_orders (
    order_id        TEXT,
    order_date      TEXT,
    customer_id     TEXT,
    country         TEXT,
    campaign_id     TEXT,
    adset_id        TEXT,
    creative_id     TEXT,
    amount          REAL,
    is_new_customer INTEGER
);

--------------------------------------------------
-- 2. DIMENSION TABLES
--------------------------------------------------

DROP TABLE IF EXISTS dim_platform;
CREATE TABLE dim_platform (
    platform_key  INTEGER PRIMARY KEY,
    platform_name TEXT NOT NULL
);

DROP TABLE IF EXISTS dim_country;
CREATE TABLE dim_country (
    country_key  INTEGER PRIMARY KEY AUTOINCREMENT,
    country_code TEXT NOT NULL,
    country_name TEXT NOT NULL
);

DROP TABLE IF EXISTS dim_campaign;
CREATE TABLE dim_campaign (
    campaign_key   INTEGER PRIMARY KEY AUTOINCREMENT,
    platform_key   INTEGER NOT NULL,
    campaign_id_src TEXT NOT NULL,
    campaign_name  TEXT NOT NULL,
    FOREIGN KEY (platform_key) REFERENCES dim_platform (platform_key)
);

DROP TABLE IF EXISTS dim_adset;
CREATE TABLE dim_adset (
    adset_key    INTEGER PRIMARY KEY AUTOINCREMENT,
    campaign_key INTEGER NOT NULL,
    adset_id_src TEXT NOT NULL,
    adset_name   TEXT NOT NULL,
    FOREIGN KEY (campaign_key) REFERENCES dim_campaign (campaign_key)
);

DROP TABLE IF EXISTS dim_creative;
CREATE TABLE dim_creative (
    creative_key    INTEGER PRIMARY KEY AUTOINCREMENT,
    adset_key       INTEGER NOT NULL,
    creative_id_src TEXT NOT NULL,
    creative_name   TEXT NOT NULL,
    FOREIGN KEY (adset_key) REFERENCES dim_adset (adset_key)
);

--------------------------------------------------
-- 3. FACT TABLE
--------------------------------------------------

DROP TABLE IF EXISTS fact_marketing_performance;
CREATE TABLE fact_marketing_performance (
    fact_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    date_key      INTEGER NOT NULL,  -- format: YYYYMMDD
    platform_key  INTEGER NOT NULL,
    campaign_key  INTEGER NOT NULL,
    adset_key     INTEGER NOT NULL,
    creative_key  INTEGER NOT NULL,
    country_key   INTEGER NOT NULL,
    impressions   INTEGER NOT NULL DEFAULT 0,
    clicks        INTEGER NOT NULL DEFAULT 0,
    spend         REAL    NOT NULL DEFAULT 0,
    conversions   INTEGER NOT NULL DEFAULT 0,
    revenue       REAL    NOT NULL DEFAULT 0,
    new_customers INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (platform_key) REFERENCES dim_platform (platform_key),
    FOREIGN KEY (campaign_key) REFERENCES dim_campaign (campaign_key),
    FOREIGN KEY (adset_key)    REFERENCES dim_adset (adset_key),
    FOREIGN KEY (creative_key) REFERENCES dim_creative (creative_key),
    FOREIGN KEY (country_key)  REFERENCES dim_country (country_key)
);

--------------------------------------------------
-- 4. INDEXES (PERFORMANCE)
--------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_fact_date
    ON fact_marketing_performance (date_key);

CREATE INDEX IF NOT EXISTS idx_fact_platform
    ON fact_marketing_performance (platform_key);

CREATE INDEX IF NOT EXISTS idx_fact_campaign
    ON fact_marketing_performance (campaign_key);

CREATE INDEX IF NOT EXISTS idx_fact_creative
    ON fact_marketing_performance (creative_key);

CREATE INDEX IF NOT EXISTS idx_fact_country
    ON fact_marketing_performance (country_key);

--------------------------------------------------
-- 5. SEED DATA FOR dim_platform (OPTIONAL)
--------------------------------------------------

INSERT INTO dim_platform (platform_key, platform_name) VALUES
(1, 'TikTok'),
(2, 'Meta');
