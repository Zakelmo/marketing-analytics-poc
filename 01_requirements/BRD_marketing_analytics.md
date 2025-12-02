# Business Requirements Document (BRD)
## Marketing Data Warehouse & BI Analytics Platform

---

# 1. Executive Summary

The Marketing Data Warehouse & BI Analytics Platform is designed to centralize advertising, revenue, and customer acquisition data across multiple paid media channels (TikTok Ads, Meta Ads, and e-commerce orders). The objective is to create a unified, governed, and analytics-ready ecosystem enabling actionable insights, performance monitoring, optimization, and decision support for marketing and leadership teams.

The platform supports the full analytics lifecycle:
- Data ingestion and consolidation  
- Data modeling and enrichment  
- KPI governance and data quality  
- Exploratory and advanced analytics (Python)  
- Self-service dashboards (Power BI)  

This BRD defines the high-level business needs, scope, success criteria, and key functional/non-functional requirements.

---

# 2. Business Objectives

### 2.1 Primary Objectives
1. Build a centralized **Marketing Data Warehouse (MDW)** to standardize all marketing and acquisition data.  
2. Provide reliable and consistent **KPI governance** across teams.  
3. Enable **campaign, adset, and creative performance analytics**.  
4. Provide leadership with **executive dashboards** for ROAS, CAC, spend, and revenue monitoring.  
5. Support **data-driven budget allocation** and performance optimization.  
6. Improve operational efficiency by eliminating manual reporting tasks.

### 2.2 Secondary Objectives
- Implement a scalable architecture for future API integrations.
- Provide support for predictive modeling (conversions, CAC, ROAS).
- Enable creative intelligence and A/B testing insights.

---

# 3. Project Scope

### 3.1 In Scope
- Ingesting raw data from TikTok, Meta, and Orders CSVs.
- Creating a staging layer for schema alignment.
- Designing and building a star-schema data warehouse.
- Developing analytical KPIs and metrics.
- Creating Python-based analytics (EDA + ML).
- Developing Power BI dashboards for:
  - Executive overview  
  - Campaign performance  
  - Creative intelligence  
  - Data quality  
- Documenting governance (KPI dictionary, data catalog, DQ rules).
- Providing slide-ready content for business presentations.

### 3.2 Out of Scope
- Real-time pipelines  
- API-based ingestion  
- Advanced attribution modeling (beyond last-touch)  
- Integration with CRM or inventory systems  
- Predictive LTV or churn modeling  

---

# 4. Stakeholders

| Stakeholder Role | Responsibilities |
|------------------|------------------|
| Head of Marketing | Decision-making, performance review, budget allocation |
| Performance Marketing Manager | Campaign optimization, creative strategy |
| Data Analyst / BI Analyst | Dashboard development, KPI analysis |
| Data Engineer | Data ingestion, modeling, quality |
| Business Analyst | Requirements, documentation, validation |
| Senior Leadership / CEO | Executive insights, strategic decisions |

---

# 5. Business Requirements

### 5.1 Core Requirements

#### BR-01: Centralized Data Repository  
The system shall consolidate data from TikTok Ads, Meta Ads, and Orders into a single data warehouse.

#### BR-02: Standardized KPIs  
The system shall calculate and standardize marketing KPIs including CTR, CPC, CPM, CVR, ROAS, CAC.

#### BR-03: Campaign-Level Performance Analysis  
The system shall provide visibility into campaign performance across platforms and countries.

#### BR-04: Creative Intelligence  
The system shall allow the evaluation of creative assets through metrics such as CTR, CVR, ROAS, and spend.

#### BR-05: Data Quality Validation  
The system shall detect anomalies such as:
- clicks > impressions  
- zero spend  
- missing campaign mappings  
- negative revenue  

#### BR-06: Executive Dashboards  
The solution shall provide visual dashboards for:
- Spend vs Revenue  
- ROAS trends  
- CAC trends  
- Revenue distribution by country  
- Cross-platform comparisons  

#### BR-07: Predictive Modeling Support  
The analytics layer shall support basic machine learning models (conversion prediction, ROAS drivers).

---

# 6. Functional Requirements (High-Level)

| ID | Requirement |
|----|-------------|
| FR-01 | Load CSV files into staging tables |
| FR-02 | Normalize platform schema differences |
| FR-03 | Create surrogate keys for dimensions |
| FR-04 | Aggregate fact table at daily granularity |
| FR-05 | Join data to dimensions and compute KPIs |
| FR-06 | Refresh DW on demand |
| FR-07 | Provide drill-down capabilities in dashboards |
| FR-08 | Enable filters by date, country, platform, campaign, creative |

---

# 7. Non-Functional Requirements (NFRs)

### 7.1 Performance
- Dashboard interaction should load in **< 5 seconds**.
- Notebook computations must run on commodity hardware.

### 7.2 Scalability
- DW should be extendable to support new platforms.
- Future compatibility with API ingestion.

### 7.3 Maintainability
- Clear documentation for each data entity.
- SQL pipelines must be modular and readable.

### 7.4 Security
- Sensitive customer-level data anonymized.
- Ad data secured in local environment.

---

# 8. Success Criteria

| Metric | Goal |
|--------|------|
| KPI accuracy | 100% alignment with manual calculations |
| Data freshness | Updated within minutes of CSV ingestion |
| Dashboard usability | Stakeholders can self-navigate without training |
| Insight quality | Identification of top 5 performing creatives/campaigns |
| Reduction in manual reporting | > 80% |

---

# 9. Deliverables

- Data warehouse (SQLite DB)
- Python notebook (EDA, KPIs, ML)
- Power BI dashboards
- Full documentation package:
  - BRD  
  - Functional Specification  
  - Data Catalog  
  - KPI Dictionary  
  - ERD  
  - SQL Pipeline Scripts  
  - Presentation Slides  

---

# 10. Assumptions & Dependencies

- CSV files follow expected structure.
- Users have Power BI Desktop installed.
- Python environment available for notebook execution.
- No real-time data required.

---

# 11. Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| Inconsistent CSV formats | High | Validation rules + staging normalization |
| Missing campaign IDs | Medium | Data quality checks |
| Incorrect KPI calculations | High | KPI dictionary + BI QA |
| Lack of Power BI skills | Low | Documentation + template |

---

# 12. Approval

**Document Owner:**  
Zakaria El Morabit — Business Analyst / Data Analyst  

**Approved By:**  
Marketing & Data Leadership (Simulated)  
