# Marketing Data Warehouse & BI Analytics Platform

A full end-to-end analytics solution combining:
- Data engineering  
- Data modeling  
- Data governance  
- Analytics (Python)  
- Business intelligence (Power BI)  

Built by **Zakaria El Morabit** as a professional-grade portfolio project.

---

# 📁 Project Structure

marketing-analytics-poc/
01_requirements/ → BRD, Functional Specification
02_data_governance/ → Data Catalog, KPI Dictionary, DQ Rules
03_data_model/ → ERD + DDL (SQL schema)
04_sql_pipeline/ → Staging, Dim, Fact load SQL scripts
05_notebooks/ → EDA & ML Jupyter notebook
06_dashboards/ → Power BI dashboard specification
07_docs/ → Final slides + full documentation
marketing_dw.db → SQLite Data Warehouse


---

# 🚀 How to Use

### 1. Run the SQL schema
```bash
sqlite3 marketing_dw.db < 03_data_model/ddl_tables.sql
```

### 2. Load staging data using:

04_sql_pipeline/staging_load.sql

### 3. Populate dimensions:

04_sql_pipeline/dim_load.sql

### 4. Build fact table:

04_sql_pipeline/fact_load.sql

### 5. Run analytics:

Open:
```bash
05_notebooks/marketing_eda_and_model.ipynb
```

### 6. Open Power BI and connect to:
marketing_dw.db


Use visuals described in:
06_dashboards/powerbi_marketing_dashboard_spec.md

🎯 Highlights

Full enterprise-grade BI architecture
Clean star-schema data model
SQL-based ETL pipeline
Strong data governance framework
Professional dashboards spec
Python analytics + predictive modeling
Fully documented end-to-end

👤 Author

Zakaria El Morabit
Business Analyst • Data Analyst • E-commerce Performance Specialist