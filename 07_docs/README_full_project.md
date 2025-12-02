# Full Project Documentation
## Marketing Data Warehouse & BI Analytics Platform

This document provides a complete overview of the technical architecture, pipelines, modeling decisions, and analytical components of the project.

---

# 1. Introduction

This project is an end-to-end marketing analytics platform designed to unify advertising and revenue data across:

- TikTok Ads  
- Meta Ads  
- E-Commerce Orders  

The solution implements:
- A governed data warehouse  
- A structured ETL pipeline  
- A semantic model for BI consumption  
- Python-based exploratory and predictive analytics  
- Enterprise-quality documentation (BRD, FS, governance, ERD, DDL)  
- Power BI dashboards for leadership decision-making  

---

# 2. Architecture Overview

Raw Data (CSV)
↓
01 Staging Layer (SQLite)
↓
02 Data Warehouse (Star Schema)
↓
03 Python Analytics (KPIs, EDA, ML)
↓
04 Power BI Dashboards


The warehouse serves as the **single source of truth** for all paid marketing KPIs.

---

# 3. Data Pipeline

## 3.1 Staging Layer
Purpose:
- Store raw, unaltered data  
- Standardize column names  
- Clean and trim text fields  
- Validate basic data quality  

Tables:
- stage_tiktok_ads  
- stage_meta_ads  
- stage_orders  

## 3.2 Transformation Layer
Key tasks:
- Unify TikTok & Meta into `stage_all_ads`  
- Create dimensional entities (campaign, adset, creative, country, platform)  
- Generate surrogate keys  
- Build fact table at correct grain  

## 3.3 Fact Grain
**date × platform × campaign × adset × creative × country**

This allows filtering & drilldown down to creative-level performance across geographies.

---

# 4. Data Model

A star schema composed of:

**Fact Table**
- `fact_marketing_performance`  

**Dimensions**
- `dim_platform`  
- `dim_campaign`  
- `dim_adset`  
- `dim_creative`  
- `dim_country`  

Full ERD is included in:
`03_data_model/erd_marketing_dw.png`

---

# 5. KPI Governance

KPIs are standardized in:
`02_data_governance/kpi_dictionary.md`

Examples:
- CTR = clicks / impressions  
- ROAS = revenue / spend  
- CAC = spend / new_customers  

This ensures consistency across:
- Dashboards  
- Python analytics  
- Reporting  

---

# 6. Data Quality Framework

Rules included in:
`02_data_governance/data_quality_rules.md`

Covers:
- Completeness  
- Accuracy  
- Referential integrity  
- Grain enforcement  
- Range validation  

Data quality dashboard included in Power BI.

---

# 7. Python Analytics Layer

Notebook located here:
`05_notebooks/marketing_eda_and_model.ipynb`

Capabilities:
- Load DW via SQLAlchemy  
- Compute KPIs  
- Campaign and creative performance analysis  
- Visualizations (scatter, line charts, bar charts)  
- Conversion prediction using RandomForest  
- Feature importance extraction  

---

# 8. Power BI Dashboards

Spec located here:
`06_dashboards/powerbi_marketing_dashboard_spec.md`

Pages:
1. Executive Overview  
2. Campaign Performance  
3. Creative Intelligence  
4. Data Quality Monitor  
5. Budget Simulator (optional)

Measures defined in DAX include:
- ROAS  
- CTR  
- CVR  
- CAC  
- Creative classification  

---

# 9. Extensibility & Scalability

The project is designed to scale by adding:
- New ad platforms  
- New data sources  
- Real-time ingestion via APIs  
- Additional fact tables (LTV, cohorts)  
- New dimensions (audience, device, placement)  
- Cloud migration (BigQuery, Redshift, Snowflake)  

---

# 10. File Structure

marketing-analytics-poc/
01_requirements/
02_data_governance/
03_data_model/
04_sql_pipeline/
05_notebooks/
06_dashboards/
07_docs/
marketing_dw.db
README.md


---

# 11. Conclusion

This project demonstrates mastery of:

- Business analysis  
- Data modeling  
- Data governance  
- SQL pipelines  
- Python analytics  
- BI dashboard development  
- End-to-end data lifecycle management  

It serves as a powerful portfolio piece for roles such as:
- Business Analyst  
- Data Analyst  
- BI Analyst  
- Analytics Engineer  
- Product Analyst  

