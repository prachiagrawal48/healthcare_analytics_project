-- sql/03_analysis_queries.sql

-- =========================================================
-- CORE BUSINESS QUERIES
-- =========================================================

-- 1. Which department has the highest number of appointments?
SELECT 
    d.specialization AS department, 
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.specialization
ORDER BY total_appointments DESC;

-- 2. Which doctor has the highest workload?
SELECT 
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, doctor_name, d.specialization
ORDER BY total_appointments DESC
LIMIT 5;

-- 3. What is the monthly revenue?
SELECT 
    TO_CHAR(bill_date, 'YYYY-MM') AS billing_month,
    SUM(amount) AS total_revenue
FROM billing
GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
ORDER BY billing_month;

-- 4. Which department generates the highest revenue?
SELECT 
    d.specialization AS department,
    SUM(b.amount) AS total_revenue
FROM billing b
JOIN treatments t ON b.treatment_id = t.treatment_id
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_revenue DESC;

-- =========================================================
-- INTERVIEW-STYLE ANALYTICAL QUERIES
-- =========================================================

-- Interview Query 1: Appointment Status Distribution
-- (Find the percentage of appointments that were completed, no-shows, or cancelled)
SELECT 
    status,
    COUNT(appointment_id) AS count,
    ROUND((COUNT(appointment_id) * 100.0) / SUM(COUNT(appointment_id)) OVER (), 2) AS percentage
FROM appointments
GROUP BY status;

-- Interview Query 2: High Value Patients 
-- (Identify patients who had more than 2 treatments and calculate their total billed amount)
SELECT 
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    COUNT(t.treatment_id) AS number_of_treatments,
    SUM(b.amount) AS total_billed
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
JOIN treatments t ON b.treatment_id = t.treatment_id
GROUP BY p.patient_id, patient_name
HAVING COUNT(t.treatment_id) > 2
ORDER BY total_billed DESC;

-- Interview Query 3: Payment Preferences by Department
-- (Find the most common payment method for each department using Window Functions)
WITH DepartmentPayments AS (
    SELECT 
        d.specialization AS department,
        b.payment_method,
        COUNT(b.bill_id) as payment_count,
        RANK() OVER(PARTITION BY d.specialization ORDER BY COUNT(b.bill_id) DESC) as rank
    FROM billing b
    JOIN treatments t ON b.treatment_id = t.treatment_id
    JOIN appointments a ON t.appointment_id = a.appointment_id
    JOIN doctors d ON a.doctor_id = d.doctor_id
    GROUP BY d.specialization, b.payment_method
)
SELECT department, payment_method, payment_count
FROM DepartmentPayments
WHERE rank = 1;

-- Interview Query 4: Cumulative Revenue by Month (Running Total)
-- (Calculate the running total of revenue across the months using Window Functions)
WITH MonthlyRev AS (
    SELECT 
        TO_CHAR(bill_date, 'YYYY-MM') AS billing_month,
        SUM(amount) AS monthly_revenue
    FROM billing
    GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
)
SELECT 
    billing_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY billing_month) AS cumulative_revenue
FROM MonthlyRev
ORDER BY billing_month;

-- Interview Query 5: Patient Loyalty / Repeat Visits
-- (Find patients who have visited the exact same doctor 2 or more times)
SELECT 
    p.first_name || ' ' || p.last_name AS patient_name,
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS visits_to_this_doctor
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY p.patient_id, p.first_name, p.last_name, d.doctor_id, d.first_name, d.last_name, d.specialization
HAVING COUNT(a.appointment_id) >= 2
ORDER BY visits_to_this_doctor DESC;

-- Interview Query 6: Time to First Appointment
-- (Calculate the average number of days between a patient's registration and their first appointment)
WITH FirstAppointments AS (
    SELECT 
        patient_id,
        MIN(appointment_date) AS first_appointment_date
    FROM appointments
    GROUP BY patient_id
)
SELECT 
    ROUND(AVG(fa.first_appointment_date - p.registration_date), 1) AS avg_days_to_first_appointment
FROM patients p
JOIN FirstAppointments fa ON p.patient_id = fa.patient_id
WHERE fa.first_appointment_date >= p.registration_date;
