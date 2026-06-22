
--   HR & EMPLOYEE DATA ANALYTICS — SQL PROJECT

CREATE DATABASE IF NOT EXISTS hr_analytics;
USE hr_analytics;

-- Departments Table
CREATE TABLE departments (
    dept_id       INT PRIMARY KEY AUTO_INCREMENT,
    dept_name     VARCHAR(50) NOT NULL,
    location      VARCHAR(50),
    budget        DECIMAL(12,2)
);

-- Employees Table
CREATE TABLE employees (
    emp_id        INT PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    hire_date     DATE NOT NULL,
    job_title     VARCHAR(60),
    dept_id       INT,
    salary        DECIMAL(10,2),
    manager_id    INT,
    status        ENUM('Active', 'Resigned', 'Terminated') DEFAULT 'Active',
    gender        ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Performance Reviews Table
CREATE TABLE performance_reviews (
    review_id     INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT NOT NULL,
    review_year   YEAR NOT NULL,
    rating        TINYINT CHECK (rating BETWEEN 1 AND 5),  -- 1=Poor, 5=Excellent
    reviewer_id   INT,
    comments      TEXT,
    review_date   DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (reviewer_id) REFERENCES employees(emp_id)
);

-- Attendance Table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT NOT NULL,
    work_date     DATE NOT NULL,
    check_in      TIME,
    check_out     TIME,
    status        ENUM('Present', 'Absent', 'Half Day', 'Work From Home') DEFAULT 'Present',
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Salary History Table
CREATE TABLE salary_history (
    history_id    INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT NOT NULL,
    old_salary    DECIMAL(10,2),
    new_salary    DECIMAL(10,2),
    change_date   DATE,
    reason        VARCHAR(100),   -- e.g. 'Annual Hike', 'Promotion', 'Joining'
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Resignations / Attrition Table
CREATE TABLE attrition (
    attrition_id  INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT NOT NULL,
    exit_date     DATE,
    reason        VARCHAR(200),   -- 'Better Opportunity', 'Personal', etc.
    exit_type     ENUM('Voluntary', 'Involuntary'),
    rehire_flag   BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


-- =============================================================
-- SECTION 2: SAMPLE DATA INSERTION (DML)
-- =============================================================

-- Departments
INSERT INTO departments (dept_name, location, budget) VALUES
('Engineering',       'Pune',      5000000.00),
('Human Resources',   'Mumbai',    1500000.00),
('Finance',           'Mumbai',    2000000.00),
('Marketing',         'Delhi',     1800000.00),
('Operations',        'Bangalore', 3000000.00);

-- Employees
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, dept_id, salary, manager_id, status, gender, date_of_birth) VALUES
('Ananya',  'Sharma',   'ananya.sharma@hrco.in',   '9876543210', '2019-03-15', 'Engineering Manager',   1, 95000, NULL,  'Active',     'Female', '1988-07-22'),
('Rohan',   'Mehta',    'rohan.mehta@hrco.in',     '9812345678', '2020-06-01', 'Software Engineer',     1, 62000, 1,     'Active',     'Male',   '1995-11-05'),
('Priya',   'Nair',     'priya.nair@hrco.in',      '9823456789', '2021-01-10', 'Software Engineer',     1, 58000, 1,     'Active',     'Female', '1997-02-14'),
('Karan',   'Joshi',    'karan.joshi@hrco.in',     '9834567890', '2022-08-20', 'Junior Developer',      1, 42000, 1,     'Active',     'Male',   '1999-09-09'),
('Sneha',   'Patel',    'sneha.patel@hrco.in',     '9845678901', '2019-05-12', 'HR Manager',            2, 80000, NULL,  'Active',     'Female', '1987-03-30'),
('Arjun',   'Verma',    'arjun.verma@hrco.in',     '9856789012', '2021-03-22', 'HR Executive',          2, 45000, 5,     'Active',     'Male',   '1996-06-18'),
('Meera',   'Pillai',   'meera.pillai@hrco.in',    '9867890123', '2020-11-01', 'Finance Analyst',       3, 55000, NULL,  'Active',     'Female', '1993-12-01'),
('Vikram',  'Singh',    'vikram.singh@hrco.in',    '9878901234', '2018-07-19', 'Finance Manager',       3, 90000, NULL,  'Active',     'Male',   '1986-04-15'),
('Pooja',   'Desai',    'pooja.desai@hrco.in',     '9889012345', '2022-04-05', 'Marketing Executive',   4, 48000, NULL,  'Active',     'Female', '1998-08-21'),
('Nikhil',  'Rao',      'nikhil.rao@hrco.in',      '9890123456', '2017-09-10', 'Operations Head',       5, 110000,NULL,  'Active',     'Male',   '1982-01-27'),
('Divya',   'Kumar',    'divya.kumar@hrco.in',     '9801234567', '2021-07-15', 'Operations Analyst',    5, 52000, 10,    'Active',     'Female', '1994-10-03'),
('Rahul',   'Gupta',    'rahul.gupta@hrco.in',     '9902345678', '2020-02-28', 'Software Engineer',     1, 64000, 1,     'Resigned',   'Male',   '1995-05-11'),
('Kavya',   'Iyer',     'kavya.iyer@hrco.in',      '9913456789', '2019-12-01', 'Marketing Manager',     4, 75000, NULL,  'Active',     'Female', '1989-07-07'),
('Sanjay',  'Tiwari',   'sanjay.tiwari@hrco.in',   '9924567890', '2023-01-10', 'Junior HR Executive',   2, 35000, 5,     'Active',     'Male',   '2000-03-25'),
('Nidhi',   'Bose',     'nidhi.bose@hrco.in',      '9935678901', '2018-04-22', 'Senior Finance Analyst',3, 72000, 8,     'Terminated', 'Female', '1991-11-19');

-- Performance Reviews
INSERT INTO performance_reviews (emp_id, review_year, rating, reviewer_id, comments, review_date) VALUES
(2,  2023, 4, 1,  'Consistently delivers quality code.',     '2023-12-15'),
(3,  2023, 5, 1,  'Exceptional performer, promoted ready.',  '2023-12-15'),
(4,  2023, 3, 1,  'Meets expectations, needs improvement.', '2023-12-15'),
(6,  2023, 4, 5,  'Good communication and follow-ups.',      '2023-12-20'),
(7,  2023, 4, 8,  'Accurate reporting and timely delivery.', '2023-12-18'),
(11, 2023, 5, 10, 'Outstanding process improvements made.',  '2023-12-22'),
(12, 2022, 3, 1,  'Average performance before exit.',        '2022-12-10'),
(2,  2022, 3, 1,  'Good but room for growth.',              '2022-12-15'),
(3,  2022, 4, 1,  'Strong technical skills demonstrated.',   '2022-12-15'),
(9,  2023, 2, 13, 'Missed several campaign deadlines.',      '2023-12-19');

-- Attendance (sample for January 2024)
INSERT INTO attendance (emp_id, work_date, check_in, check_out, status) VALUES
(2, '2024-01-02', '09:05', '18:10', 'Present'),
(2, '2024-01-03', '09:00', '18:00', 'Present'),
(2, '2024-01-04', NULL,    NULL,    'Absent'),
(2, '2024-01-05', '09:30', '18:00', 'Present'),
(3, '2024-01-02', '08:55', '17:50', 'Present'),
(3, '2024-01-03', '09:10', '18:05', 'Work From Home'),
(3, '2024-01-04', '09:00', '13:00', 'Half Day'),
(3, '2024-01-05', '09:00', '18:00', 'Present'),
(4, '2024-01-02', NULL,    NULL,    'Absent'),
(4, '2024-01-03', '09:40', '18:00', 'Present'),
(6, '2024-01-02', '09:00', '17:30', 'Present'),
(6, '2024-01-03', '09:00', '17:30', 'Work From Home'),
(7, '2024-01-02', '09:00', '17:00', 'Present'),
(7, '2024-01-03', NULL,    NULL,    'Absent');

-- Salary History
INSERT INTO salary_history (emp_id, old_salary, new_salary, change_date, reason) VALUES
(2,  55000, 62000, '2023-04-01', 'Annual Hike'),
(3,  50000, 58000, '2023-04-01', 'Annual Hike'),
(4,  38000, 42000, '2023-04-01', 'Annual Hike'),
(7,  48000, 55000, '2022-10-01', 'Promotion'),
(12, 58000, 64000, '2022-04-01', 'Annual Hike'),
(11, 45000, 52000, '2023-01-01', 'Promotion'),
(15, 65000, 72000, '2023-04-01', 'Annual Hike');

-- Attrition Records
INSERT INTO attrition (emp_id, exit_date, reason, exit_type, rehire_flag) VALUES
(12, '2023-05-31', 'Better Opportunity – joined competitor', 'Voluntary',   TRUE),
(15, '2023-09-15', 'Policy violation',                      'Involuntary',  FALSE);


-- =============================================================
-- SECTION 3: ANALYTICAL SQL QUERIES
-- =============================================================

-- ---------------------------------------------------------------
-- Q1. List all active employees with their department name
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.job_title,
    d.dept_name,
    e.hire_date,
    e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'Active'
ORDER BY d.dept_name, e.first_name;


-- ---------------------------------------------------------------
-- Q2. Total headcount and average salary by department
-- ---------------------------------------------------------------
SELECT
    d.dept_name,
    COUNT(e.emp_id)          AS total_employees,
    ROUND(AVG(e.salary), 2)  AS avg_salary,
    MAX(e.salary)            AS highest_salary,
    MIN(e.salary)            AS lowest_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'Active'
GROUP BY d.dept_name
ORDER BY avg_salary DESC;


-- ---------------------------------------------------------------
-- Q3. Calculate employee tenure (years of service)
-- ---------------------------------------------------------------
SELECT
    emp_id,
    CONCAT(first_name, ' ', last_name)                               AS full_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE())                        AS years_of_service,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 1  THEN 'Less than 1 year'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 3  THEN '1–2 years'
        WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 5  THEN '3–4 years'
        ELSE '5+ years'
    END AS tenure_bucket
FROM employees
WHERE status = 'Active'
ORDER BY years_of_service DESC;


-- ---------------------------------------------------------------
-- Q4. Employees who have never received a performance review
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.job_title,
    d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id NOT IN (
    SELECT DISTINCT emp_id FROM performance_reviews
)
AND e.status = 'Active';


-- ---------------------------------------------------------------
-- Q5. Top performers (rating = 5) in the latest review year
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.dept_name,
    pr.review_year,
    pr.rating,
    pr.comments
FROM performance_reviews pr
JOIN employees e ON pr.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE pr.rating = 5
  AND pr.review_year = (SELECT MAX(review_year) FROM performance_reviews)
ORDER BY d.dept_name;


-- ---------------------------------------------------------------
-- Q6. Attrition rate by department (resigned + terminated)
-- ---------------------------------------------------------------
SELECT
    d.dept_name,
    COUNT(e.emp_id)                                          AS total_ever_hired,
    SUM(CASE WHEN e.status IN ('Resigned','Terminated') THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        100.0 * SUM(CASE WHEN e.status IN ('Resigned','Terminated') THEN 1 ELSE 0 END)
        / COUNT(e.emp_id), 2
    )                                                        AS attrition_rate_pct
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY attrition_rate_pct DESC;


-- ---------------------------------------------------------------
-- Q7. Monthly attendance summary per employee (Jan 2024)
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)              AS employee_name,
    COUNT(a.attendance_id)                               AS total_days_recorded,
    SUM(CASE WHEN a.status = 'Present'         THEN 1 ELSE 0 END) AS days_present,
    SUM(CASE WHEN a.status = 'Absent'          THEN 1 ELSE 0 END) AS days_absent,
    SUM(CASE WHEN a.status = 'Work From Home'  THEN 1 ELSE 0 END) AS days_wfh,
    SUM(CASE WHEN a.status = 'Half Day'        THEN 1 ELSE 0 END) AS half_days,
    ROUND(
        100.0 * SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END)
        / COUNT(a.attendance_id), 1
    )                                                    AS attendance_pct
