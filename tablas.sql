-- POSTGRESQL
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE dental_histories (
    id SERIAL PRIMARY KEY,
    patient_id INT UNIQUE NOT NULL,
    anamnesis TEXT,
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients (id)
);

CREATE TABLE dentists (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100)
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    date_time TIMESTAMP NOT NULL,
    reason TEXT,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

CREATE TABLE teeth (
    id SERIAL PRIMARY KEY,
    tooth_number VARCHAR(10) NOT NULL,
    description TEXT
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost NUMERIC(10,2)
);

CREATE TABLE treatment_plans (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50),
    CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

CREATE TABLE procedures (
    id SERIAL PRIMARY KEY,
    plan_id INT NOT NULL,
    treatment_id INT NOT NULL,
    tooth_id INT,
    procedure_date DATE NOT NULL,
    observations TEXT,
    CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id),
    CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES teeth (id)
);

CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    stock INT
);

CREATE TABLE treatment_materials (
    treatment_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (treatment_id, material_id),
    CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES materials (id)
);

CREATE TABLE dental_labs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    plan_id INT NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT NOW(),
    amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50),
    CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id)
);


-- MYSQL
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE dental_histories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT UNIQUE NOT NULL,
    anamnesis TEXT,
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients (id)
);

CREATE TABLE dentists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100)
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    date_time TIMESTAMP NOT NULL,
    reason TEXT,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

CREATE TABLE teeth (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tooth_number VARCHAR(10) NOT NULL,
    description TEXT
);

CREATE TABLE treatments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2)
);

CREATE TABLE treatment_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50),
    CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

CREATE TABLE procedures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    treatment_id INT NOT NULL,
    tooth_id INT,
    procedure_date DATE NOT NULL,
    observations TEXT,
    CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id),
    CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES teeth (id)
);

CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    stock INT
);

CREATE TABLE treatment_materials (
    treatment_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (treatment_id, material_id),
    CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES materials (id)
);

CREATE TABLE dental_labs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id)
);
