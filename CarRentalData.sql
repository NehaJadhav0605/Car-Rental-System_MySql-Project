drop database car_rental_db;
create database car_rental_sys;
use car_rental_sys;
show databases;
show tables;

/*=================================== Data Defination Language (DDL) =====================================*/

/*================ Create() =================*/

/*Customers table*/
CREATE TABLE Customers (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerCode VARCHAR(10) UNIQUE NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Email VARCHAR(100) NOT NULL UNIQUE,
  Phone VARCHAR(15) NOT NULL UNIQUE,
  LicenseNumber VARCHAR(30) NOT NULL UNIQUE,
  DateOfBirth DATE NOT NULL,
  Address VARCHAR(255)
);
desc Customers;

/* Cars table */
CREATE TABLE Cars (
  CarID INT AUTO_INCREMENT PRIMARY KEY,
  CarCode VARCHAR(10) UNIQUE NOT NULL,
  CarModel VARCHAR(100) NOT NULL,
  CarType ENUM('Sedan','SUV','Hatchback','Luxury') NOT NULL,
  RegistrationNumber VARCHAR(20) NOT NULL UNIQUE,
  DailyRate DECIMAL(10,2) NOT NULL CHECK (DailyRate > 0),
  Status ENUM('Available','Rented','Maintenance') NOT NULL DEFAULT 'Available'
);
desc Cars;

/* Employees table */
CREATE TABLE Employees (
  EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
  EmployeeCode VARCHAR(10) UNIQUE NOT NULL,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50),
  Role ENUM('Manager','Staff','Driver','Mechanic') NOT NULL,
  HireDate DATE NOT NULL,
  Salary DECIMAL(12,2) NOT NULL CHECK (Salary > 5000)
);
desc Employees;

/* Bookings table */
CREATE TABLE Bookings (
  BookingID INT AUTO_INCREMENT PRIMARY KEY,
  BookingCode VARCHAR(10) UNIQUE NOT NULL,
  CustomerID INT NOT NULL,
  CarID INT NOT NULL,
  BookingDate DATE NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  TotalAmount DECIMAL(12,2) NOT NULL CHECK (TotalAmount >= 0),
  Status ENUM('Ongoing','Completed','Cancelled') NOT NULL DEFAULT 'Ongoing',
  CONSTRAINT fk_booking_customer FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_booking_car FOREIGN KEY (CarID)
    REFERENCES Cars(CarID)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (EndDate > StartDate)
);
desc Bookings;

