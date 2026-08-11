# Healthcare Operations & Performance Analytics

![PowerBI Dashboard Preview](powerbi/preview.png) *(Add a screenshot of your dashboard here later)*

## 1. Project Overview
This project is an end-to-end **Data Analytics System** designed for hospital administration and healthcare operations. It seamlessly bridges the gap between raw medical data and actionable business insights. It features a complete ETL pipeline, a fully functioning Data Warehouse in PostgreSQL, and an interactive 3-page Power BI dashboard for executive monitoring.

## 2. Business Problem & Solution
Healthcare organizations generate massive amounts of operational data daily. Executives often struggle to track performance bottlenecks (e.g., high waiting times), evaluate doctor workloads, or analyze revenue streams effectively.

**Solution:** This project provides a robust, centralized data architecture. The raw data is cleaned using Python (Pandas), loaded into a PostgreSQL relational database, and then connected to a **Power BI Dashboard** for high-level, interactive monitoring of appointments, revenues, and patient satisfaction.

## 3. Tech Stack
- **Data Engineering / ETL:** Python (Pandas, Numpy, Jupyter Notebooks)
- **Database Management:** PostgreSQL
- **Business Intelligence & Visualization:** Power BI

## 4. Project Structure
```text
healthcare_analytics_project/
│
├── data/
│   ├── raw/                 # Original uncleaned healthcare datasets
│   └── cleaned/             # Processed datasets ready for SQL insertion
│
├── python/                  # Jupyter notebooks containing ETL and EDA scripts
│   ├── 01_data_cleaning.ipynb
│   └── 02_eda.ipynb
│
├── sql/                     # SQL scripts for database architecture
│   ├── 01_create_tables.sql
│   ├── 02_insert_data.sql
│   ├── 03_analysis_queries.sql
│   └── 04_views.sql
│
└── powerbi/                 # The 3-page interactive .pbix dashboard file
```

## 5. Dashboard Details (Power BI)
The Power BI report contains three highly detailed, interactive pages:
1. **Executive Overview:** Monthly appointment and revenue trends, overall hospital KPIs, and department performance breakdowns.
2. **Operations & Doctors Performance:** Doctor workload distribution, average consultation vs waiting times by department, and time-slot analysis.
3. **Revenue & Patient Experience:** Deep dive into revenue by treatment type and payment mode, paired with patient satisfaction scatter plots.

## 6. Setup Instructions
### Prerequisites
- Python 3.9+
- PostgreSQL Server
- Power BI Desktop

### Steps to Reproduce
1. **Data Cleaning:** Run the Jupyter notebooks in the `python/` directory to process the raw datasets. The output will be saved in `data/cleaned/`.
2. **Database Setup:** 
   - Open pgAdmin or any PostgreSQL client.
   - Run `sql/01_create_tables.sql` to build the schema.
   - Use `sql/02_insert_data.sql` (or Postgres COPY tool) to load the cleaned CSVs.
   - Run `sql/04_views.sql` to create optimized views for reporting.
3. **Visualization:** Open `powerbi/healthcare_analytics.pbix` in Power BI Desktop. Ensure the data source settings are pointed to your local PostgreSQL instance to refresh the data.