FROM attendance a
JOIN employees e ON a.emp_id = e.emp_id
WHERE a.work_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY e.emp_id, employee_name
ORDER BY attendance_pct DESC;


-- ---------------------------------------------------------------
-- Q8. Salary hike percentage for each employee (latest change)
-- ---------------------------------------------------------------
SELECT
    sh.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)          AS employee_name,
    sh.old_salary,
    sh.new_salary,
    sh.change_date,
    sh.reason,
    ROUND(100.0 * (sh.new_salary - sh.old_salary) / sh.old_salary, 2) AS hike_pct
FROM salary_history sh
JOIN employees e ON sh.emp_id = e.emp_id
ORDER BY hike_pct DESC;


-- ---------------------------------------------------------------
-- Q9. Manager–Reportee hierarchy (self-join)
-- ---------------------------------------------------------------
SELECT
    CONCAT(mgr.first_name, ' ', mgr.last_name)  AS manager_name,
    mgr.job_title                                AS manager_title,
    CONCAT(emp.first_name, ' ', emp.last_name)  AS reportee_name,
    emp.job_title                                AS reportee_title,
    d.dept_name
FROM employees emp
JOIN employees mgr ON emp.manager_id = mgr.emp_id
JOIN departments d  ON emp.dept_id   = d.dept_id
ORDER BY manager_name, reportee_name;