/* Payments table */
CREATE TABLE Payments (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  BookingID INT NOT NULL,
  PaymentDate DATE NOT NULL,
  AmountPaid DECIMAL(12,2) NOT NULL CHECK (AmountPaid > 0),
  PaymentMethod ENUM('Cash','Card','UPI','NetBanking') NOT NULL DEFAULT 'Cash',
  PaymentStatus ENUM('Success','Pending','Failed') NOT NULL DEFAULT 'Pending',
  CONSTRAINT fk_payment_booking FOREIGN KEY (BookingID)
    REFERENCES Bookings(BookingID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
desc Payments;

/* CarMaintenance table */
CREATE TABLE CarMaintenance (
  MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
  MaintenanceCode VARCHAR(10) UNIQUE NOT NULL,
  CarID INT NOT NULL,
  EmployeeID INT NOT NULL,
  MaintenanceDate DATE NOT NULL,
  Description TEXT,
  Cost DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Cost >= 0),
  CONSTRAINT fk_maintenance_car FOREIGN KEY (CarID)
    REFERENCES Cars(CarID)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_maintenance_employee FOREIGN KEY (EmployeeID)
    REFERENCES Employees(EmployeeID)
    ON DELETE RESTRICT ON UPDATE CASCADE
);
Desc CarMaintenance;

/* Car Fual Logs Table */
CREATE TABLE CarFuelLogs (
  FuelLogID INT AUTO_INCREMENT PRIMARY KEY,
  FuelLogCode VARCHAR(10) UNIQUE NOT NULL,
  CarID INT NOT NULL,
  FuelDate DATE NOT NULL,
  FuelAmount DECIMAL(8,3) NOT NULL CHECK (FuelAmount > 0),
  Cost DECIMAL(8,2) NOT NULL CHECK (Cost >= 0),
  FuelStation VARCHAR(100),
  CONSTRAINT fk_fuellog_car FOREIGN KEY (CarID)
    REFERENCES Cars(CarID)
    ON DELETE CASCADE ON UPDATE CASCADE
);
desc CarFuelLogs;

/*============== Alter() ==============*/

/* Adding column PaymentCode to table Payments */
ALTER TABLE Payments ADD COLUMN PaymentCode VARCHAR(10) UNIQUE NOT NULL AFTER PaymentID;

/* Modifying size of column CarModel from Table Cars */
ALTER TABLE Cars MODIFY COLUMN CarModel VARCHAR(150) NOT NULL;

/* Modifying datatype of coulmn FuelAmount from table CarFuelLogs */
ALTER TABLE CarFuelLogs MODIFY COLUMN FuelDate DATETIME NOT NULL;

/* Renaming column FuelDate to DateOfFuel from table CarFuelLogs */
ALTER TABLE CarFuelLogs RENAME COLUMN FuelDate TO DateOfFuel;

/*Renaming Table CarFuelLogs to FuelLogs */
ALTER TABLE CarFuelLogs RENAME TO FuelLogs;
desc FuelLogs;

/*=============== Truncate() =================*/

/* Truncating Table FuelLogs */
TRUNCATE TABLE FuelLogs;
SELECT * FROM FuelLogs;

/*================ Drop() ===================*/

/* Droping table FuelLogs */
DROP TABLE FuelLogs;
SELECT * FROM FuelLogs;

/*============================== Data Manipulation Language (DML) ==================================*/

/*================ INSERT() ================*/

INSERT INTO Customers (CustomerCode, FirstName, LastName, Email, Phone, LicenseNumber, DateOfBirth, Address)
VALUES
('CUS101','Rahul','Sharma','rahul.sharma@example.com','9876543210','MH12AB1234','1995-05-12','Pune, Maharashtra'),
('CUS102','Sneha','Patil','sneha.patil@example.com','9823456789','MH14CD5678','1998-09-25','Mumbai, Maharashtra'),
('CUS103','Amit','Verma','amit.verma@example.com','9812345678','DL08EF9101','1989-02-10','Delhi'),
('CUS104','Priya','Mehta','priya.mehta@example.com','9834567890','GJ01GH1122','1992-11-18','Ahmedabad, Gujarat'),
('CUS105','Karan','Joshi','karan.joshi@example.com','9845678901','RJ27IJ3344','1990-07-03','Jaipur, Rajasthan'),
('CUS106','Anjali','Kapoor','anjali.kapoor@example.com','9856789012','KA05KL5566','1996-12-22','Bengaluru, Karnataka'),
('CUS107','Vikram','Singh','vikram.singh@example.com','9867890123','UP16MN7788','1988-04-14','Lucknow, Uttar Pradesh'),
('CUS108','Neha','Rao','neha.rao@example.com','9878901234','TS09OP9900','1997-08-05','Hyderabad, Telangana'),
('CUS109','Rohit','Nair','rohit.nair@example.com','9889012345','KL07QR2233','1991-01-27','Kochi, Kerala'),
('CUS110','Meera','Desai','meera.desai@example.com','9890123456','MH31ST4455','1994-10-16','Nagpur, Maharashtra'),
('CUS111','Arjun','Kulkarni','arjun.kulkarni@example.com','9811122233','MH20UV6677','1993-03-09','Aurangabad, Maharashtra'),
('CUS112','Simran','Kaur','simran.kaur@example.com','9822233344','PB10WX8899','1995-07-19','Chandigarh, Punjab'),
('CUS113','Dev','Malhotra','dev.malhotra@example.com','9833344455','HR26YZ0011','1987-12-30','Gurgaon, Haryana'),
('CUS114','Ishita','Roy','ishita.roy@example.com','9844455566','WB20AB2233','1999-06-21','Kolkata, West Bengal'),
('CUS115','Manish','Choudhary','manish.choudhary@example.com','9855566677','MP09CD4455','1992-09-12','Bhopal, Madhya Pradesh');

select * from Customers;

INSERT INTO Cars (CarCode, CarModel, CarType, RegistrationNumber, DailyRate, Status)
VALUES
 ('CAR101','Swift Dzire','Sedan','MH12AB1234',1200.00,'Available'),
 ('CAR102','i20','Hatchback','MH14CD5678',1500.00,'Rented'),          
 ('CAR103','City','Sedan','DL08EF9101',2000.00,'Available'),
 ('CAR104','EcoSport','SUV','GJ01GH1122',1800.00,'Available'),
 ('CAR105','Baleno','Hatchback','RJ27IJ3344',1700.00,'Available'),
 ('CAR106','Creta','SUV','KA05KL5566',2200.00,'Maintenance'),
 ('CAR107','Innova Crysta','SUV','UP16MN7788',3000.00,'Available'),
 ('CAR108','Altroz','Hatchback','TS09OP9900',1600.00,'Rented'),         
 ('CAR109','Fortuner','Luxury','KL07QR2233',4500.00,'Maintenance'),
 ('CAR110','XUV500','SUV','MH31ST4455',2800.00,'Available');

select * from Cars;

INSERT INTO Employees (EmployeeCode, FirstName, LastName, Role, HireDate, Salary)
VALUES
 ('EMP101','Rajesh','Sharma','Manager','2018-04-12',55000.00),
 ('EMP102','Suman','Verma','Staff','2019-06-20',28000.00),
 ('EMP103','Aakash','Reddy','Driver','2020-01-15',18000.00),
 ('EMP104','Priya','Iyer','Mechanic','2021-03-05',22000.00),
 ('EMP105','Kiran','Patil','Staff','2017-09-10',30000.00),
 ('EMP106','Vikram','Kapoor','Driver','2022-07-22',17000.00),
 ('EMP107','Anita','Desai','Mechanic','2019-11-01',25000.00),
 ('EMP108','Suresh','Menon','Staff','2020-08-19',27000.00),
 ('EMP109','Meena','Chopra','Manager','2016-12-14',60000.00),
 ('EMP110','Arjun','Malhotra','Driver','2023-02-10',16000.00);

select * from Employees;

INSERT INTO Bookings (BookingCode, CustomerID, CarID, BookingDate, StartDate, EndDate, TotalAmount, Status)
VALUES
 ('BKG101', 1, 1, '2023-01-10', '2023-01-12', '2023-01-15', 3600.00, 'Completed'),
 ('BKG102', 2, 3, '2023-02-05', '2023-02-06', '2023-02-08', 4000.00, 'Completed'),
 ('BKG103', 3, 2, '2023-03-02', '2023-03-03', '2023-03-06', 4500.00, 'Cancelled'),
 ('BKG104', 4, 5, '2023-04-12', '2023-04-13', '2023-04-15', 3400.00, 'Completed'),
 ('BKG105', 5, 4, '2023-05-20', '2023-05-21', '2023-05-23', 3600.00, 'Completed'),
 ('BKG106', 6, 7, '2023-06-18', '2023-06-20', '2023-06-24', 12000.00, 'Ongoing'),
 ('BKG107', 7, 6, '2023-07-25', '2023-07-26', '2023-07-29', 6600.00, 'Completed'),
 ('BKG108', 8, 8, '2023-08-10', '2023-08-11', '2023-08-13', 3200.00, 'Cancelled'),
 ('BKG109', 9, 9, '2023-09-01', '2023-09-02', '2023-09-05', 13500.00, 'Completed'),
 ('BKG110', 10, 10, '2023-10-12', '2023-10-13', '2023-10-15', 5600.00, 'Ongoing');

select * from Bookings;

INSERT INTO Payments (PaymentCode, BookingID, PaymentDate, AmountPaid, PaymentMethod, PaymentStatus)
VALUES
 ('PAY101', 1, '2023-01-15', 3600.00, 'Card', 'Success'),
 ('PAY102', 2, '2023-02-08', 4000.00, 'UPI', 'Success'),
 ('PAY103', 3, '2023-03-04', 4500.00, 'Cash', 'Failed'),
 ('PAY104', 4, '2023-04-15', 3400.00, 'NetBanking', 'Success'),
 ('PAY105', 5, '2023-05-23', 3600.00, 'Card', 'Success'),
 ('PAY106', 6, '2023-06-21', 6000.00, 'UPI', 'Pending'),
 ('PAY107', 7, '2023-07-29', 6600.00, 'Cash', 'Success'),
 ('PAY108', 8, '2023-08-13', 3200.00, 'Card', 'Failed'),
 ('PAY109', 9, '2023-09-05', 13500.00, 'NetBanking', 'Success'),
 ('PAY110',10, '2023-10-14', 2800.00, 'UPI', 'Pending');

select * from Payments;

INSERT INTO CarMaintenance (MaintenanceCode, CarID, EmployeeID, MaintenanceDate, Description, Cost)
VALUES
 ('MAIN101', 1, 4, '2023-01-20', 'Oil change and filter replacement', 1500.00),
 ('MAIN102', 3, 5, '2023-02-10', 'Brake pad replacement', 3000.00),
 ('MAIN103', 2, 6, '2023-03-05', 'Clutch repair', 5000.00),
 ('MAIN104', 7, 7, '2023-03-22', 'Engine tuning and diagnostics', 4000.00),
 ('MAIN105', 5, 8, '2023-04-15', 'Air conditioning service', 2500.00),
 ('MAIN106', 4, 5, '2023-05-09', 'Wheel alignment and balancing', 1200.00),
 ('MAIN107', 8, 9, '2023-06-11', 'Battery replacement', 4500.00),
 ('MAIN108', 6, 10,'2023-07-19', 'Suspension repair', 6000.00),
 ('MAIN109', 9, 5, '2023-08-25', 'Paint touch-up', 3500.00),
 ('MAIN110',10, 6, '2023-09-30', 'Full body servicing', 8000.00);

select * from CarMaintenance;

/*================= Update() ====================*/

/* Updating Status column from Cars table where CarID is 8 */
UPDATE Cars SET Status = 'Available' WHERE CarID = 8;

/*================== Delete() ====================*/

/* Deleteing one record from Payments table where PaymentID is 10 */
DELETE from Payments where PaymentID=10;

/*================================= Data Query Language (DQL) =================================*/

/*================ select() =================*/

/* Selecting query for entire data */
select * from CarMaintenance;

/* Selecting specific query: Select CarModel and Dailyrate from Cars Table */
select CarModel, DailyRate from Cars;

/*============== Alisement(as) ============*/ 
/* Select query with changing column name */
select Salary as Monthly_Salary from Employees;

/*==================== Distinct Query ==================*/
/* WAQ to display distinct Car Types */
SELECT DISTINCT CarType FROM Cars;

/*===================================== CLAUSES ======================================*/

/*=========== Where Clause ==========*/

/* WAQ to retrive information about BookingCode and TotalAmount where booking Status is ‘Ongoing’ from Bookings table */
select BookingCode, TotalAmount from Bookings where Status='Ongoing';

/* WAQ to retrive information about employees where Role is 'Driver' from Employees table */
select * from Employees where Role='Driver';

/*=============== Group by Clause ================*/

/*WAQ to list all roles in employees table*/
SELECT Role FROM Employees GROUP BY Role;

/*==== where + Group by =====*/
/*WAQ to group cars by their type, but only those that are "Available" from Cars table*/
SELECT CarType, Status FROM Cars WHERE Status = 'Available' GROUP BY CarType, Status;

/*================== Having Clause ==================*/

/*WAQ to show car data groups where the status is "Available" only from Cars table*/
SELECT Status, COUNT(*) AS TotalCars FROM Cars GROUP BY Status HAVING Status = 'Available';

/*===== where + group by + having =====*/

/*WAQ to show only bookings made after 2023-01-01, and then filter groups where the booking status is "Completed" from Bookings table*/
SELECT Status, COUNT(*) AS TotalBookings FROM Bookings WHERE BookingDate > '2023-01-01' GROUP BY Status HAVING Status = 'Completed';

/*============== Order by Clause ===============*/

/*WAQ to show employees ordered by salary (descending) from Employee table*/
SELECT EmployeeCode, FirstName, LastName, Role, Salary FROM Employees ORDER BY Salary DESC;

/*==== WHERE + ORDER BY ====*/

/*WAQ to list only available cars, ordered by model name (ascending) from Cars table*/
SELECT CarCode, CarModel, CarType, DailyRate, Status FROM Cars WHERE Status = 'Available' ORDER BY CarModel;

/*===== Where + Group by + Order by ======*/

/*WAQ to get cars grouped by type (only available ones), ordered by total count descending from Cars table*/
SELECT CarType, COUNT(*) AS TotalCars FROM Cars WHERE Status = 'Available' GROUP BY CarType ORDER BY TotalCars DESC;

/*====== Where + Group by + Having + Order by =====*/

/* WAQ to get Employees grouped by role, only those hired after 2019, keeping only roles with more than 1 employee, ordered by salary sum descending*/
SELECT Role, COUNT(*) AS TotalEmployees, SUM(Salary) AS TotalSalary FROM Employees 
WHERE HireDate >= '2019-01-01' GROUP BY Role HAVING COUNT(*) > 1 ORDER BY TotalSalary DESC;

/*========================= Limit Clause ======================*/

/*WAQ to show just the first 5 customers*/
SELECT * FROM Customers LIMIT 5;

/*====== LIMIT + WHERE ======*/

/*WAQ to show 3 available cars only*/
SELECT CarCode, CarModel, Status FROM Cars WHERE Status = 'Available' LIMIT 3;

/*====== LIMIT + WHERE + GROUP BY ======*/

/*WAQ to show 2 car statuses with their counts, but only for cars where DailyRate is greater than equal to 1800*/
SELECT Status, COUNT(*) AS TotalCars FROM Cars WHERE DailyRate >= 1800 GROUP BY Status LIMIT 2;

/*====== LIMIT + WHERE + GROUP BY + HAVING ======*/

/*WAQ to show up to 2 roles that have more than 1 employee, hired after 2019*/
SELECT Role, COUNT(*) AS TotalEmployees FROM Employees WHERE HireDate >= '2019-01-01' GROUP BY Role HAVING COUNT(*) > 1 LIMIT 2;

/*====== LIMIT + WHERE + GROUP BY + HAVING + ORDER BY ======*/

/*WAQ to show top 3 customer IDs who made bookings after 2021, only if they booked more than equal to 1, ordered by total bookings*/
SELECT CustomerID, COUNT(*) AS TotalBookings FROM Bookings WHERE StartDate >= '2021-01-01' GROUP BY CustomerID HAVING COUNT(*) >= 1 ORDER BY TotalBookings DESC LIMIT 3;

/*=================================== OPERATORS =====================================*/

/*=================== ARITHMATIC OPERATORS =================*/

-- Addition(+) & Multiplication(*) 
/*Example: Calculate total amount plus tax (assuming 18% GST) */
SELECT BookingCode, TotalAmount, TotalAmount + TotalAmount * 0.18 AS AmountWithGST FROM Bookings;

-- Subtraction (-) 
/* Example: Calculate remaining payment if a customer has paid partially */
SELECT p.PaymentCode, b.BookingCode, b.TotalAmount - p.AmountPaid AS RemainingAmount FROM Payments p JOIN Bookings b ON p.BookingID = b.BookingID;

-- Division (/) 
/* Example: Find average daily payment (if TotalAmount is for multiple days) */
SELECT b.BookingCode, c.CarModel, b.TotalAmount / DATEDIFF(b.EndDate, b.StartDate) AS AvgDailyPayment FROM Bookings b JOIN Cars c ON b.CarID = c.CarID;

-- Modulus (%) 
/* Example: Check which bookings fall on odd or even booking ID */
SELECT BookingCode, BookingID, CASE WHEN BookingID % 2 = 0 THEN 'Even' ELSE 'Odd' END AS BookingType FROM Bookings;

/*==================== COMPARISON OPERATORS ===================*/

-- Equal 
SELECT * FROM Cars WHERE Status = 'Available';

-- Not equal 
SELECT * FROM Cars WHERE Status <> 'Rented';

-- Less than or equal 
SELECT * FROM Payments WHERE AmountPaid <= 1500;

-- Greater than or equal 
SELECT * FROM Employees WHERE Salary >= 25000;

/*============= Logical Operators =============*/

-- AND
SELECT * FROM Cars WHERE Status = 'Available' AND DailyRate < 2000;

-- OR
SELECT * FROM Cars WHERE Status = 'Unavailable' OR Status = 'Maintenance';

-- NOT
SELECT * FROM Employees WHERE NOT Role = 'Driver';

/*======================== Special Operators =======================*/

-- BETWEEN
SELECT * FROM Bookings WHERE TotalAmount BETWEEN 4000 AND 7000;

-- IN / NOT IN
SELECT * FROM Cars WHERE CarID IN (1, 2, 3);

SELECT * FROM Cars WHERE CarID NOT IN (1, 2, 3, 4, 5, 6);

-- ALL / ANY (with subquery)
/* Example 1: Find bookings with amount greater than any booking made by CustomerID = 1 */
SELECT * FROM Bookings WHERE TotalAmount > ANY (SELECT TotalAmount FROM Bookings WHERE CustomerID = 1);

/*Example 2: Find bookings with amount greater than all bookings of CustomerID = 2 */
SELECT * FROM Bookings WHERE TotalAmount > ALL (SELECT TotalAmount FROM Bookings WHERE CustomerID = 2);

-- IS NULL / IS NOT NULL
SELECT CustomerID, Address FROM Customers WHERE Address IS NULL;

SELECT CustomerID, Address FROM Customers WHERE Address IS NOT NULL;

-- LIKE / NOT LIKE
/* Example 1: Names starting with 'R' */
SELECT * FROM Customers WHERE FirstName LIKE 'R%';

/* Example 2: Emails NOT containing 'example' */
SELECT * FROM Customers WHERE Email NOT LIKE '%example%';

-- UNION 
/* Example: Combine cars from two types */
SELECT CarID, CarModel, CarType FROM Cars WHERE CarType = 'Sedan'
UNION
SELECT CarID, CarModel, CarType FROM Cars WHERE CarType = 'SUV';

/*==================== Aggregate Functions =====================*/

-- COUNT()	
-- Example: Count total bookings per car:
SELECT CarID, COUNT(*) AS TotalBookings FROM Bookings GROUP BY CarID;

-- SUM()  
-- Example: Total amount received:  
SELECT SUM(AmountPaid) AS TotalReceived FROM Payments;

-- AVG()   
-- Example: Average daily rate of cars:  
SELECT AVG(DailyRate) AS AvgDailyRate FROM Cars;

-- MIN()    
-- Example: Lowest car rental cost:  
SELECT MIN(DailyRate) AS MinDailyRate FROM Cars;

-- MAX()   
-- Example: Highest salary among employees:  
SELECT MAX(Salary) AS MaxSalary FROM Employees;

/*=================================== Sub-queries =================================*/

/*==================== Single-Row Subqueries ===================*/

/* Example 1: Find the customer with the earliest booking date */

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID = (
    SELECT CustomerID
    FROM Bookings
    ORDER BY BookingDate
    LIMIT 1
);

/* Example 2: Get the car with the highest daily rate */

SELECT CarCode, CarModel, DailyRate
FROM Cars
WHERE DailyRate = (
    SELECT MAX(DailyRate)
    FROM Cars
);

/*=================== Multiple-Row Subqueries ===================*/

/* Example 1: Get employees who are mechanics or drivers */

SELECT EmployeeCode, FirstName, LastName, Role
FROM Employees
WHERE Role = ANY (
    SELECT Role
    FROM Employees
    WHERE Role IN ('Mechanic','Driver')
);

/* Example 2: Get bookings where the total amount is higher than some bookings for the same car type */

SELECT BookingCode, CustomerID, TotalAmount, CarID
FROM Bookings b1
WHERE TotalAmount > ANY (
    SELECT TotalAmount
    FROM Bookings b2
    JOIN Cars c ON b2.CarID = c.CarID
    WHERE c.CarType = 'SUV'
);

/*===================== Multi-Column Subqueries ===================*/

/* Example 1: Find bookings that match specific car and customer pairs from completed bookings */

SELECT BookingCode, CustomerID, CarID
FROM Bookings
WHERE (CustomerID, CarID) IN (
    SELECT CustomerID, CarID
    FROM Bookings
    WHERE Status = 'Completed'
);

/* Example 2: Find cars and their daily rates that match exactly the lowest daily rate per car type */

SELECT CarCode, CarType, DailyRate
FROM Cars
WHERE (CarType, DailyRate) IN (
    SELECT CarType, MIN(DailyRate)
    FROM Cars
    GROUP BY CarType
);

/*==================== Multi-Table Subqueries =====================*/

/* Example 1: Customers who booked cars with daily rate higher than the average daily rate of all SUVs */

SELECT CustomerID, BookingCode, TotalAmount, CarID
FROM Bookings b
WHERE TotalAmount > (
    SELECT AVG(DailyRate)
    FROM Cars c
    JOIN Bookings b2 ON c.CarID = b2.CarID
    WHERE c.CarType = 'SUV'
);

/* Example 2: Find cars whose total maintenance cost exceeds the average maintenance cost for cars of the same type */

SELECT CarID, MaintenanceCode, Cost
FROM CarMaintenance cm
WHERE Cost > (
    SELECT AVG(Cost)
    FROM CarMaintenance cm2
    JOIN Cars c ON cm2.CarID = c.CarID
    WHERE c.CarType = 'Sedan'
);

/*=============================== JOINS ==================================*/

/*============== INNER JOIN ===============*/

/* Example: Get all bookings along with the customer name */

SELECT b.BookingCode, c.FirstName, c.LastName, b.TotalAmount
FROM Bookings b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID;

/*======================== OUTER JOIN =========================*/
/*================ LEFT OUTER JOIN ===============*/

/* Example: List all customers and their bookings (even if some customers haven’t booked yet) */

SELECT c.FirstName, c.LastName, b.BookingCode, b.TotalAmount
FROM Customers c
LEFT JOIN Bookings b ON c.CustomerID = b.CustomerID;

/*================ RIGHT OUTER JOIN ===============*/

/* Example: List all bookings and any payment details (even if payment isn’t done yet) */

SELECT b.BookingCode, p.PaymentID, p.AmountPaid, p.PaymentStatus
FROM Bookings b
RIGHT JOIN Payments p ON b.BookingID = p.BookingID;

SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO Payments (PaymentCode, BookingID, PaymentDate, AmountPaid, PaymentMethod, PaymentStatus)
VALUES ('PAY999', 9998, '2023-09-21', 500.00, 'Cash', 'Pending'),('PAY1000', 9999, '2023-09-21', 750.00, 'Card', 'Pending');

/*====================== FULL OUTER JOIN ======================*/

/* Example: List all cars and all maintenance records, even if some cars have no maintenance and some maintenance has no car (for demonstration) */

SELECT car.CarCode, cm.MaintenanceCode, cm.Cost
FROM Cars car
LEFT JOIN CarMaintenance cm ON car.CarID = cm.CarID
UNION
SELECT car.CarCode, cm.MaintenanceCode, cm.Cost
FROM Cars car
RIGHT JOIN CarMaintenance cm ON car.CarID = cm.CarID;

/*========================= CROSS JOIN =========================*/

/* Example: Generate all possible employee-car pairs (for assigning mechanics) */

SELECT e.FirstName, e.LastName, car.CarModel
FROM Employees e
CROSS JOIN Cars car;

/*========================== SELF JOIN =========================*/

/* Example: Find pairs of employees with the same role */

SELECT e1.FirstName AS Employee1, e2.FirstName AS Employee2, e1.Role
FROM Employees e1
INNER JOIN Employees e2 ON e1.Role = e2.Role AND e1.EmployeeID < e2.EmployeeID;

/*================================= WINDOWS FUNCTION ==============================*/

/*================= ROW NUMBER() =================*/
/* Example: Rank bookings by total amount per customer */
SELECT CustomerID, BookingCode, TotalAmount, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY TotalAmount DESC) AS BookingRank 
FROM Bookings ORDER BY CustomerID, BookingRank;

