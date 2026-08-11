# PROJECT STATUS

## Dataset Selection & Source
- **Dataset Selected:** Healthcare Patient Journey & Operations Dataset
- **Source Status:** Downloaded, cleaned, and structured inside `data/raw/` and `data/cleaned/`

## Features & Implementation Status
- ✅ **ETL Pipeline (Python/Pandas):** Raw data parsed, missing values handled, and new features (like Age Groups, Time Slots) generated. Data is successfully loaded into `data/cleaned/`.
- ✅ **Database (PostgreSQL):** Local database `healthcare_analytics` created. SQL scripts (`01_create_tables.sql`, `02_insert_data.sql`, `03_analysis_queries.sql`, `04_views.sql`) designed and executed successfully.
- ✅ **Power BI Dashboard:** A highly professional, 3-page interactive dashboard has been fully built and saved in `powerbi/`. It includes:
  - Page 1: Executive Overview (Appointments, Revenue trends)
  - Page 2: Operations & Doctors Performance (Workload, Waiting Time analysis)
  - Page 3: Revenue & Patient Experience Analytics (Treatment revenue, Satisfaction scatter plots)