-- ---------------------------------------------------------------
-- Q10. Gender diversity ratio by department
-- ---------------------------------------------------------------
SELECT
    d.dept_name,
    COUNT(e.emp_id)                                                       AS total_employees,
    SUM(CASE WHEN e.gender = 'Male'   THEN 1 ELSE 0 END)                 AS male_count,
    SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END)                 AS female_count,
    ROUND(100.0 * SUM(CASE WHEN e.gender = 'Female' THEN 1 ELSE 0 END)
          / COUNT(e.emp_id), 1)                                           AS female_pct
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'Active'
GROUP BY d.dept_name
ORDER BY female_pct DESC;


-- ---------------------------------------------------------------
-- Q11. Employees earning above department average salary
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name)  AS employee_name,
    e.job_title,
    d.dept_name,
    e.salary,
    ROUND(dept_avg.avg_sal, 2)              AS dept_avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN (
    SELECT dept_id, AVG(salary) AS avg_sal
    FROM employees
    WHERE status = 'Active'
    GROUP BY dept_id
) dept_avg ON e.dept_id = dept_avg.dept_id
WHERE e.salary > dept_avg.avg_sal
  AND e.status = 'Active'
ORDER BY d.dept_name, e.salary DESC;


-- ---------------------------------------------------------------
-- Q12. Average performance rating trend year over year
-- ---------------------------------------------------------------
SELECT
    review_year,
    COUNT(DISTINCT emp_id)       AS employees_reviewed,
    ROUND(AVG(rating), 2)        AS avg_rating,
    SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) AS excellent_count,
    SUM(CASE WHEN rating <= 2 THEN 1 ELSE 0 END) AS low_performers
