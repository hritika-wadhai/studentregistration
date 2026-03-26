
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'students_admission')
BEGIN
    ALTER DATABASE students_admission SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE students_admission;
    PRINT 'Old database dropped successfully!';
END
ELSE
BEGIN
    PRINT 'No existing database found. Creating fresh...';
END
GO

CREATE DATABASE students_admission;

USE students_admission;

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) CHECK (role IN('Admin','Clerk','Teacher')) NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    age INT,
    blood_group VARCHAR(10),
    gender VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    address TEXT,
    religion VARCHAR(50),
    caste VARCHAR(50),
    mother_tongue VARCHAR(50),
    aadhar VARCHAR(12) UNIQUE,
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10),
    applying_class VARCHAR(20),
    previous_school VARCHAR(255),
    father_name VARCHAR(100) NOT NULL,
    father_occupation VARCHAR(100),
    mother_name VARCHAR(100) NOT NULL,
    mother_occupation VARCHAR(100),
    father_contact VARCHAR(15) NOT NULL,
    mother_contact VARCHAR(15) NOT NULL,
    emergency_contact VARCHAR(15),
    
    documents_json VARCHAR(MAX),
    
    admission_date DATE DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending','Approved','Rejected')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Exams_appeared (
    exam_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_name VARCHAR(255) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Student_Exams (
    student_exam_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id), 
    FOREIGN KEY (exam_id) REFERENCES Exams_appeared(exam_id),
    created_at DATETIME DEFAULT GETDATE()
);


INSERT INTO Exams_appeared (exam_name) VALUES
('School Annual Examination'),
('Unit/Terminal Examination'),
('Scholarship Examination'),
('Olympiad Examination'),
('Entrance / Aptitude Test'),
('Navodaya / Sainik School Exam'),
('Other');

SS
USE students_admission;

SELECT *FROM Students

DROP TABLE Students;SSS

DROP TABLE Student_Exams;
DROP TABLE Students;

CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    age INT,
    blood_group VARCHAR(10),
    gender VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    address TEXT,
    religion VARCHAR(50),
    caste VARCHAR(50),
    mother_tongue VARCHAR(50),
    aadhar VARCHAR(12) UNIQUE,
    state VARCHAR(50),
    city VARCHAR(50),
    pincode VARCHAR(10),
    applying_class VARCHAR(20),
    previous_school VARCHAR(255),
    father_name VARCHAR(100) NOT NULL,
    father_occupation VARCHAR(100),
    mother_name VARCHAR(100) NOT NULL,
    mother_occupation VARCHAR(100),
    father_contact VARCHAR(15) NOT NULL,
    mother_contact VARCHAR(15) NOT NULL,
    emergency_contact VARCHAR(15),

    admission_date DATE DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'Pending' 
        CHECK (status IN ('Pending','Approved','Rejected')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE Exams_appeared (
    exam_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_name VARCHAR(255) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Student_Exams (
    student_exam_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id), 
    FOREIGN KEY (exam_id) REFERENCES Exams_appeared(exam_id),
    created_at DATETIME DEFAULT GETDATE()
);


INSERT INTO Exams_appeared (exam_name) VALUES
('School Annual Examination'),
('Unit/Terminal Examination'),
('Scholarship Examination'),
('Olympiad Examination'),
('Entrance / Aptitude Test'),
('Navodaya / Sainik School Exam'),
('Other');

SELECT * FROM Exams_appeared;





