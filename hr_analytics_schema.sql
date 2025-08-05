-- Create a synthetic HR database to store employee-related data
CREATE DATABASE hr_synthetic;

-- Switch to the newly created database
USE hr_synthetic;

-- ============================
-- Attrition Table
-- ============================
-- Stores information about employees who have exited the organization
CREATE TABLE attrition (
    employee_id INT PRIMARY KEY,                    -- Unique identifier for the employee
    exit_date DATE,                                 -- Date of employee's exit
    reason VARCHAR(50),                             -- Reason for leaving (e.g., resignation, fired)
    voluntary_exit BOOLEAN,                         -- TRUE if the exit was voluntary, FALSE otherwise
    satisfaction_rating INT CHECK (satisfaction_rating BETWEEN 1 AND 5) -- Exit satisfaction rating (1–5 scale)
);

-- ============================
-- Departments Table
-- ============================
-- Contains department-level metadata
CREATE TABLE departments (
    department_id INT PRIMARY KEY,                  -- Unique identifier for the department
    department_name VARCHAR(50)                     -- Name of the department (e.g., HR, Finance)
);

-- ============================
-- Job Roles Table
-- ============================
-- Defines job roles and their associated departments
CREATE TABLE job_roles (
    job_role_id INT PRIMARY KEY,                    -- Unique identifier for the job role
    job_role_name VARCHAR(100),                     -- Name/title of the job role
    department_id INT,                              -- Foreign key linking to the department
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ============================
-- Employees Table
-- ============================
-- Central table containing employee demographic and employment details
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,                    -- Unique identifier for the employee
    name VARCHAR(100),                              -- Full name of the employee
    age INT,                                        -- Age of the employee
    gender VARCHAR(20),                             -- Gender identity
    marital_status VARCHAR(30),                     -- Marital status (e.g., Single, Married)
    ethnicity VARCHAR(50),                          -- Ethnic background
    country VARCHAR(50),                            -- Country of residence or work
    job_role_id INT,                                -- Foreign key linking to job role
    department_id INT,                              -- Foreign key linking to department
    hire_date DATE,                                 -- Date of hiring
    salary DECIMAL(10,2),                           -- Current salary of the employee
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (job_role_id) REFERENCES job_roles(job_role_id)
);

-- ============================
-- Hiring Sources Table
-- ============================
-- Tracks how employees were hired and who referred them
CREATE TABLE hiring_sources (
    employee_id INT PRIMARY KEY,                    -- Unique identifier for the employee
    hiring_source VARCHAR(30),                      -- Source of hiring (e.g., Referral, Social Media)
    referred_by VARCHAR(100),                       -- Name of the person who referred the employee (if any)
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ============================
-- Performance Reviews Table
-- ============================
-- Stores periodic performance evaluations for employees
CREATE TABLE performance_reviews (
    employee_id INT,                                -- Employee being reviewed
    review_date DATE,                               -- Date of the performance review
    performance_score INT CHECK (performance_score BETWEEN 1 AND 5), -- Performance score (1–5 scale)
    bonus_eligible BOOLEAN,                         -- TRUE if eligible for bonus, FALSE otherwise
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ============================
-- Promotions Table
-- ============================
-- Records employee promotions and new job roles
CREATE TABLE promotions (
    employee_id INT,                                -- Employee who was promoted
    promotion_date DATE,                            -- Date of promotion
    new_job_role_id INT,                            -- New job role assigned after promotion
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (new_job_role_id) REFERENCES job_roles(job_role_id)
);

-- ============================
-- Salaries Table
-- ============================
-- Tracks salary changes over time for each employee
CREATE TABLE salaries (
    employee_id INT,                                -- Employee whose salary is recorded
    effective_date DATE,                            -- Date when the salary became effective
    salary_amount DECIMAL(10,2),                    -- Salary amount on the effective date
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);