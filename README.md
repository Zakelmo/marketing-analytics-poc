# 📊 Marketing Analytics POC – TikTok & Meta Ads Performance Platform

This repository contains an end-to-end **Marketing Performance Analytics** proof of concept.

## 🚀 What’s Included

- `marketing_dw.db` – SQLite data warehouse with:
  - Staging tables (TikTok, Meta, Orders)
  - Dimension tables (platform, country, campaign, adset, creative)
  - Fact table: `fact_marketing_performance`
- `tiktok_ads_raw.csv` – sample TikTok ads export
- `meta_ads_raw.csv` – sample Meta ads export
- `orders_raw.csv` – sample orders data
- `marketing_analytics.ipynb` – Python notebook for:
  - Loading the DW
  - Computing KPIs (CTR, CVR, ROAS, CAC, etc.)
  - EDA and visualizations
  - A simple predictive model for conversions

## 🔧 Tech Stack

- Python (pandas, seaborn, scikit-learn, SQLAlchemy)
- SQLite
- Power BI (for dashboards, not included as a file here)
- Git / GitHub

## ▶️ How to Use

1. Clone or download this repository.
2. Open `marketing_analytics.ipynb` in Jupyter / VS Code.
3. Make sure Python can access `marketing_dw.db` in the same folder.
4. Run the notebook cells to reproduce the analysis.

You can also connect **Power BI** to `marketing_dw.db` and build dashboards using the star schema and DAX measures described in the documentation or in your notes.
