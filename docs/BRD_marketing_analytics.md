# 📘 Business Requirements Document (BRD)
## Marketing Performance Analytics Platform – POC

---

## 1. Project Context

A growing GCC e-commerce brand invests heavily in digital advertising across **TikTok Ads** and **Meta Ads**, using Cash-on-Delivery (COD) as the primary fulfillment method. 

Today, the brand faces several challenges:
- Fragmented data across multiple platforms
- No unified source of truth for marketing performance
- Non-standard KPIs, making reporting inconsistent
- No visibility on which campaigns or creatives drive ROAS
- Slow manual reporting that prevents rapid optimization

This Proof of Concept (POC) aims to create a **centralized analytics platform** that empowers marketing and leadership teams to make data-driven decisions.

---

## 2. Business Objectives

1. **Centralize marketing data** from TikTok Ads, Meta Ads, and Orders  
2. **Create a unified data model** with documented KPIs and definitions  
3. **Identify top-performing platforms, campaigns, adsets, creatives**  
4. **Enable budget optimization** through ROAS, CAC, CTR, CVR insights  
5. **Provide executive dashboards** that are intuitive and actionable  
6. **Build an analytics foundation** using SQL + Python + Power BI  
7. **Apply simple predictive modeling** to estimate conversions  
8. **Demonstrate BI, SQL, and analytical skills** for portfolio purposes  

---

## 3. Scope

### In Scope
- Building a **mini data warehouse** using SQLite
- Defining staging and dimensional models
- Creating a **fact table** with the following grain:  
  **Date × Platform × Campaign × Adset × Creative × Country**
- Computing marketing KPIs
- Python-based EDA + creative scoring + predictive model
- Power BI dashboards (Executive, Campaigns, Creatives)
- Documentation, BRD, README for GitHub portfolio

### Out of Scope
- Real API integrations
- Real-time streaming pipelines
- Multi-touch attribution modeling
- Country-specific tax or logistics modeling

---

## 4. Functional Requirements

### 4.1 Data Ingestion
The system must:
- Import TikTok Ads CSVs
- Import Meta Ads CSVs
- Import order data from the e-commerce system
- Validate column structures
- Detect anomalies (clicks > impressions, negative spend, etc.)

### 4.2 Data Transformation
The system must:
- Normalize column names across sources
- Map campaigns, adsets, creatives to dimensional tables
- Generate surrogate keys
- Aggregate metrics at daily grain
- Derive KPIs (CTR, CVR, CPC, CPM, CAC, ROAS)

### 4.3 Data Warehouse Design

#### Dimensions:
- **dim_platform**
- **dim_country**
- **dim_campaign**
- **dim_adset**
- **dim_creative**

#### Fact Table:
- `fact_marketing_performance`  
- Metrics:
  - impressions  
  - clicks  
  - spend  
  - conversions  
  - revenue  
  - new_customers  

#### Fact Grain:
> **1 row per day × platform × campaign × adset × creative × country**

---

## 5. Reporting Requirements

### 5.1 Executive Dashboard
- Total Spend
- Total Revenue
- ROAS
- CAC
- Spend vs Revenue trend
- ROAS by platform
- Revenue by country

### 5.2 Acquisition & Campaign Performance
- KPI table by campaign
- ROAS by platform & country (heatmap)
- Spend vs revenue scatter plot

### 5.3 Creative Intelligence
- Creative leaderboard
- CTR vs ROAS scatter
- Creative funnel
- Classification of creatives into:
  - High Performer
  - Good
  - Low CTR (fix hook)
  - Poor Performer

### 5.4 Budget Simulator (Optional)
- Parameter-based budget increase
- Predicted revenue impact

### 5.5 Data Quality Dashboard
- Invalid records (clicks > impressions)
- Zero spend / zero revenue entries
- Missing keys or unmapped campaigns

---

## 6. Non-Functional Requirements

- Dashboard page load < 5 seconds
- Data volume: small (demo-scale)
- System reproducible using Python + SQLite
- Clear documentation and traceability
- Easy deployment in Power BI Desktop

---

## 7. Success Criteria

- One unified marketing fact table
- Complete star schema documented
- Accurate KPI calculations validated
- Three Power BI dashboards built
- Predictive model implemented (R² > 0.5 acceptable for POC)
- Clean, professional GitHub repository

---

## 8. Deliverables

- `marketing_dw.db` (SQLite data warehouse)
- `marketing_analytics.ipynb` (notebook for analytics + model)
- Power BI dashboards (PBIX)
- `README.md` (root)
- `BRD_marketing_analytics.md` (this file)
- `dashboard_design.md` (PBIX specification)
