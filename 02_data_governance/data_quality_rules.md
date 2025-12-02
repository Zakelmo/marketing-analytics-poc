# Data Quality Rules
## Marketing Data Warehouse & BI Analytics Platform

Data quality is essential for ensuring accuracy, trust, and reliability across marketing analytics. These rules define validations applied during ingestion and transformation.

---

# 1. Completeness Rules

### **DQ-01 — Required Fields Must Not Be Null**
| Field | Table |
|--------|--------|
| report_date | staging tables |
| campaign_id | staging tables |
| impressions | staging tables |
| clicks | staging tables |
| spend | staging tables |

**Severity:** High  
**Action:** Flag row, load but warn  

---

# 2. Accuracy Rules

### **DQ-02 — Clicks Cannot Exceed Impressions**
**Logic:** clicks <= impressions  
**Severity:** Critical  
**Fix:** Flag record as anomaly  

SQL check:
```sql
SELECT *
FROM stage_tiktok_ads
WHERE clicks > impressions;
```

### **DQ-03 — Spend Cannot Be Negative**

**Severity:** Critical

SQL:

```sql
SELECT * FROM staging WHERE spend < 0;
```

### **DQ-04 — Conversions Cannot Be Negative**

**Severity:** High

# 3. Consistency Rules

### **DQ-05 — Country Codes Must Match ISO List**

**Allowed:** KSA, KW
**Severity:** Medium

### **DQ-06 — Campaign IDs must match across sources**

Ensures orders join back to ad data.

# 4. Uniqueness Rules

### **DQ-07 — Dimension Surrogate Keys Must Be Unique**

platform_key
campaign_key
adset_key
creative_key
country_key

**Violation impact:** Medium

# 5. Referential Integrity Rules

### **DQ-08 — Fact Table Must Resolve All Foreign Keys**

No NULL foreign keys allowed after DW load.

SQL:
```sql
SELECT *
FROM fact_marketing_performance
WHERE platform_key IS NULL
   OR campaign_key IS NULL
   OR adset_key IS NULL
   OR creative_key IS NULL
   OR country_key IS NULL;
```

**Severity:** High

# 6. Range Checks

### **DQ-09 — Spend Validation**

**Valid range:** 0 → 100,000
**Severity:** Warning

### **DQ-10 — Revenue Validation**

**Revenue** >= 0

# 7. Aggregation Rules
### **DQ-11 — Fact Grain Enforcement**

One row per:
date × platform × campaign × adset × creative × country

SQL:
```sql
SELECT date_key, platform_key, campaign_key, adset_key, creative_key, country_key, COUNT(*)
FROM fact_marketing_performance
GROUP BY 1,2,3,4,5,6
HAVING COUNT(*) > 1;
```

**Severity:** Critical

# 8. Summary Table

| Rule ID | Category     | Severity | Description                    |
| ------- | ------------ | -------- | ------------------------------ |
| DQ-01   | Completeness | High     | Required fields cannot be null |
| DQ-02   | Accuracy     | Critical | clicks > impressions           |
| DQ-03   | Accuracy     | Critical | spend < 0                      |
| DQ-04   | Accuracy     | High     | conversions < 0                |
| DQ-05   | Consistency  | Medium   | country code validation        |
| DQ-06   | Consistency  | High     | order ad mapping               |
| DQ-07   | Uniqueness   | Medium   | dimension surrogate keys       |
| DQ-08   | Referential  | High     | unresolved foreign keys        |
| DQ-09   | Range        | Warning  | spend out of bounds            |
| DQ-10   | Range        | Medium   | revenue < 0                    |
| DQ-11   | Grain        | Critical | duplicate fact rows            |

