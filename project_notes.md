# Healthcare Analytics Project Notes

## Overview
This document tracks the progression, milestones, and ongoing tasks for the Healthcare Analytics Project. The goal is to build an end-to-end analytics pipeline that transforms raw hospital data into actionable business insights using Python, Power BI, and an AI Analytics Assistant.

---

## Phase 1: Data Understanding & Cleaning (Completed)
- **Data Inspection:** Reviewed raw tabular data to understand schemas without making assumptions about column names.
- **Data Cleaning (`python/01_data_cleaning.ipynb`):**
  - Converted string representations of dates into proper datetime structures.
  - Imputed missing or invalid numerical outliers.
  - Standardized categorical data and populated missing text fields.
  - Deduplicated datasets to ensure data integrity.
- **Output:** Cleaned datasets generated and stored in `data/cleaned/`.

## Phase 2: Exploratory Data Analysis (Completed)
- **Business EDA (`python/02_eda.ipynb`):**
  - Mapped out **Appointment Trends** to analyze monthly demand and cancellation/no-show statuses.
  - Evaluated **Department Performance** discovering Pediatrics and Dermatology drive the highest volume and revenue.
  - Analyzed **Billing & Revenue Trends**, correlating steady monthly income with appointment volumes.
- **Quality Assurance:** Both Jupyter Notebooks executed successfully.

## Phase 3: PostgreSQL Implementation (Completed)
- **Database Validated:** Successfully authenticated to `healthcare_analytics` locally, avoiding the restricted `enrichment_testPostgre` database.
- **Schema & Architecture (`sql/01_create_tables.sql`):** Created 5 relational tables (`patients`, `doctors`, `appointments`, `treatments`, `billing`) with proper primary/foreign key constraints and extensions for derived Python columns.
- **Data Loading (`sql/02_insert_data.sql`):** Leveraged PostgreSQL `\copy` for rapid client-side bulk insertion of local CSVs. Validation confirmed 100% row match.
- **Business Queries (`sql/03_analysis_queries.sql`):** Wrote advanced SQL answering core business questions and complex interview-style questions (e.g. Window Functions for payment methods).
- **Views (`sql/04_views.sql`):** Generated modular views (`monthly_revenue`, `department_performance`, `doctor_workload`) to serve as the direct backend for Power BI.

---

## What is being done right now
- The Database architecture phase is fully complete and validated.
- We are ready to move towards visualization and LLM integration.

## Next Steps
1. Power BI integration: Hook up to the newly created PostgreSQL views to develop an interactive dashboard.
2. Build out the AI Analytics Assistant / FastAPI components relying on the new database.
