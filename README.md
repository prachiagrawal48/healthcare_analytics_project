# Healthcare Analytics Project

## Database Setup & Architecture
This project utilizes a local PostgreSQL database (`healthcare_analytics`) to manage and analyze healthcare operations data.

### Schema Details
- **`patients`**: Stores patient demographics and insurance data. (52 rows)
- **`doctors`**: Stores doctor details and specializations. (12 rows)
- **`appointments`**: Stores appointment schedules and statuses. Links to `patients` and `doctors`. (202 rows)
- **`treatments`**: Stores treatment details and costs. Links to `appointments`. (202 rows)
- **`billing`**: Stores billing transactions. Links to `patients` and `treatments`. (202 rows)

### Execution Instructions
The SQL scripts can be run locally via `psql`. Ensure your database is named `healthcare_analytics` and your password is set.
1. **Schema Creation**: `psql -U postgres -d healthcare_analytics -f sql/01_create_tables.sql`
2. **Data Loading**: `psql -U postgres -d healthcare_analytics -f sql/02_insert_data.sql` (Note: requires adjusting absolute paths to your local `data/cleaned/` folder).
3. **Analytical Queries**: `psql -U postgres -d healthcare_analytics -f sql/03_analysis_queries.sql`
4. **Views**: `psql -U postgres -d healthcare_analytics -f sql/04_views.sql`

### Important Analytical Queries & Views
- `monthly_revenue`: View for summarizing month-over-month revenue performance.
- `department_performance`: View mapping high-performing departments.
- `doctor_workload`: View for monitoring appointment counts per physician to prevent burnout.
- Included robust interview-style queries identifying peak workloads, revenue drivers, no-show percentages, and high-value patients.
