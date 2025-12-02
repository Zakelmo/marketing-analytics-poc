# Data Catalog
## Marketing Data Warehouse & BI Analytics Platform

This data catalog documents all entities, columns, descriptions, formats, and lineage across the Marketing Data Warehouse (MDW). It serves as the central reference for analysts, BI developers, data engineers, and business stakeholders.

---

# 1. Staging Layer

## 1.1 stage_tiktok_ads

| Column | Type | Description |
|--------|------|-------------|
| report_date | TEXT (YYYY-MM-DD) | Date of the ad performance record |
| campaign_id | TEXT | TikTok campaign ID |
| campaign_name | TEXT | TikTok campaign name |
| adset_id | TEXT | TikTok ad group ID |
| adset_name | TEXT | Audience/ad group name |
| creative_id | TEXT | Creative/video ID |
| creative_name | TEXT | Creative descriptive label |
| country | TEXT | Geographic market (ISO: KSA, KW, etc.) |
| impressions | INTEGER | Number of times ads were displayed |
| clicks | INTEGER | Number of user clicks |
| spend | REAL | Cost spent in local currency |
| conversions | INTEGER | Conversion count (purchase, signup…) |
| revenue | REAL | Revenue attributed to this ad |

---

## 1.2 stage_meta_ads

Same schema as TikTok after normalization.

| Column | Type | Description |
|--------|------|-------------|
| report_date | TEXT | Reporting date |
| campaign_id | TEXT | Meta campaign ID |
| campaign_name | TEXT | Campaign name |
| adset_id | TEXT | Audience/ad group ID |
| adset_name | TEXT | Targeting group name |
| creative_id | TEXT | Creative/ad ID |
| creative_name | TEXT | Asset name |
| country | TEXT | Geo target |
| impressions | INTEGER | Total impressions |
| clicks | INTEGER | Total clicks |
| spend | REAL | Ad spend |
| conversions | INTEGER | Total conversions |
| revenue | REAL | Total revenue |

---

## 1.3 stage_orders

| Column | Type | Description |
|--------|------|-------------|
| order_id | TEXT | E-commerce order ID |
| order_date | TEXT | Date of order |
| customer_id | TEXT | Unique identifier for customer |
| country | TEXT | Customer's country |
| campaign_id | TEXT | Campaign source (UTM) |
| adset_id | TEXT | Adset source |
| creative_id | TEXT | Creative source |
| amount | REAL | Order amount |
| is_new_customer | INTEGER (0/1) | Whether customer is new |

---

# 2. Dimension Tables

## 2.1 dim_platform

| Column | Type | Description |
|--------|------|-------------|
| platform_key | INTEGER | Surrogate primary key |
| platform_name | TEXT | "TikTok" or "Meta" |

---

## 2.2 dim_country

| Column | Type | Description |
|--------|------|-------------|
| country_key | INTEGER | Surrogate key |
| country_code | TEXT | ISO code (KSA, KW, etc.) |
| country_name | TEXT | Full country name |

---

## 2.3 dim_campaign

| Column | Type | Description |
|--------|------|-------------|
| campaign_key | INTEGER | Surrogate key |
| platform_key | INTEGER | Linked to dim_platform |
| campaign_id_src | TEXT | Original campaign ID |
| campaign_name | TEXT | Campaign name |

---

## 2.4 dim_adset

| Column | Type | Description |
|--------|------|-------------|
| adset_key | INTEGER | Surrogate key |
| campaign_key | INTEGER | FK to dim_campaign |
| adset_id_src | TEXT | Source adset ID |
| adset_name | TEXT | Targeting group |

---

## 2.5 dim_creative

| Column | Type | Description |
|--------|------|-------------|
| creative_key | INTEGER | Surrogate key |
| adset_key | INTEGER | FK to dim_adset |
| creative_id_src | TEXT | Source creative ID |
| creative_name | TEXT | Creative label |

---

# 3. Fact Table

## 3.1 fact_marketing_performance

| Column | Type | Description |
|--------|------|-------------|
| fact_id | INTEGER | Surrogate PK |
| date_key | INTEGER | Date in YYYYMMDD format |
| platform_key | INTEGER | FK to platform |
| campaign_key | INTEGER | FK to campaign |
| adset_key | INTEGER | FK to adset |
| creative_key | INTEGER | FK to creative |
| country_key | INTEGER | FK to country |
| impressions | INTEGER | Total impressions |
| clicks | INTEGER | Total clicks |
| spend | REAL | Total ad spend |
| conversions | INTEGER | Conversion count |
| revenue | REAL | Revenue attributed |
| new_customers | INTEGER | Count of first-time buyers |

---

# 4. Data Lineage Summary

### TikTok → stage_tiktok_ads → dims → fact_marketing_performance  
### Meta → stage_meta_ads → dims → fact_marketing_performance  
### Orders → stage_orders → fact_marketing_performance (new_customers)  

---

# 5. Data Ownership

| Dataset | Owner |
|---------|--------|
| TikTok Ads | Performance Marketing Team |
| Meta Ads | Performance Marketing Team |
| Orders | E-commerce / CRM Team |
| Data Warehouse | Data / Engineering |
| Dashboards | BI Team |
