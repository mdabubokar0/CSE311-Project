SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Drop existing tables if they exist (for re-running the script)
DROP TABLE IF EXISTS admin_details, doctor_details, patient_details, department;

-- 1. Create admin table
CREATE TABLE admin_details(
    admin_id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(80) NOT NULL,
    password VARCHAR(150) NOT NULL,
    role VARCHAR(10) NOT NULL,
    PRIMARY KEY(admin_id)
);

-- Insert into admin_details
INSERT INTO admin_details (name, email, password, role)
VALUES
('Md Abu Bokar', 'abu@gmail.com', 'testpass1', 'admin'),
('Natsha Monir Shawon', 'nat@gmail.com', 'testpass2', 'admin');

-- 2. Create department table
CREATE TABLE department(
    dept_id INT AUTO_INCREMENT NOT NULL,
    dept_name VARCHAR(55) NOT NULL,
    PRIMARY KEY(dept_id)
);

-- Insert into department
INSERT INTO department (dept_name)
VALUES
('Opthalmology'),
('Cardiology');

-- 3. Create doctor table
CREATE TABLE doctor_details(
    doctor_id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    phone_no VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(150),
    password VARCHAR(150) NOT NULL,
    gender VARCHAR(10),
    speciality VARCHAR(55) NOT NULL,
    dept_id INT NOT NULL,
    role VARCHAR(10) NOT NULL,
    PRIMARY KEY(doctor_id),
    FOREIGN KEY(dept_id) REFERENCES department(dept_id)
);

-- Insert into doctor_details
INSERT INTO doctor_details (name, email, phone_no, address, password, gender, speciality, dept_id, role)
VALUES
('Olivia Williams', 'olivia.williams@example.com', '31234567890', '789 Pine St, Springfield', 'mySecurePass456', 'Female', 'Opthalmologist', 1, 'doctor'),
('Ava Brown', 'ava.brown@example.com', '41234567890', '101 Birch St, Springfield', 'pass@Brown987', 'Female', 'Cardiologist', 2, 'doctor');

-- 4. Create patient table
CREATE TABLE patient_details(
    patient_id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    phone_no VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(150),
    password VARCHAR(150) NOT NULL,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    dob VARCHAR(10),
    height DOUBLE(3,2),
    weight DOUBLE(3,2),
    occupation VARCHAR(50),
    guardian_name VARCHAR(50),
    guardian_phone VARCHAR(15),
    role VARCHAR(10) NOT NULL,
    PRIMARY KEY(patient_id)
);

-- Insert into patient_details
INSERT INTO patient_details 
(name, email, phone_no, address, password, gender, blood_group, dob, height, weight, occupation, guardian_name, guardian_phone, role)
VALUES
('Emily Parker', 'emily.parker@example.com', '91234567890', '123 Maple St, Springfield', 'p@ssw0rd123', 'Female', 'O+', '1990-05-12', 1.65, 55.50, 'Teacher', 'John Parker', '12345678901', 'patient'),
('Sophia Johnson', 'sophia.j@example.com', '92345678901', '456 Oak St, Springfield', 'abc123DEF!', 'Female', 'A+', '1985-08-20', 1.70, 60.00, 'Software Engineer', 'Maria Johnson', '12345678902', 'patient'),
('Isabella Davis', 'isabella.davis@example.com', '95678901234', '234 Cedar St, Springfield', 'dav!sSecure890', 'Female', 'O-', '1995-03-07', 1.68, 62.35, 'Architect', 'Laura Davis', '12345678905', 'patient');

COMMIT;