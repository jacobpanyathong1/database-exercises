SHOW databases;

USE employees;

SHOW TABLES;


SELECT a.first_name, a.last_name, hire_date
FROM (
		SELECT *
		FROM employees
		WHERE hire_date = '1990-10-22') AS a
JOIN dept_emp AS b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE();
		
-- employees with same hire date as emp_no 101010


SELECT 
	c.title AS Title, 
	a.emp_no AS 'Employee Number', 
	CONCAT(a.first_name,' ', a.last_name) AS 'Full Name'
FROM (
		SELECT *
		FROM employees
		WHERE first_name LIKE '%Aamod'
) AS a
JOIN dept_emp AS b 
ON b.emp_no = a.emp_no
JOIN titles AS c 
ON c.emp_no = a.emp_no 
	AND c.to_date > CURDATE();

-- employees named 'Aamod' currently employed with Titles.

SELECT /*a.first_name, a.last_name, b.to_date, */ COUNT(*)
FROM (
		SELECT *
		FROM employees
		
) AS a
JOIN dept_emp AS b 
ON b.emp_no = a.emp_no 
AND b.to_date NOT LIKE '%9999%'
JOIN titles AS c 
ON c.emp_no = a.emp_no;

-- total count of employees who resigned/left employer.
SELECT *
FROM (SELECT emp_no, dept_no
		FROM dept_manager
		WHERE to_date > CURDATE()
) AS a
JOIN employees AS b 
ON a.emp_no = b.emp_no
JOIN departments as c 
ON a.dept_no = c.dept_no 
WHERE gender = 'F'
LIMIT 10;

-- Current Female department Managers

SELECT 
	CONCAT(first_name, ' ', last_name) AS 'full_name', 
	salary, (
		SELECT AVG(salary) 
		FROM salaries
		) AS 'AVG_salary_overall'
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE()
	AND salary > (
			SELECT AVG(salary) 
			FROM salaries
			)
ORDER BY b.salary DESC;
-- Current employees who have salaries greater than the average overall salary.

SELECT AVG(salary)
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE();

-- Average of current salary employees

SELECT COUNT(*)
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE()
;

-- Count of records

SELECT salary, (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		) AS 'avg_current_salaries'
		, salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		) AS 'Variance', POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE()
LIMIT 10;

-- Variance and square values

SELECT salary, (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		) AS 'avg_current_salaries'
		, salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		) AS 'Variance', POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'	
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE()
GROUP BY salary
LIMIT 10;

-- columns of all values to square value.
SELECT POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE()
GROUP BY salary
LIMIT 10;

-- Square value of each salary value for employees
(SELECT SUM((SELECT POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'))/count(*) AS total_value_of_sv
FROM salaries);

-- total value for sum of square value
(SELECT DISTINCT SQRT((SELECT SUM((SELECT POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'))/count(*) AS total_value_of_sv
		FROM salaries)
) AS sqrt_values
FROM salaries);

-- SQRT of sum


SELECT a.first_name, a.last_name, salary, (
		SELECT max(salary)
		FROM salaries
		) AS 'Max',/*
		(SELECT max(salary)
		FROM salaries
		) + round((SELECT DISTINCT SQRT((SELECT SUM((SELECT POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'))/count(*) AS total_value_of_sv
		FROM salaries)
		) AS sqrt_values
		FROM salaries)) AS 'max_plus_stdev',*/
		(SELECT max(salary)
		FROM salaries
		) - round((SELECT DISTINCT SQRT((SELECT SUM((SELECT POWER((
		salary - (
		SELECT (AVG(salary))
		FROM salaries
		WHERE to_date > CURDATE()
		)), 2) AS 'Square_value'))/count(*) AS total_value_of_sv
		FROM salaries)
		) AS sqrt_values
		FROM salaries)) AS 'max_minus_stdev'
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE() AND salary >= 139431
GROUP BY a.first_name, a.last_name, salary;
-- Employees with salaries within the population std dev of max salary.

SELECT Count(*) AS totalcount
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE() AND salary >= 139431;

-- Count of employees with 103 records.

SELECT(SELECT Count(*) AS totalcount
FROM employees AS a
JOIN salaries as b
ON a.emp_no = b.emp_no
WHERE b.to_date > CURDATE() AND salary >= 139431)/count(salary)*100 AS percentage_of_total
FROM salaries;

-- .0036 percent of the salaries is within the population stddev of the max salary.
