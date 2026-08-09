-- sql/02_insert_data.sql
-- Note: This uses PostgreSQL \copy command which executes client-side via psql.
-- These absolute paths must exactly match the local Windows environment.
-- The data comes from the cleaned datasets produced in Phase 1.

\copy patients FROM 'C:\Users\DELL\OneDrive\Documents\Projects\healthcare_analytics_project\data\cleaned\patients_clean.csv' WITH CSV HEADER;
\copy doctors FROM 'C:\Users\DELL\OneDrive\Documents\Projects\healthcare_analytics_project\data\cleaned\doctors_clean.csv' WITH CSV HEADER;
\copy appointments FROM 'C:\Users\DELL\OneDrive\Documents\Projects\healthcare_analytics_project\data\cleaned\appointments_clean.csv' WITH CSV HEADER;
\copy treatments FROM 'C:\Users\DELL\OneDrive\Documents\Projects\healthcare_analytics_project\data\cleaned\treatments_clean.csv' WITH CSV HEADER;
\copy billing FROM 'C:\Users\DELL\OneDrive\Documents\Projects\healthcare_analytics_project\data\cleaned\billing_clean.csv' WITH CSV HEADER;
