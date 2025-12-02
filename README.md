# 📊 Marketing Analytics Platform – TikTok & Meta Ads (POC)

A complete end-to-end **Marketing Analytics Platform**, designed for real-world GCC e-commerce advertising workflows.  
This project demonstrates how to integrate **TikTok Ads**, **Meta Ads**, and **Order data** into a fully governed analytics pipeline powered by:

- Python (EDA & modeling)  
- SQLite (data warehouse)  
- Power BI (dashboards & business insights)

Built by **Zakaria El Morabit** — Business Analyst / Data Analyst.

---

# 🚀 Project Overview

Digital advertisers often struggle with:
- Fragmented data (TikTok, Meta, Orders)
- No single source of truth
- Manual Excel reporting
- Poor insight into campaign or creative performance
- Limited ability to optimize ROAS and CAC

This POC solves these challenges with a clean analytical foundation.

---

# 🏗️ Architecture

CSV Exports
↓
Staging Layer (SQLite)
↓
Data Warehouse (Star Schema)
↓
Python Analytics (KPIs, EDA, ML)
↓
Power BI Dashboards


---

# 🔧 Layers (Detailed Breakdown)

## 1. **Data Sources**
Raw exports used in this POC:
- `/data/tiktok_ads_raw.csv`
- `/data/meta_ads_raw.csv`
- `/data/orders_raw.csv`

Each contains real-world marketing metrics such as:
- impressions  
- clicks  
- spend  
- conversions  
- revenue  
- creative metadata  
- customer-level order data  

---

## 2. **Staging Layer (SQLite)**

The staging schema includes:
- `stage_tiktok_ads`
- `stage_meta_ads`
- `stage_orders`

Purpose:
- Standardize disparate file formats  
- Perform anomaly checks  
- Clean column names  
- Validate data types  

---

## 3. **Data Warehouse (Star Schema)**

A dimensional model was built using the following tables:

### **Dimensions**
- `dim_platform`
- `dim_country`
- `dim_campaign`
- `dim_adset`
- `dim_creative`

### **Fact Table**
`fact_marketing_performance`

### **Fact Grain**
> **1 row per day × platform × campaign × adset × creative × country**

This enables deep drilldown across:
- channel  
- campaign  
- adset  
- creative  
- geography  
- date  

---

## 4. **Analytics Layer (Python)**

Python notebook: `/notebooks/marketing_analytics.ipynb`

Includes:
- Connecting to SQLite DW
- Merging dims + fact
- KPI derivation:
  - CTR, CVR, CPC, CPM
  - ROAS, CAC, AOV
- EDA visualizations:
  - Top creatives
  - Spend vs Revenue trends
  - CTR vs ROAS scatter
- A simple ML model:
  - Predict conversions using RandomForestRegressor
- Creative scoring logic

---

## 5. **Power BI Dashboards**

Three dashboards built (spec described in `/docs/dashboard_design.md`):

### **Executive Overview**
- Spend / Revenue / ROAS / CAC
- Revenue vs Spend trend
- Revenue by Country
- ROAS by Platform

### **Acquisition & Campaign Performance**
- KPI table by campaign
- Heatmap: ROAS (Platform × Country)
- Scatter: Spend vs Revenue

### **Creative Intelligence**
- Creative leaderboard
- CTR vs ROAS scatter
- Creative funnel
- Creative classification (High Performer, Low CTR, etc.)

---

# ⚙️ Technologies Used

- **Python**: pandas, seaborn, scikit-learn, SQLAlchemy  
- **SQLite**: portable data warehouse  
- **Power BI**: dashboards, DAX, data modeling  
- **Git & GitHub**: documentation + reproducibility  

---

# 📁 Project Structure

```text
/marketing-analytics-poc
│
├── data/
│   ├── marketing_dw.db                # SQLite data warehouse
│   ├── tiktok_ads_raw.csv
│   ├── meta_ads_raw.csv
│   └── orders_raw.csv
│
├── docs/
│   ├── BRD_marketing_analytics.md # Business Requirements Document
│   └── dashboard_design.md        # Power BI design specification
│
├── notebooks/
│   └── marketing_analytics.ipynb      # Python analytics + KPIs + ML
│
└── README.md

📐 Fact Table Grain

The fact table is aggregated at:

Date × Platform × Campaign × Adset × Creative × Country

This allows:

ROI analysis per creative

Cross-country comparisons

Daily revenue vs spend trends

Funnel conversion tracking

Creative-level CTR vs ROAS

Audience/adset optimization

This is exactly how real marketing warehouses operate.

📊 Key KPIs (DAX & Python)
CTR

Clicks / Impressions

CVR

Conversions / Clicks

CPC

Spend / Clicks

CPM

Spend / (Impressions / 1000)

ROAS

Revenue / Spend

CAC

Spend / New Customers

AOV

Revenue / Conversions

All KPIs exist in:

Python (notebook)

Power BI (DAX file)

🧠 Insights You Can Generate

Using dashboard filters (date, platform, country, campaign, creative) you can answer:

✔ Which platform performs best?

TikTok higher CTR

Meta higher CVR

✔ Which campaigns are overspending?

Scatter: Spend vs Revenue

✔ Which creatives drive best ROAS?

Creative Leaderboard

CTR vs ROAS cluster

✔ Which countries perform best?

ROAS heatmap

Revenue by Country chart

✔ Is budget allocated efficiently?

Executive ROAS

Budget Simulator (optional)

📈 Dashboard Pages (Power BI)

Executive Overview

Campaign Performance

Creative Intelligence

Data Quality (optional)

Budget Simulator (optional)

Each page is fully specified in /docs/dashboard_design.md.

▶️ How to Run
1. Use Python Notebook

Open marketing_analytics.ipynb

Run KPI & EDA sections

Train the predictive model

2. Use Power BI

Connect to marketing_dw.db

Build dashboards following /docs/dashboard_design.md

👤 Author

Zakaria El Morabit
Business Analyst • Data Analyst • E-commerce Expert