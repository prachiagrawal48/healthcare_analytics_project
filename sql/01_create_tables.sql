-- sql/01_create_tables.sql
-- Drop tables if they exist in reverse dependency order
DROP TABLE IF EXISTS billing CASCADE;
DROP TABLE IF EXISTS treatments CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS patients CASCADE;

-- Create Patients Table
CREATE TABLE patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(20),
    date_of_birth DATE,
    contact_number VARCHAR(20),
    address TEXT,
    registration_date DATE,
    insurance_provider VARCHAR(100),
    insurance_number VARCHAR(100),
    email VARCHAR(150),
    age INTEGER,
    age_group VARCHAR(20)
);

-- Create Doctors Table
CREATE TABLE doctors (
    doctor_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(20),
    years_experience INTEGER,
    hospital_branch VARCHAR(100),
    email VARCHAR(150)
);

-- Create Appointments Table
CREATE TABLE appointments (
    appointment_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) REFERENCES patients(patient_id),
    doctor_id VARCHAR(50) REFERENCES doctors(doctor_id),
    appointment_date DATE NOT NULL,
    appointment_time TIME,
    reason_for_visit VARCHAR(255),
    status VARCHAR(50),
    appointment_day_of_week VARCHAR(20),
    appointment_month VARCHAR(20),
    appointment_year INTEGER
);

-- Create Treatments Table
CREATE TABLE treatments (
    treatment_id VARCHAR(50) PRIMARY KEY,
    appointment_id VARCHAR(50) REFERENCES appointments(appointment_id),
    treatment_type VARCHAR(100),
    description TEXT,
    cost NUMERIC(10, 2),
    treatment_date DATE
);

-- Create Billing Table
CREATE TABLE billing (
    bill_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) REFERENCES patients(patient_id),
    treatment_id VARCHAR(50) REFERENCES treatments(treatment_id),
    bill_date DATE,
    amount NUMERIC(10, 2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50)
);
