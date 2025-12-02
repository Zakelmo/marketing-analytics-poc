# Power BI Dashboard Specification
## Marketing Data Warehouse & BI Analytics Platform

This document describes the structure, visuals, fields, measures, interactions, and navigation for the Power BI report.

The report is built on top of the **Marketing Data Warehouse** with:

- Fact: `fact_marketing_performance`
- Dimensions: `dim_platform`, `dim_country`, `dim_campaign`, `dim_adset`, `dim_creative`

---

# 1. Data Model in Power BI

## 1.1 Imported Tables

- `fact_marketing_performance`
- `dim_platform`
- `dim_country`
- `dim_campaign`
- `dim_adset`
- `dim_creative`

## 1.2 Relationships

All relationships are **Many-to-One**, single direction from dimension to fact:

- `fact_marketing_performance[platform_key]` → `dim_platform[platform_key]`
- `fact_marketing_performance[country_key]` → `dim_country[country_key]`
- `fact_marketing_performance[campaign_key]` → `dim_campaign[campaign_key]`
- `fact_marketing_performance[adset_key]` → `dim_adset[adset_key]`
- `fact_marketing_performance[creative_key]` → `dim_creative[creative_key]`

## 1.3 Calculated Columns

### Date (in fact table)

```DAX
Date =
DATE (
    INT ( fact_marketing_performance[date_key] / 10000 ),
    INT ( MOD ( fact_marketing_performance[date_key], 10000 ) / 100 ),
    MOD ( fact_marketing_performance[date_key], 100 )
)
