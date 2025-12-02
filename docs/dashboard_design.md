# 📊 Power BI Dashboard Design – Marketing Analytics POC

This document describes the structure, visuals, and fields for the three Power BI dashboards used in this POC.

---

## 1. Global Filters (Apply to All Pages)
Add as slicers:
- Date (fact_marketing_performance[Date])
- Platform (dim_platform[platform_name])
- Country (dim_country[country_name])
- Campaign (dim_campaign[campaign_name])
- Creative (dim_creative[creative_name])

---

# PAGE 1 – Executive Overview

## 🎯 Purpose
Provide leadership with a 5-second view of overall marketing health.

## 🧩 Visual Components

### 1. KPI Cards
- **Total Spend** → `[Total Spend]`
- **Total Revenue** → `[Total Revenue]`
- **ROAS** → `[ROAS]`
- **CAC** → `[CAC]`

### 2. Combo Chart – Spend vs Revenue
- X-axis: `Date`
- Column: `[Total Spend]`
- Line: `[Total Revenue]`

### 3. Column Chart – ROAS by Platform
- Axis: `dim_platform[platform_name]`
- Value: `[ROAS]`

### 4. Column Chart – Revenue by Country
- Axis: `dim_country[country_name]`
- Value: `[Total Revenue]`

### 5. Smart Narrative (Optional)
Automatically generates insights.

---

# PAGE 2 – Acquisition & Campaign Performance

## 🎯 Purpose
Analyze campaign efficiency and identify budget reallocation opportunities.

## 🧩 Visual Components

### 1. KPI Table (campaign-level)
Columns:
- platform_name
- campaign_name
- Total Spend
- Total Impressions
- Total Clicks
- CTR
- Total Conversions
- CVR
- Total Revenue
- ROAS
- Total New Customers
- CAC

### 2. Matrix – ROAS Heatmap
- Rows: platform_name
- Columns: country_name
- Values: `[ROAS]`
- Conditional formatting: green → red

### 3. Scatter – Spend vs Revenue
- X: `[Total Spend]`
- Y: `[Total Revenue]`
- Legend: platform_name
- Details: campaign_name
- Size: `[Total Conversions]`

---

# PAGE 3 – Creative Intelligence

## 🎯 Purpose
Rank creatives and analyze engagement vs profitability.

## 🧩 Visual Components

### 1. Creative Leaderboard Table
Columns:
- creative_name
- platform_name
- Total Impressions
- Total Clicks
- CTR
- Total Conversions
- CVR
- Total Spend
- Total Revenue
- ROAS
- CAC
- Creative Status

### 2. Scatter – CTR vs ROAS
- X-axis: `[CTR]`
- Y-axis: `[ROAS]`
- Details: creative_name
- Legend: platform_name
- Size: `[Total Spend]`

### 3. Funnel – Impressions → Clicks → Conversions
Ideal for creative-level drilldowns.

---

# PAGE 4 – Data Quality Dashboard (Optional but Strong)

## 🎯 Purpose
Show governance maturity and validate KPI reliability.

### Visuals:
- KPI Cards:
  - Invalid Clicks > Impressions
  - Zero Revenue Records
  - Zero Conversion Records
- Table of anomalies
- Data lineage diagram image

---

# PAGE 5 – Budget Simulator (Optional)

### Setup:
- Create a What-If Parameter “BudgetIncreasePct”

### Visuals:
- Slider: BudgetIncreasePct
- Line chart:
  - Actual Revenue
  - Adjusted Revenue
- Card: Incremental Revenue

---

## 💡 Final Dashboard Notes
- Use a clean, modern theme  
- Keep KPI cards consistent  
- Use drillthrough for campaign → adset → creative  
- Add bookmarks if needed  
