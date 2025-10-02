-- ORACLE
-- Tabla patients
CREATE TABLE patients (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    birth_date DATE,
    phone VARCHAR2(20),
    address CLOB
);

-- Tabla dental_histories
CREATE TABLE dental_histories (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id NUMBER UNIQUE NOT NULL,
    anamnesis CLOB,
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients (id)
);

-- Tabla dentists
CREATE TABLE dentists (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    specialty VARCHAR2(100)
);

-- Tabla appointments
CREATE TABLE appointments (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id NUMBER NOT NULL,
    dentist_id NUMBER NOT NULL,
    date_time TIMESTAMP NOT NULL,
    reason CLOB,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

-- Tabla teeth
CREATE TABLE teeth (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tooth_number VARCHAR2(10) NOT NULL,
    description CLOB
);

-- Tabla treatments
CREATE TABLE treatments (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description CLOB,
    cost NUMBER(10,2)
);

-- Tabla treatment_plans
CREATE TABLE treatment_plans (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id NUMBER NOT NULL,
    dentist_id NUMBER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR2(50),
    CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

-- Tabla procedures
CREATE TABLE procedures (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plan_id NUMBER NOT NULL,
    treatment_id NUMBER NOT NULL,
    tooth_id NUMBER,
    procedure_date DATE NOT NULL,
    observations CLOB,
    CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id),
    CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES teeth (id)
);

-- Tabla materials
CREATE TABLE materials (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description CLOB,
    stock NUMBER
);

-- Tabla treatment_materials
CREATE TABLE treatment_materials (
    treatment_id NUMBER NOT NULL,
    material_id NUMBER NOT NULL,
    quantity NUMBER(10,2) NOT NULL,
    PRIMARY KEY (treatment_id, material_id),
    CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES materials (id)
);

-- Tabla dental_labs
CREATE TABLE dental_labs (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    address CLOB
);

-- Tabla payments
CREATE TABLE payments (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plan_id NUMBER NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    payment_method VARCHAR2(50),
    CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id)
);


-- SQL-SERVER
-- Tabla patients
CREATE TABLE patients (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    birth_date DATE,
    phone NVARCHAR(20),
    address NVARCHAR(MAX)
);

-- Tabla dental_histories
CREATE TABLE dental_histories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT UNIQUE NOT NULL,
    anamnesis NVARCHAR(MAX),
    CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients (id)
);

-- Tabla dentists
CREATE TABLE dentists (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    specialty NVARCHAR(100)
);

-- Tabla appointments
CREATE TABLE appointments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    date_time DATETIME2 NOT NULL,
    reason NVARCHAR(MAX),
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

-- Tabla teeth
CREATE TABLE teeth (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tooth_number NVARCHAR(10) NOT NULL,
    description NVARCHAR(MAX)
);

-- Tabla treatments
CREATE TABLE treatments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    cost DECIMAL(10,2)
);

-- Tabla treatment_plans
CREATE TABLE treatment_plans (
    id INT IDENTITY(1,1) PRIMARY KEY,
    patient_id INT NOT NULL,
    dentist_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status NVARCHAR(50),
    CONSTRAINT fk_plan_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_plan_dentist FOREIGN KEY (dentist_id) REFERENCES dentists (id)
);

-- Tabla procedures
CREATE TABLE procedures (
    id INT IDENTITY(1,1) PRIMARY KEY,
    plan_id INT NOT NULL,
    treatment_id INT NOT NULL,
    tooth_id INT,
    procedure_date DATE NOT NULL,
    observations NVARCHAR(MAX),
    CONSTRAINT fk_procedure_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id),
    CONSTRAINT fk_procedure_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_procedure_tooth FOREIGN KEY (tooth_id) REFERENCES teeth (id)
);

-- Tabla materials
CREATE TABLE materials (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    stock INT
);

-- Tabla treatment_materials
CREATE TABLE treatment_materials (
    treatment_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (treatment_id, material_id),
    CONSTRAINT fk_tm_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    CONSTRAINT fk_tm_material FOREIGN KEY (material_id) REFERENCES materials (id)
);

-- Tabla dental_labs
CREATE TABLE dental_labs (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    address NVARCHAR(MAX)
);

-- Tabla payments
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    plan_id INT NOT NULL,
    payment_date DATETIME2 NOT NULL DEFAULT GETDATE(),
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(50),
    CONSTRAINT fk_payment_plan FOREIGN KEY (plan_id) REFERENCES treatment_plans (id)
);
