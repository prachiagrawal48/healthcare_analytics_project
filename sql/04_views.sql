-- sql/04_views.sql
-- Create reusable analytical views for dashboarding

-- 1. Monthly Revenue View
CREATE OR REPLACE VIEW monthly_revenue AS
SELECT 
    DATE_TRUNC('month', bill_date)::DATE AS billing_month,
    SUM(amount) AS total_revenue,
    COUNT(bill_id) AS total_bills,
    SUM(CASE WHEN payment_status = 'Paid' THEN amount ELSE 0 END) AS collected_revenue
FROM billing
GROUP BY DATE_TRUNC('month', bill_date)
ORDER BY billing_month;

-- 2. Department Performance View
CREATE OR REPLACE VIEW department_performance AS
SELECT 
    d.specialization AS department,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT t.treatment_id) AS total_treatments,
    SUM(b.amount) AS total_revenue
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
LEFT JOIN billing b ON t.treatment_id = b.treatment_id
GROUP BY d.specialization;

-- 3. Doctor Workload View
CREATE OR REPLACE VIEW doctor_workload AS
SELECT 
    d.doctor_id,
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT CASE WHEN a.status = 'Completed' THEN a.appointment_id END) AS completed_appointments,
    COUNT(DISTINCT CASE WHEN a.status IN ('Cancelled', 'No-Show') THEN a.appointment_id END) AS missed_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, doctor_name, d.specialization;

-- 4. Patient Lifetime Value View
-- (Tracks total revenue generated per patient, visit count, and retention timeline)
CREATE OR REPLACE VIEW patient_lifetime_value AS
SELECT 
    p.patient_id,
    p.first_name || ' ' || p.last_name AS patient_name,
    p.age_group,
    COUNT(DISTINCT a.appointment_id) AS total_visits,
    MIN(a.appointment_date) AS first_visit_date,
    MAX(a.appointment_date) AS last_visit_date,
    COALESCE(SUM(b.amount), 0) AS lifetime_revenue
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
LEFT JOIN billing b ON t.treatment_id = b.treatment_id
GROUP BY p.patient_id, patient_name, p.age_group;

-- 5. Daily Operations Summary View
-- (Aggregates daily appointment volumes and revenues for operational monitoring)
CREATE OR REPLACE VIEW daily_operations_summary AS
SELECT 
    a.appointment_date AS operation_date,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT CASE WHEN a.status = 'Completed' THEN a.appointment_id END) AS completed_appointments,
    COUNT(DISTINCT CASE WHEN a.status = 'No-show' THEN a.appointment_id END) AS no_shows,
    COALESCE(SUM(b.amount), 0) AS daily_revenue
FROM appointments a
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
LEFT JOIN billing b ON t.treatment_id = b.treatment_id
GROUP BY a.appointment_date;

-- 6. High Risk Patients View
-- (Identifies patients who have a high cancellation or no-show rate - >= 50% missed rate and > 1 total appointment)
CREATE OR REPLACE VIEW high_risk_patients AS
WITH PatientStats AS (
    SELECT 
        p.patient_id,
        p.first_name || ' ' || p.last_name AS patient_name,
        p.contact_number,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(CASE WHEN a.status IN ('Cancelled', 'No-show') THEN 1 ELSE 0 END) AS missed_appointments
    FROM patients p
    JOIN appointments a ON p.patient_id = a.patient_id
    GROUP BY p.patient_id, patient_name, p.contact_number
)
SELECT 
    patient_id,
    patient_name,
    contact_number,
    total_appointments,
    missed_appointments,
    ROUND((missed_appointments * 100.0) / total_appointments, 2) AS missed_rate_percentage
FROM PatientStats
WHERE total_appointments > 1 AND (missed_appointments * 1.0 / total_appointments) >= 0.5;
