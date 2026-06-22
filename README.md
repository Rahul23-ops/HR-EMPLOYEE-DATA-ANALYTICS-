# 🏢 HR & Employee Data Analytics — SQL Project

> A beginner-friendly SQL project built for aspiring **Data Analysts**, covering real-world HR scenarios using structured relational data.

---

## 📌 Project Overview

This project simulates an **HR database** for a mid-sized company and demonstrates how SQL can be used to extract meaningful workforce insights — from headcount and attrition to salary trends and performance tracking.

It covers all core SQL concepts expected in a fresher data analyst role: **DDL, DML, JOINs, subqueries, aggregations, CASE statements, self-joins, and Views**.

---

## 🗂️ Project Structure

```
hr-sql-project/
│
├── hr_employee_sql_project.sql   # Main SQL file (DDL + DML + Queries + Views)
└── README.md                     # Project documentation
```

---

## 🛠️ Tech Stack

| Tool        | Details                          |
|-------------|----------------------------------|
| Database    | MySQL / PostgreSQL (compatible)  |
| Language    | SQL                              |
| Domain      | Human Resources & Workforce      |

---

## 🗃️ Database Schema

The database `hr_analytics` contains **6 tables**:

### 1. `departments`
Stores department-level information including location and budget.

| Column     | Type           | Description              |
|------------|----------------|--------------------------|
| dept_id    | INT (PK)       | Unique department ID     |
| dept_name  | VARCHAR        | Name of the department   |
| location   | VARCHAR        | City of the department   |
| budget     | DECIMAL(12,2)  | Allocated annual budget  |

---

### 2. `employees`
Core table with employee master data including salary, manager, and status.

| Column        | Type     | Description                              |
|---------------|----------|------------------------------------------|
| emp_id        | INT (PK) | Unique employee ID                       |
| first_name    | VARCHAR  | First name                               |
| last_name     | VARCHAR  | Last name                                |
| email         | VARCHAR  | Work email (unique)                      |
| hire_date     | DATE     | Date of joining                          |
| job_title     | VARCHAR  | Designation                              |
| dept_id       | INT (FK) | Linked department                        |
| salary        | DECIMAL  | Current salary                           |
| manager_id    | INT (FK) | Self-referencing FK (reporting manager)  |
| status        | ENUM     | Active / Resigned / Terminated           |
| gender        | ENUM     | Male / Female / Other                    |
| date_of_birth | DATE     | For age calculation                      |

---

### 3. `performance_reviews`
Annual performance ratings (1–5 scale) given by reviewers.

### 4. `attendance`
Daily attendance records with check-in/check-out times and status (Present, Absent, WFH, Half Day).

### 5. `salary_history`
Tracks salary changes over time — hikes, promotions, and joining packages.

### 6. `attrition`
Logs employee exits — voluntary or involuntary — with reason and rehire eligibility.

---

## 📊 Analytical Queries Covered (15 Total)

| # | Query Topic | SQL Concepts Used |
|---|-------------|-------------------|
| 1 | Active employees with department details | JOIN, WHERE |
| 2 | Headcount & average salary by department | GROUP BY, AVG, MAX, MIN |
| 3 | Employee tenure & bucketing | TIMESTAMPDIFF, CASE WHEN |
| 4 | Employees never reviewed | NOT IN, Subquery |
| 5 | Top performers (rating = 5) | JOIN, Subquery, MAX |
| 6 | Attrition rate by department | SUM with CASE, percentage calc |
| 7 | Monthly attendance summary | Conditional aggregation |
| 8 | Salary hike percentage | Arithmetic in SELECT |
| 9 | Manager–Reportee hierarchy | Self-JOIN |
| 10 | Gender diversity ratio by department | CASE WHEN, GROUP BY |
| 11 | Employees earning above dept average | Subquery in JOIN |
| 12 | Performance rating trend (year over year) | GROUP BY year, AVG |
| 13 | Recent hires still in probation | DATE_SUB, TIMESTAMPDIFF |
| 14 | Employees due for annual review | LEFT JOIN, HAVING |
| 15 | Exit analysis (voluntary vs involuntary) | GROUP_CONCAT, GROUP BY |

---

## 👁️ Reusable Views

Two SQL Views are created for dashboard/BI tool integration:

- **`vw_active_employees`** — Master view with full name, department, tenure, age, and salary for all active staff.
- **`vw_dept_kpi`** — Department-level KPIs: headcount, avg salary, total payroll, and payroll-to-budget ratio.

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/hr-sql-project.git
   cd hr-sql-project
   ```

2. **Open your SQL client** (MySQL Workbench, DBeaver, pgAdmin, or CLI)

3. **Run the SQL file**
   ```sql
   SOURCE hr_employee_sql_project.sql;
   ```
   Or import it via your client's "Run SQL Script" option.

4. **Execute queries section by section** — each query is labeled and independent.

---

## 💡 Key Concepts Demonstrated

- **DDL** — `CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `ENUM`, `CHECK`
- **DML** — `INSERT INTO` with realistic sample data
- **Joins** — `INNER JOIN`, `LEFT JOIN`, Self-Join
- **Subqueries** — Scalar and inline subqueries
- **Aggregations** — `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`, `GROUP BY`, `HAVING`
- **Conditional Logic** — `CASE WHEN`, `IF`
- **Date Functions** — `TIMESTAMPDIFF`, `DATE_SUB`, `CURDATE`, `YEAR`
- **String Functions** — `CONCAT`, `GROUP_CONCAT`
- **Views** — Reusable virtual tables for reporting

---

## 📁 Sample Data

The project includes **15 employees** across **5 departments** (Engineering, HR, Finance, Marketing, Operations) with:
- Varied salary levels, genders, and tenures
- Mix of Active, Resigned, and Terminated statuses
- Attendance records for January 2024
- Performance reviews for 2022 and 2023
- Salary hike history and attrition records

---

## 🙋 About

Built as a **portfolio project** to demonstrate SQL skills for a fresher Data Analyst role.  
Feel free to fork, extend, or connect it to a BI tool like **Power BI** or **Tableau** using the views.
