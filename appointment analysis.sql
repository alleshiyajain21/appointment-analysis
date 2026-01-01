CREATE DATABASE hospital_analysis;
USE hospital_analysis;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(30)
);

INSERT INTO patients VALUES
(1, 'Riya Sharma', 'Female', 28, 'Delhi'),
(2, 'Aman Verma', 'Male', 35, 'Mumbai'),
(3, 'Neha Singh', 'Female', 42, 'Pune'),
(4, 'Rohit Patel', 'Male', 50, 'Ahmedabad'),
(5, 'Sneha Iyer', 'Female', 31, 'Chennai');

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(40),
    consultation_fee INT
);

INSERT INTO doctors VALUES
(101, 'Dr. Mehta', 'Cardiologist', 800),
(102, 'Dr. Rao', 'Dermatologist', 600),
(103, 'Dr. Khan', 'Orthopedic', 700),
(104, 'Dr. Das', 'General Physician', 500);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO appointments VALUES
(1001, 1, 104, '2024-12-01', 'Completed'),
(1002, 2, 101, '2024-12-02', 'Completed'),
(1003, 3, 102, '2024-12-03', 'Cancelled'),
(1004, 4, 103, '2024-12-04', 'Completed'),
(1005, 5, 104, '2024-12-05', 'Completed'),
(1006, 1, 102, '2024-12-06', 'Completed');


SELECT * FROM patients;

SELECT specialization, COUNT(*) AS total_doctors
FROM doctors
GROUP BY specialization;

SELECT 
    p.patient_name,
    d.doctor_name,
    d.specialization,
    a.appointment_date,
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT 
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;

SELECT *
FROM appointments
WHERE status = 'Completed';

SELECT patient_name, age, city
FROM patients
WHERE age > 40;

SELECT 
    d.doctor_name,
    SUM(d.consultation_fee) AS total_revenue
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_name;

SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city;

SELECT 
    d.doctor_name,
    SUM(d.consultation_fee) AS revenue
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_name
ORDER BY revenue DESC
LIMIT 1;