/*================== RANK() =================*/
/* Example: Rank cars by number of bookings */
SELECT CarID, TotalBookings, RANK() OVER (ORDER BY TotalBookings DESC) AS BookingRank
FROM (SELECT CarID, COUNT(BookingID) AS TotalBookings FROM Bookings GROUP BY CarID) AS CarBookingCounts;

/*================= DENSE_RANK() ==================*/
/* Example: Rank employees by their salary, but if two employees have the same salary, they get the same rank without leaving gaps */
SELECT EmployeeCode, FirstName, LastName,Role, Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank FROM Employees;

/*==================== LAG() & LEAD() ===================*/
/* Example: Compare each payment with the previous payment */
SELECT PaymentID, PaymentDate, AmountPaid, LAG(AmountPaid) OVER (ORDER BY PaymentDate) AS PrevPayment, LEAD(AmountPaid) OVER (ORDER BY PaymentDate) AS NextPayment
FROM Payments;

/* LAG → previous row’s amount
LEAD → next row’s amount */

/*=============================== VIEW FUNCTION ================================*/

/*============== Using FIRST_VALUE() in a View ==============*/

/* Example: Show the first booking (lowest amount) per customer */
CREATE VIEW FirstBookingPerCustomer AS
SELECT CustomerID, BookingCode, TotalAmount, FIRST_VALUE(BookingCode) OVER (PARTITION BY CustomerID ORDER BY TotalAmount ASC) AS FirstBooking FROM Bookings;
SELECT * FROM FirstBookingPerCustomer;

/*============== Using LAST_VALUE() in a View =============*/

/* Example: Show the last booking (highest amount) per customer */
CREATE VIEW LastBookingPerCustomer AS SELECT CustomerID, BookingCode, TotalAmount, LAST_VALUE(BookingCode) 
OVER (PARTITION BY CustomerID ORDER BY TotalAmount ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastBooking FROM Bookings;
SELECT * FROM LastBookingPerCustomer;

/*============ Using NTH_VALUE() in a View =============*/

/* Example: Show the 2nd highest booking amount per customer */
CREATE VIEW SecondHighestBooking AS SELECT CustomerID, BookingCode, TotalAmount, NTH_VALUE(BookingCode, 2) 
OVER (PARTITION BY CustomerID ORDER BY TotalAmount DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS SecondBooking FROM Bookings;
SELECT * FROM SecondHighestBooking;

/*=================== NTILE =================*/

/* Example: Divide employees into 4 salary groups (quartiles) */
SELECT EmployeeID, FirstName, Salary, NTILE(4) OVER (ORDER BY Salary DESC) AS SalaryGroup FROM Employees;






