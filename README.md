# Telco_Customer_Churn
Telco customer churn analysis using Python, SQL, Excel and Power BI to find why customers leave and how to retain them.

# Telco Customer Churn Analysis

End-to-end churn analysis of a telecom customer base using **Python, SQL, Excel and Power BI**: from data cleaning to a 5-page interactive dashboard with business insights and retention recommendations.

> **Business question:** Which customers are churning, why, and where should the retention team focus first?

---

## Headline Results

| Metric | Value |
|---|---|
| Total customers | **7,043** |
| Churned customers | **1,869** |
| Overall churn rate | **26.54%** |
| Monthly revenue lost to churn | **~30.5%** of total monthly revenue |
| Highest-risk segment* | **70.8%** churn (754 customers) |

\*Month-to-month contract, tenure ≤ 12 months, monthly charges > 70, no tech support.

---

## Dataset

- **Source:** Telco Customer Churn dataset (IBM sample data, Kaggle)
- **Size:** 7,043 customers × 21 columns, no duplicates
- **Target:** `Churn` (Yes / No)
- **Feature groups:**
  - Demographics: gender, senior citizen, partner, dependents
  - Services: phone, multiple lines, internet, online security, backup, device protection, tech support, streaming
  - Account: tenure, contract, paperless billing, payment method
  - Charges: monthly charges, total charges

## Tools

| Stage | Tools |
|---|---|
| Data cleaning | Python (Pandas, NumPy), Jupyter |
| Analysis & segmentation | SQL (MySQL): CASE, GROUP BY, subqueries, CTEs, window functions, views |
| Quick exploration | Excel |
| Dashboard & storytelling | Power BI |

## Approach

1. **Data cleaning (Python):** found 11 blank `TotalCharges` values (all customers with tenure = 0, i.e. brand-new), converted the column to numeric and filled them with 0. Checked duplicates, missing values and whitespace issues.
2. **SQL analysis:** churn rate by contract, tenure group, internet service, charge band, payment method, tech support, senior citizen, partner/dependents, plus combined segments (contract × payment, contract × internet).
3. **Feature grouping:**
   - Tenure: New (≤ 12 months), Medium-term (13–36), Long-term (> 36)
   - Monthly charges: Low (≤ 35), Medium (35–70), High (> 70)
4. **Risk segmentation & revenue impact:** built a high-risk customer segment and calculated the share of monthly revenue lost to churn.
5. **Power BI dashboard:** 5 pages with slicers for contract, tenure, internet service and payment method.
6. **Insights & recommendations.**

## Key Findings

**Contract & tenure (strongest drivers)**
- Month-to-month customers churn at **42.71%**, vs **11.27%** (one year) and **2.83%** (two year). They account for **1,655 of the 1,869** churned customers.
- New customers (≤ 12 months) churn at **47.44%**, dropping to 25.54% (medium) and 11.93% (long-term).

**Service & pricing**
- Fiber optic users churn at **41.89%**, vs 18.96% for DSL and 7.40% for customers with no internet.
- Churn rises with price: **10.89%** (low) → 23.94% (medium) → **35.36%** (high charges). Churned customers pay more on average (about 74 vs 61 per month).
- Customers without **online security** (41.77%) or **tech support** (41.64%) churn about 3x more than those with them (14.61% and 15.17%). Device protection and online backup show the same pattern.

**Payment & billing**
- Electronic check users churn at **45.29%**, vs 15–19% for the other methods.
- Paperless billing customers churn at 33.57% vs 16.33%.

**Customer profile**
- Senior citizens churn at **41.68%** vs 23.61% for non-seniors.
- Customers with no partner and no dependents churn at 34.24%, vs 14.24% for those with both.
- Gender makes almost no difference (26.92% vs 26.16%).

## Recommended Actions

1. Move month-to-month customers to yearly contracts with discounts and loyalty benefits.
2. Offer retention deals to high-charge customers.
3. Investigate service quality and satisfaction among fiber optic users.
4. Promote online security and tech support bundles.
5. Review the payment experience for electronic check users and push auto-pay.
6. Provide personalised support for senior citizens.
7. Prioritise the high-risk segment (month-to-month, new, high charges, no tech support) for proactive outreach.

## Repository Structure

```
Telco_Customer_Churn/
├── churnproject.ipynb                 # Data cleaning in Python
├── Telco-Customer-Churn.csv           # Raw dataset
├── Telco_Customer_Churn_db_.sql       # SQL analysis (MySQL)
├── telco_customer_churn.xlsx          # Excel analysis
├── Telco_Customer_Churn.pbix          # Power BI dashboard
└── README.md
```

## How to Run

1. Clone the repo: `git clone https://github.com/Nasarhussainsk/Telco_Customer_Churn.git`
2. **Python:** `pip install pandas numpy jupyter`, then open `churnproject.ipynb`
3. **SQL:** load the CSV into a `telco_customers` table in MySQL and run `Telco_Customer_Churn_db_.sql`
4. **Dashboard:** open `Telco_Customer_Churn.pbix` in Power BI Desktop

## Author

**Nasar Hussain S K**: Aspiring Data Analyst | Python · SQL · Power BI · Excel . Statistics
[GitHub](https://github.com/Nasarhussainsk).
