
------------------------------
-- CASE Statements from simple CASE statement to combination
-- with JOIN, SUBQUERY, AGGREGATE, TRANSPOSE

#############################
-- single CASE clause
#############################

-- Retrieve all the data in the employees table
SELECT * FROM employees;

-- Change the gender attribute from M to Male and F to Female in
-- gender column in the employees table

SELECT gender,
	CASE
		WHEN gender = 'M' THEN 'Male'
		ELSE 'Female'
	END AS Fullgender
FROM employees;

-- Different way writing it

SELECT gender,
	CASE gender
		WHEN 'M' THEN 'Male'
		ELSE 'Female'
	END AS Fullgender
FROM employees;

#############################
-- add multiple conditions to a CASE statement
#############################

-- Retrieve all the data in the customers table
SELECT * FROM customers;

-- Create a column called Age_Category that returns Young for ages less than 30,
-- Aged for ages greater than 60, and Middle Aged otherwise
SELECT age,
	CASE WHEN age < 30 THEN 'Young'
		 WHEN age > 60 THEN 'Aged'
		 ELSE 'Middle Aged'
	END AS Age_Category
FROM customers
ORDER BY age, age_category;

-- Retrieve a list of employees that were employed before 1990, between 1990 and 1995, and
-- after 1995
SELECT * FROM employees;

SELECT emp_no, hire_date, EXTRACT(YEAR FROM hire_date) AS Year,
	CASE WHEN EXTRACT(YEAR FROM hire_date) < 1990 THEN 'Employed before 1990'
		 WHEN EXTRACT(YEAR FROM hire_date) BETWEEN 1990 AND 1995 THEN 'Employed between 1990 and 1995'
		 ELSE 'Employed After 1995'
	END AS Employment_status
FROM employees;

SELECT emp_no, hire_date, EXTRACT(YEAR FROM hire_date) AS Year,
	CASE WHEN EXTRACT(YEAR FROM hire_date) < 1990 THEN 'Employed before 1990'
		 WHEN EXTRACT(YEAR FROM hire_date) >=1990  AND EXTRACT(YEAR FROM hire_date) <= 1995 THEN 'Employed between 1990 and 1995'
		 ELSE 'Employed After 1995'
	END AS Employement_status
FROM employees;


#############################
-- the CASE clause and SQL aggregate functions to retrieve data
#############################

-- Retrieve the average salary of all employees
SELECT * FROM salaries;

SELECT emp_no, ROUND (AVG(salary),3) AS Average_salary
FROM salaries
GROUP BY emp_no
ORDER BY AVG(salary) DESC;

-- Retrieve a list of the average salary of employees. If the average salary is more than
-- 80000, return Paid Well. If the average salary is less than 80000, return Underpaid,
-- otherwise, return Unpaid

SELECT emp_no, ROUND(AVG(salary), 3) AS average_salary,
CASE
    WHEN AVG(salary) > 80000 THEN 'Paid Well'
    WHEN AVG(salary) < 80000 THEN 'Underpaid'
ELSE 'Unpaid'
END AS Payment_status
FROM salaries
GROUP BY emp_no
ORDER BY average_salary DESC;

-- Retrieve a list of the average salary of employees. If the average salary is more than
-- 80000 but less than 100000, return Paid Well. If the average salary is less than 80000,
-- return Underpaid, otherwise, return Manager

SELECT emp_no, ROUND(AVG(salary), 3) AS average_salary,
CASE
    WHEN AVG(salary) >= 80000 AND AVG(salary) <100000 THEN 'Paid Well'
    WHEN AVG(salary) < 80000 THEN 'Underpaid'
ELSE 'Manager'
END AS payment_status
FROM salaries
GROUP BY emp_no
ORDER BY average_salary DESC;


-- Count the number of employees in each salary category
WITH temp AS(
SELECT emp_no, ROUND(AVG(salary), 3) AS average_salary,
CASE
    WHEN AVG(salary) >= 80000 AND AVG(salary) <100000 THEN 'Paid Well'
    WHEN AVG(salary) < 80000 THEN 'Underpaid'
ELSE 'Manager'
END AS payment_status
FROM salaries
GROUP BY emp_no
ORDER BY average_salary DESC
)
SELECT temp.payment_status, COUNT (*) AS StatusCount
FROM temp
GROUP BY 1;

	-- another way writing it

SELECT a.payment_status, COUNT (*)
FROM (
	SELECT emp_no, ROUND(AVG(salary), 3) AS average_salary,
	CASE
		WHEN AVG(salary) >= 80000 AND AVG(salary) <100000 THEN 'Paid Well'
		WHEN AVG(salary) < 80000 THEN 'Underpaid'
	ELSE 'Manager'
	END AS payment_status
	FROM salaries
	GROUP BY emp_no
	ORDER BY average_salary DESC
) AS a
GROUP BY 1;

#############################
-- To use the CASE clause and SQL Joins to retrieve data
#############################

-- Retrieve all the data from the employees and dept_manager tables
SELECT * FROM employees
ORDER BY emp_no DESC;

SELECT * FROM dept_manager;

-- join all the records in the employees table to the dept_manager table
SELECT e.emp_no, dm.emp_no, e.first_name, e.last_name
FROM employees e
LEFT JOIN dept_manager dm
ON dm.emp_no = e.emp_no
ORDER BY dm.emp_no;

-- Join all the records in the employees table to the dept_manager table
-- where the employee number is greater than 109990
SELECT e.emp_no, dm.emp_no, e.first_name, e.last_name
FROM employees e
LEFT JOIN dept_manager dm
ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

