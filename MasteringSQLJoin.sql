##########################################################
##########################################################
-- SQL Joins in PostgreSQL
##########################################################
##########################################################


#############################
retrieve data from the dept_manager_dup and
-- departments_dup tables in the database
#############################

-- Retrieve all data from the dept_manager_dup table
SELECT * 
FROM dept_manager_dup
ORDER BY dept_no;


-- Retrieve all data from the departments_dup table
SELECT *
FROM departments_dup
ORDER BY dept_no;

#############################
-- INNER JOIN : retrieve data from the two 
-- tables using INNER JOIN
#############################

##########
-- INNER JOIN

-- Extract all managers' employees number, department number, 
-- and department name. Order by the manager's department number
SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- add m.from_date and m.to_date

SELECT m.emp_no, m.dept_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

--same result
SELECT m.emp_no, m.dept_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

-- Extract a list containing information about all managers'
-- employee number, first and last name, dept_number and hire_date
-- Hint: Use the employees and dept_manager tables

-- Retrieve data from the employees and dept_manager

SELECT * FROM employees;
SELECT * FROM dept_manager;
 employee number, first and last name, dept_number and hire_date
-- Solution to 2.2

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e 
JOIN dept_manager dm
ON e.emp_no = m.emp_no;

#############################
-- Duplicate Records
-- Retrieve data from the two 
-- tables with duplicate records using INNER JOIN
#############################

###########
-- Duplicate Records

-- Let us add some duplicate records
-- Insert records into the dept_manager_dup and departments_dup tables respectively

INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- Select all records from the dept_manager_dup table

SELECT *
FROM dept_manager_dup
ORDER BY dept_no ASC;

-- Select all records from the departments_dup table

SELECT *
FROM departments_dup
ORDER BY dept_no ASC;

-- Perform INNER JOIN as before
SELECT m.emp_no, m.dept_no, m.from_date, m.to_date, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

-- add a GROUP BY clause. Make sure to include all the fields in the GROUP BY clause
SELECT m.emp_no, m.dept_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON d.dept_no = m.dept_no
GROUP BY m.emp_no, m.dept_no, d.dept_name
ORDER BY m.dept_no;


#############################
-- LEFT JOIN: Retrieve data from the two tables using LEFT JOIN
#############################

###########
-- LEFT JOIN

-- Remove the duplicates from the two tables
DELETE FROM dept_manager_dup 
WHERE emp_no = '110228';
        
DELETE FROM departments_dup 
WHERE dept_no = 'd009';

-- Add back the initial records
INSERT INTO dept_manager_dup 
VALUES 	('110228', 'd003', '1992-03-21', '9999-01-01');
        
INSERT INTO departments_dup 
VALUES	('d009', 'Customer Service');

-- Select all records from dept_manager_dup
SELECT *
FROM dept_manager_dup
ORDER BY dept_no;

-- Select all records from departments_dup
SELECT *
FROM departments_dup
ORDER BY dept_no;

-- Recall the previous INNER JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Join the dept_manager_dup and departments_dup tables
-- Extract a subset of all managers' employee number, department number, 
-- and department name. Order by the managers' department number
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- What will happen when we d LEFT JOIN m?
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d 
LEFT JOIN dept_manager_dup m 
ON d.dept_no = m.dept_no
ORDER BY m.dept_no;

-- Let's select d.dept_no
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d 
LEFT JOIN dept_manager_dup m 
ON d.dept_no = m.dept_no
ORDER BY d.dept_no;

-- LEFT OUTER JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d 
LEFT OUTER JOIN dept_manager_dup m 
ON d.dept_no = m.dept_no
ORDER BY m.dept_no;


#############################
-- RIGHT JOIN : Retrieve data from the two tables using RIGHT JOIN
#############################

###########
-- RIGHT JOIN

-- We have seen LEFT JOIN in the previous task

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
LEFT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- Let's use RIGHT JOIN
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY dept_no;

-- SELECT d.dept_no
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

-- d LEFT JOIN m
SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager_dup m 
ON m.dept_no = d.dept_no
ORDER BY dept_no;

#############################
-- JOIN and WHERE Used Together
-- Retrieve data from tables
-- using JOIN and WHERE together
#############################

###########
-- JOIN and WHERE Used Together

-- Extract the employee number, first name, last name and salary
-- of all employees who earn above 145000 dollars per year

-- Let us retrieve all data in the salaries table
SELECT * FROM salaries;

-- Solution
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
WHERE salary > 145000;


