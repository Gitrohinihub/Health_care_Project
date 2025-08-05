🏥 Health Care Data Analysis (20M+ Records)

📌 Project Overview

This project presents a large-scale clinical data analysis using **Microsoft SQL Server** and **Power BI**. With over **20 million rows**, the dataset captures detailed healthcare metrics, such as infections, admissions, readmissions, and deaths across **multiple hospitals over seven years (2024–2030)**.

The analysis reveals trends and anomalies across time and hospital units, providing meaningful insights for hospital operations and patient care strategies.

---

🧠 Problem Statement

Hospitals generate high volumes of clinical data that often remain underutilised. This project aims to:

- Identify patterns in patient infections, readmissions, and mortality.
- Compare hospitals based on outcome metrics.
- Assist in data-backed hospital decision-making using SQL & dashboards.

---

🗂️ Dataset Details

- **Source**: Simulated (self-created 20M+ rows)
- **Database**: Microsoft SQL Server
- **File/Table Name**: `Health_Dataset`
- **Range**: Years 2024–2030, 10 hospitals

🔑 Columns

| Column Name       | Description                          |
|-------------------|--------------------------------------|
| `AdmissionDate`   | Date of patient admission            |
| `HospitalID`      | Unique identifier for each hospital  |
| `Infections`      | Total infections recorded            |
| `Readmissions`    | Total readmissions                   |
| `TotalAdmissions` | Total admissions                     |
| `TotalDeaths`     | Total deaths                         |

---

🧰 Tools Used

| Tool                | Purpose                            |
|---------------------|------------------------------------|
| **SQL Server**      | Data creation, profiling, queries  |
| **Power BI**        | Dashboard building & reporting     |
| **Excel/CSV**       | Reference and staging              |

---

🧮 SQL Work Performed

- Created 20M+ rows of clinical data programmatically
- Performed column distribution, mode, median, and profiling
- Used `WHILE` loops and `dynamic SQL` for automated analysis
- Implemented `aggregations`, `ranking`, and `distribution analysis`
- Created hospital-wise and yearly summary tables
- Prepared data for Power BI consumption
- Connected SQL Server directly to Power BI for reporting

---

📊 Dashboards & Visual Insights (Power BI)

🏥 Page 1 – Hospital-wise Metrics

- Line charts for:
  - Infections in Hospital
  - Readmissions by Hospital
  - Admissions by Hospital
  - Deaths by Hospital
![image link](https://github.com/Gitrohinihub/Health_care_Project/blob/5eea10f84e1f600d2cbbbacde5f2bdf797eab38e/Health%20Data%20Analysis%20Report%20page%201st.png)
 
📅 Page 2 – Year-wise Metrics

- Line charts for:
  - Infections by Year
  - Readmissions by Year
  - Admissions by Year
  - Deaths by Year
📷 Visuals saved in `screenshots/` : https://github.com/Gitrohinihub/Health_care_Project/blob/main/Analysis%20by%20Year%20Report%20page%202nd.png

---

📈 Key Insights

- 📉 Infections dropped significantly in 2026
- 🏥 Hospitals 6 & 8 show elevated mortality trends
- 🔁 Readmissions peaked in 2028, possibly indicating post-surgery follow-ups or complications
- 📊 Stable admissions over the years show consistent intake

🤝 Connect With Me :

💼 LinkedIn: https://www.linkedin.com/in/rohini-singh-8a97a1229 

📧 email: miss.rohini09coder@gmail.com






