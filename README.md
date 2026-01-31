# Car-Rental-System_MySql-Project

## 📌 Project Overview

The Car Rental System is a MySQL-based database project designed to manage the operations of a car rental service.
It simulates real-world business processes such as customer management, car availability tracking, booking operations, payments, maintenance, and fuel logs.

The project focuses on building a well-structured relational database and performing advanced SQL queries to extract meaningful insights from data.

<img width="837" height="601" alt="CarRental_MySql_Database_System" src="https://github.com/user-attachments/assets/dbcd4786-c587-463c-8e0b-4d7de5372fa1" />

## 🎯 Objectives

- Design a relational database for a car rental business.
- Implement business rules using constraints, primary keys, and foreign keys.
- Perform CRUD operations using SQL.
- Apply advanced SQL concepts to solve real-world business queries.

Improve data consistency, integrity, and query efficiency.

## 🏗️ Database Design

### 📂 Database Name:
car_rental_sys

### Tables:

#### The system consists of the following tables:

- Customers
- Cars
- Employees
- Bookings
- Payments
- CarMaintenance
- CarFuelLogs

#### Each table is designed with:

- Primary Keys
- Foreign Keys
- Constraints (NOT NULL, UNIQUE, CHECK, ENUM)
- Referential Integrity

## 🔗 Entity Relationships

- One Customer → Many Bookings
- One Car → Many Bookings
- One Employee → Many Maintenance Records
- One Booking → Many Payments
- One Car → Many Maintenance & Fuel Logs
  
The database structure follows relational modeling principles to reduce redundancy and ensure data integrity.

## ⚙️ SQL Concepts Implemented:

### ✅ 1. Data Definition Language (DDL)

CREATE DATABASE & TABLES

ALTER TABLE (add, modify, rename columns/tables)

DROP & TRUNCATE TABLE

Constraints (PK, FK, CHECK, UNIQUE, DEFAULT)

### ✅ 2. Data Manipulation Language (DML)

INSERT

UPDATE

DELETE

### ✅ 3. Data Query Language (DQL)

SELECT queries with:

WHERE, GROUP BY, HAVING, ORDER BY, LIMIT

DISTINCT, ALIAS

## 🔍Advanced SQL Features Used:

### 🔹 Joins

INNER JOIN

LEFT JOIN

RIGHT JOIN

FULL OUTER JOIN (using UNION)

CROSS JOIN

SELF JOIN

### 🔹 Subqueries

Single-row subqueries

Multi-row subqueries

Multi-column subqueries

Multi-table subqueries

### 🔹 Operators

Arithmetic Operators (+, -, *, /, %)

Comparison Operators (=, <>, >=, <=)

Logical Operators (AND, OR, NOT)

Special Operators (IN, BETWEEN, LIKE, ANY, ALL, IS NULL)

### 🔹 Aggregate Functions

COUNT(), SUM(), AVG(), MIN(), MAX()

### 🔹 Window Functions

ROW_NUMBER()

RANK()

DENSE_RANK()

LAG() & LEAD()

NTILE()

FIRST_VALUE(), LAST_VALUE(), NTH_VALUE()

### 🔹 Views

Analytical views for customer bookings and ranking insights.

## 🛠️ Tools & Technologies:

Database: MySQL

Language: SQL

Concepts: Relational Database Design, Data Analysis

## 💡 Key Learning Outcomes

Strong understanding of relational database design.

Hands-on experience with real-world SQL queries.

Practical use of joins, subqueries, and window functions.

Ability to translate business problems into SQL solutions.

Improved analytical and database optimization skills.

## 👩‍💻 Author

Neha Jadhav

Data Analytics & SQL Enthusiast

### ⭐ If you like this project

Feel free to star ⭐ the repository and explore the SQL scripts!