-- What do you think will be the output of this query?

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
WHERE s.salary > 145000;

-- Select the first and last name, the hire date and the salary
-- of all employees whose first name is 'Mario' and last_name is 'Straney'
SELECT e.first_name, e.last_name, e.hire_date, s.salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
WHERE e.first_name = 'Mario' AND e.last_name = 'Straney'
ORDER BY e.emp_no;

-- Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees whose last name is 'Markovitch'. 
-- See if the output contains a manager with that name
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no,dm.from_date
FROM employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no,e.emp_no;

-- Join the 'employees' and the 'dept_manager' tables to return a subset
-- of all the employees who were hired before 31st of January, 1985
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no,dm.from_date
FROM employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.hire_date < '1985-01-31'
ORDER BY dm.dept_no,e.emp_no;


#############################
-- Using Aggregate Functions with Joins
-- Retrieve data from tables in the employees database,
-- using Aggregate Functions with Joins
#############################

###########
-- Using Aggregate Functions with Joins

-- What is the average salary for the different gender?

SELECT e.gender, ROUND (AVG(salary),2) AS average_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
GROUP BY e.gender;

-- What do you think will be the output if we SELECT e.emp_no?
SELECT e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, gender; 

-- How many males and how many females managers do we have in
-- employees database?
SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no
GROUP BY gender;



#############################
-- Join more than Two Tables in SQL
-- Retrieve data from tables in the employees database,
-- by joining more than two Tables in SQL
#############################

###########
-- Join more than Two Tables in SQL

-- Extract a list of all managers' first and last name, dept_no, hire date, to_date,
-- and department name
SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date, m to_date, d.dept_name
FROM employees e
JOIN dept_manager m
ON e.emp_no = m.emp_no
JOIN departments d
ON m.dept_no = d.dept_no;


-- What do you think will be the output of this?
SELECT e.first_name, e.last_name, m.dept_no, e.hire_date, m.to_date, d.dept_name
FROM departments d
JOIN dept_manager m 
ON d.dept_no = m.dept_no
JOIN employees e 
ON m.emp_no = e.emp_no;

-- Retrieve the average salary for the different departments

-- Retrieve all data from departments table
SELECT * FROM departments

-- Retrieve all data from dept_emp table
SELECT * FROM dept_emp

-- Retrieve all data from salaries table
SELECT * FROM salaries

-- Solution the average salary per department
SELECT d.dept_name, AVG(salary) AS average_salary
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY AVG(salary) DESC; 


-- Retrieve the average salary for the different departments where the
-- average_salary is more than 60000

SELECT d.dept_name, ROUND(AVG(salary),2) AS average_salary
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
JOIN salaries s
ON de.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING AVG(salary) > 60000 
ORDER BY AVG(salary) DESC; 

--because we filter based on average, we use having after the grouping

#############################
-- FULL OUTER JOIN : Retrieve data from the two tables using FULL OUTER JOIN JOIN
#############################

###########
-- FULL OUTER JOIN : is like using LEFT JOIN and RIGHT JOIN together
-- it will return all rows from both table and where there's no match between the two, NULL will be displayed

SELECT *
FROM dept_manager_dup m
FULL OUTER JOIN departments_dup d 
ON m.dept_no = d.dept_no;

#############################
-- CROSS JOIN : Retrieve data from the two tables using CROSS JOIN
#############################

###########
-- CROSS JOIN : 
-- it will return all possible combination between two table
-- CROSS JOIN does not need ON statement

SELECT *
FROM dept_manager_dup m
CROSS JOIN departments_dup d; 

#############################
-- UNION : Retrieve data from the two tables using UNION
#############################

###########
-- UNION: 

-- clause/operator is used to combine the results of two or more SELECT statements without returning any duplicate rows.
-- To use this UNION clause, each SELECT statement must have
--		The same number of columns selected
--		The same number of column expressions
--		The same data type and
-- 		Have them in the same orde
--		But they need not have to be in the same length.
-- Stacked two table together, the first statement/table showed up at the top

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no
	UNION
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no


#############################
-- UNION ALL : Retrieve data from the two tables using UNION ALL
#############################

###########
-- UNION ALL: 
-- the different between UNION ALL and UNION is that: 
-- Union All will not removes duplicate rows or records, instead, 
-- it just selects all the rows from all the tables which meets the conditions of your specifics query 
-- and combines them into the result table. 

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no
	UNION ALL
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
RIGHT JOIN departments_dup d 
ON m.dept_no = d.dept_no