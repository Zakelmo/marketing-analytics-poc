# 📊 Marketing Analytics Platform – TikTok & Meta Ads (POC)

A complete end-to-end **Marketing Analytics Platform** designed for GCC e-commerce ad campaigns, built as a portfolio project by **Zakaria El Morabit** (Business Analyst & Data Analyst).

This POC demonstrates expertise in:
- Data Engineering (staging → warehouse)
- Data Modeling (star schema)
- BI & Dashboarding (Power BI)
- Python EDA + machine learning
- KPI governance & marketing analytics

---

# 🚀 Project Overview

Digital advertising teams often struggle with:
- Fragmented data across TikTok and Meta
- Manual reporting
- Inconsistent KPIs
- No visibility on creative efficiency
- Difficulty optimizing budget

This POC solves these challenges by building:
- A **mini data warehouse** (SQLite)
- A **Python analytics layer**
- **Power BI dashboards**
- A fully reproducible GitHub project

---

# 🏗️ Architecture

CSV Exports → Staging Tables → Data Warehouse → Python EDA → Power BI Dashboards


### Data Warehouse (Star Schema)
- **Fact Table:** fact_marketing_performance  
- **Dimensions:**
  - dim_platform  
  - dim_campaign  
  - dim_adset  
  - dim_creative  
  - dim_country  

### Fact Grain
> **1 row per day × platform × campaign × adset × creative × country**

This granularity allows multi-layer breakdowns and creative-level ROI.

---

# 🔍 Capabilities Demonstrated

## ✔ Data Engineering
- Building staging tables
- ETL into dimensional model
- Designing fact & dimension tables
- Creating surrogate keys

## ✔ Data Analysis (Python)
- KPI calculations (CTR, CVR, ROAS, CAC…)
- Exploratory data analysis (EDA)
- Creative performance ranking
- Predictive model for conversions (RandomForest)

## ✔ BI & Dashboarding (Power BI)
Dashboards include:
1. **Executive Overview**
2. **Campaign & Acquisition Performance**
3. **Creative Intelligence**
4. **Data Quality**
5. **Budget Simulator (optional)**

## ✔ Governance
- KPI Dictionary
- Data Quality Rules
- Documentation & BRD
- Dashboard design specifications

---

# 📁 Project Files

- `/data/marketing_dw.db` – Data warehouse  
- `/data/tiktok_ads_raw.csv`, `/data/meta_ads_raw.csv`, `/data/orders_raw.csv` – Sample data  
- `/notebooks/marketing_analytics.ipynb` – Python analytics  
- `/docs/BRD_marketing_analytics.md` – Business Requirements  
- `/docs/dashboard_design.md` – PBIX design  
- `.gitignore`  
- This README  

---

# ▶️ Running the Project

### 1. Clone the repo
```bash
git clone https://github.com/zakelmo/marketing-analytics-poc.git