-- Obtain a result set containing the employee number, first name, and last name
-- of all employees. Create a 4th column in the query, indicating whether this
-- employee is also a manager, according to the data in the
-- dept_manager table, or a regular employee

SELECT e.emp_no, e.first_name, e.last_name,
	CASE WHEN dm.emp_no IS NOT NULL THEN 'Manager'
	ELSE 'Employee'
	END AS Employment_status
FROM employees e
LEFT JOIN dept_manager dm
ON dm.emp_no = e.emp_no
ORDER BY dm.emp_no;

-- Obtain a result set containing the employee number, first name, and last name
-- of all employees with a number greater than '109990'. Create a 4th column in the query,
-- indicating whether this employee is also a manager, according to the data in the
-- dept_manager table, or a regular employee

SELECT e.emp_no, e.first_name, e.last_name,
	CASE WHEN dm.emp_no IS NOT NULL THEN 'Manager'
	ELSE 'Employee'
	END AS Employment_status
FROM employees e
LEFT JOIN dept_manager dm
ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990
ORDER BY dm.emp_no;


#############################
-- The CASE Statement together with Aggregate Functions and Joins
-- In this task, we will see how to use the CASE clause together with
-- SQL aggregate functions and SQL Joins to retrieve data
#############################

-- Retrieve all the data from the employees and salaries tables
SELECT * FROM employees;

SELECT * FROM salaries;

-- Retrieve a list of all salaries earned by an employee
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

/* Retrieve a list of employee number, first name and last name.
Add a column called 'salary difference' which is the difference between the
employees' maximum and minimum salary. Also, add a column called
'salary_increase', which returns 'Salary was raised by more than $30,000' if the difference
is more than $30,000, 'Salary was raised by more than $20,000 but less than $30,000',
if the difference is between $20,000 and $30,000, 'Salary was raised by less than $20,000'
if the difference is less than $20,000 */

SELECT e.emp_no, e.first_name, e.last_name, MAX(s.salary)-MIN(s.salary) AS salary_difference,
	CASE WHEN MAX(s.salary)-MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
		 WHEN MAX(s.salary)-MIN(s.salary) >= 20000 AND MAX(s.salary)-MIN(s.salary) <=30000
		 	THEN 'Salary was raised by more than $20,000 but less than $30,000'
		 ELSE 'Salary was raised by less than $20,000'
	END AS salary_increase
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, s.emp_no;


-- Retrieve all the data from the employees and dept_emp tables
SELECT * FROM employees;

SELECT * FROM dept_emp;

/* Extract the employee number, first and last name of the first 100 employees,
and add a fourth column called "current_employee" saying "Is still employed",
if the employee is still working in the company, or "Not an employee anymore",
if they are not more working in the company.
Hint: We will need data from both the 'employees' and 'dept_emp' table to solve this exercise */

SELECT e.emp_no, e.first_name, e.last_name,
CASE
	WHEN MAX(de.to_date) > CURRENT_DATE THEN 'Is still employed'
    ELSE 'Not an employee anymore'
END AS current_employee
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
GROUP BY e.emp_no
LIMIT 100;


#############################
-- Transposing data using the CASE clause
-- In this task, we will learn how to use the SQL CASE statement to
-- transpose retrieved data
#############################

-- Retrieve all the data from the sales table
SELECT * FROM sales;

-- Retrieve the count of the different profit_category from the sales table
SELECT a.profit_category, COUNT(*)
FROM (
SELECT order_line, profit,
CASE
	WHEN profit < 0 THEN 'No Profit'
	WHEN profit > 0 AND profit < 500 THEN 'Low Profit'
	WHEN profit > 500 AND profit < 1500 THEN 'Good Profit'
	ELSE 'High Profit'
END AS profit_category
FROM sales
) a
GROUP BY a.profit_category;


WITH temp AS (
	SELECT order_line, profit,
		CASE WHEN profit < 0 THEN 'No profit'
			 WHEN profit > 0 AND profit <500 THEN 'Low Profit'
			 WHEN profit > 500 AND profit <1500 THEN 'Good Profit'
			 ELSE 'High Profit'
		END AS profit_category
	FROM sales
)
SELECT profit_category, COUNT(*)
FROM temp
GROUP BY profit_category;

-- Transpose the above table to display rows of profit_category into columns
SELECT
	SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS no_profit,
	SUM(CASE WHEN profit > 0 AND profit < 500 THEN 1 ELSE 0 END) AS low_profit,
	SUM(CASE WHEN profit > 500 AND profit < 1500 THEN 1 ELSE 0 END) AS good_profit,
	SUM(CASE WHEN profit > 1500 THEN 1 ELSE 0 END) AS high_profit
FROM sales;

-- Retrieve the number of employees in the first four departments in the dept_emp table

SELECT * FROM dept_emp;

SELECT dept_no, COUNT(*)
FROM dept_emp
WHERE dept_no IN ('d001', 'd002', 'd003', 'd004')
GROUP BY dept_no
ORDER BY dept_no;

-- Transpose the above table to display each dept in a column istead of in rows
SELECT
	SUM(CASE WHEN dept_no = 'd001' THEN 1 ELSE 0 END) AS dept1,
	SUM(CASE WHEN dept_no = 'd002' THEN 1 ELSE 0 END) AS dept2,
	SUM(CASE WHEN dept_no = 'd003' THEN 1 ELSE 0 END) AS dept3,
	SUM(CASE WHEN dept_no = 'd004' THEN 1 ELSE 0 END) AS dept4
FROM dept_emp;
