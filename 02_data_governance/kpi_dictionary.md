# KPI Dictionary
## Marketing Data Warehouse & BI Analytics Platform

This document defines all KPIs used in dashboards, Python analytics, and reporting. The goal is to ensure consistent use across the organization.

---

# 1. Acquisition & Engagement Metrics

### **1.1 Impressions**
**Definition:** Number of times an ad was displayed.  
**Source:** TikTok/Meta  
**Formula:** SUM(impressions)  
**Grain:** Fact record level  
**Owner:** Marketing Analytics  

---

### **1.2 Clicks**
**Definition:** Total clicks received by ads.  
**Formula:** SUM(clicks)  
**Owner:** Marketing Analytics  

---

### **1.3 CTR (Click-Through Rate)**
**Definition:** Share of impressions resulting in a click.  
**Formula:** clicks / impressions  
**Type:** Ratio  
**Owner:** Performance Team  

---

### **1.4 CPC (Cost per Click)**
**Definition:** Average cost per click.  
**Formula:** spend / clicks  
**Owner:** Finance + Marketing  

---

### **1.5 CPM (Cost per Mille)**
**Definition:** Cost per 1000 impressions.  
**Formula:** spend / (impressions / 1000)  

---

# 2. Conversion & Revenue Metrics

### **2.1 Conversions**
**Definition:** Number of triggered purchases or desired actions.  
**Formula:** SUM(conversions)  

---

### **2.2 CVR (Conversion Rate)**
**Definition:** Click-to-conversion ratio.  
**Formula:** conversions / clicks  

---

### **2.3 Revenue**
**Definition:** Revenue attributed to the ad platform.  
**Formula:** SUM(revenue)  

---

### **2.4 AOV (Average Order Value)**
**Definition:** Revenue per conversion.  
**Formula:** revenue / conversions  

---

# 3. Profitability Metrics

### **3.1 ROAS (Return on Ad Spend)**
**Definition:** Revenue generated per 1 currency unit spent.  
**Formula:** revenue / spend  
**Interpretation:**  
- > 3 excellent  
- 2 to 3 good  
- < 1 unprofitable  

---

### **3.2 CAC (Customer Acquisition Cost)**
**Definition:** Cost to acquire one new customer.  
**Formula:** spend / new_customers  
**Owner:** Marketing + Finance  

---

# 4. Customer Metrics

### **4.1 New Customers**
**Definition:** Count of distinct customers with `is_new_customer = 1`  
**Formula:** SUM(new_customers)  

---

### **4.2 Returning Customers**
(Not implemented, but extendable)

---

# 5. Funnel Metrics

### **5.1 Funnel Stages**
- Impressions  
- Clicks  
- Conversions  

### **5.2 Dropoff Rates**
Defined as:
- Impression → Click dropoff = 1 - CTR  
- Click → Conversion dropoff = 1 - CVR  

---

# 6. Creative Classification Rules

| Creative Type | Rule |
|---------------|------|
| High Performer | ROAS > 3 and CTR > 3% |
| Good | ROAS > 2 |
| Low CTR | CTR < 1% |
| Poor Performer | ROAS < 1 |