FROM performance_reviews
GROUP BY review_year
ORDER BY review_year;


-- ---------------------------------------------------------------
-- Q13. Recent hires (joined in last 2 years) still in probation
--       (assumed: < 1 year tenure = probation)
-- ---------------------------------------------------------------
SELECT
    emp_id,
    CONCAT(first_name, ' ', last_name)                     AS full_name,
    job_title,
    hire_date,
    TIMESTAMPDIFF(MONTH, hire_date, CURDATE())             AS months_of_service
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
  AND TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) < 12
  AND status = 'Active'
ORDER BY hire_date DESC;


-- ---------------------------------------------------------------
-- Q14. Employees due for annual review (no review in current year)
-- ---------------------------------------------------------------
SELECT
    e.emp_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.job_title,
    d.dept_name,
    MAX(pr.review_year)                    AS last_reviewed_year
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN performance_reviews pr ON e.emp_id = pr.emp_id
WHERE e.status = 'Active'
GROUP BY e.emp_id, employee_name, e.job_title, d.dept_name
HAVING last_reviewed_year IS NULL
    OR last_reviewed_year < YEAR(CURDATE())
ORDER BY last_reviewed_year ASC;


-- ---------------------------------------------------------------
-- Q15. Exit analysis — voluntary vs involuntary + rehire eligibility
-- ---------------------------------------------------------------
SELECT
    a.exit_type,
    COUNT(*)                                             AS exits,
    SUM(CASE WHEN a.rehire_flag = TRUE THEN 1 ELSE 0 END)  AS rehire_eligible,
    GROUP_CONCAT(CONCAT(e.first_name,' ',e.last_name) SEPARATOR ', ') AS employees
FROM attrition a
JOIN employees e ON a.emp_id = e.emp_id
GROUP BY a.exit_type;


-- =============================================================
-- SECTION 4: VIEWS (Reusable for Dashboards / BI Tools)
-- =============================================================

-- View: Active Employee Master
CREATE OR REPLACE VIEW vw_active_employees AS
SELECT
    e.emp_id,
    CONCAT(e.first_name,' ',e.last_name) AS full_name,
    e.email,
    e.job_title,
    d.dept_name,
    e.salary,
    e.hire_date,
    e.gender,
    TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS tenure_years,
    TIMESTAMPDIFF(YEAR, e.date_of_birth, CURDATE()) AS age
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'Active';

-- View: Department KPI Summary
CREATE OR REPLACE VIEW vw_dept_kpi AS
SELECT
    d.dept_name,
    COUNT(e.emp_id)                         AS headcount,
    ROUND(AVG(e.salary),2)                  AS avg_salary,
    SUM(e.salary)                           AS total_payroll,
    d.budget,
    ROUND(100.0 * SUM(e.salary) / d.budget, 1) AS payroll_to_budget_pct
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id AND e.status = 'Active'
GROUP BY d.dept_name, d.budget;

