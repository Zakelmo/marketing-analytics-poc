# Final Presentation Slides – Outline
## Marketing Data Warehouse & BI Analytics Platform

Below is a structured, ready-to-copy outline for a 10–12 slide business presentation.  
This can be used in interviews, portfolio reviews, or project demos.

---

# SLIDE 1 — Title Slide
**Marketing Data Warehouse & BI Analytics Platform**  
End-to-End BI & Data Engineering POC  
*Zakaria El Morabit*  
Business Analyst / Data Analyst  

---

# SLIDE 2 — Business Problem
- Marketing data scattered across TikTok Ads, Meta Ads, and e-commerce orders  
- Manual Excel reporting causing inconsistencies  
- No unified KPI definitions (ROAS, CAC, etc.)  
- Difficulty identifying winning campaigns & creatives  
- Limited visibility for leadership decision-making  

---

# SLIDE 3 — Project Objectives
**Primary Goals**
- Centralize all paid media data into a governed warehouse  
- Standardize KPIs across channels  
- Enable campaign and creative performance insights  
- Provide self-service dashboards for leadership  
- Support basic machine learning analysis  

---

# SLIDE 4 — Architecture Overview

Diagram (text placeholder):

CSV Exports → Staging Layer → Data Warehouse (Star Schema)
→ Python Analytics → Power BI Dashboards


Layers:
- Staging  
- Dimensions  
- Fact table  
- Analytics  
- Dashboards  

---

# SLIDE 5 — Data Model (Star Schema)

Include ERD diagram (erd_marketing_dw.png)

Fact grain:
**date × platform × campaign × adset × creative × country**

Dimensions:
- platform  
- campaign  
- adset  
- creative  
- country  

---

# SLIDE 6 — Data Governance

- Data Catalog (all fields documented)  
- KPI Dictionary (CTR, CVR, ROAS, CAC…)  
- Data Quality Rules (clicks > impressions, nulls, negative spend…)  
- Ensures “single source of truth” across the company  

---

# SLIDE 7 — ETL Pipeline

**Pipeline Steps**
1. Load raw data into staging  
2. Normalize and clean  
3. Build dimensions  
4. Aggregate fact table  
5. Compute KPIs  

**Technologies:**  
SQLite, SQL, Python, Pandas, SQLAlchemy

---

# SLIDE 8 — Python Analytics

Highlights:
- Automated KPI computation  
- EDA visualizations  
- Creative performance scatter (CTR vs ROAS)  
- Campaign performance comparisons  
- Predictive model (RandomForest) for conversions  
- Feature importance insights  

---

# SLIDE 9 — Power BI Dashboards

**Pages**
1. Executive Overview  
2. Campaign Performance  
3. Creative Intelligence  
4. Data Quality Monitor  
5. Budget Simulator  

**Key visuals**
- ROAS trend line  
- Spend vs revenue  
- Creative leaderboard  
- Heatmaps (ROAS by platform × country)  
- Slicers (date, platform, campaign, creative)  

---

# SLIDE 10 — Insights Generated

Examples:
- Top campaigns driving the highest ROAS  
- Creatives with highest CTR & best revenue  
- Platforms with best acquisition cost  
- Countries with strongest output  
- Data inconsistencies detected & resolved  

---

# SLIDE 11 — Impact & Value

**Business Value**
- 80% reduction in manual reporting  
- Faster decision-making  
- Unified KPI definitions  
- Better budget allocation  
- Identification of winning creatives  

**Technical Value**
- Reusable data warehouse  
- Extensible data model  
- Reproducible pipeline  
- Strong data governance foundation  

---

# SLIDE 12 — Next Steps

- Add Google Ads, Snapchat Ads  
- Implement dim_date for advanced time intelligence  
- API ingestion for real-time data  
- Cohort analysis & LTV modeling  
- Advanced attribution (multi-touch, ML-based)  

---

# SLIDE 13 — Thank You
Q&A  
