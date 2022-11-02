USE employees;

CREATE TEMPORARY TABLE noether_2029.employees_with_departments AS (
SELECT *
FROM employees AS a
JOIN dept_emp AS b
USING (emp_no)
JOIN departments AS c
USING (dept_no)
);


USE noether_2029;

DROP TABLE IF EXISTS employees_with_departments;

SELECT dept_name, full_name
FROM employees_with_departments
LIMIT 100;

ALTER TABLE noether_2029.employees_with_departments
	ADD full_name VARCHAR(50) NOT NULL;

-- Add a column named full_name to this table. 


UPDATE employees_with_departments
SET full_name = CONCAT(first_name,' ', last_name);

-- Drop column

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- We could join the two tables in the employee database and filter the columns.

USE sakila;

DROP TABLE IF EXISTS new_payment;

SHOW TABLES;

SELECT *
FROM payment;

CREATE TEMPORARY TABLE noether_2029.new_payment AS (
	SELECT 
	payment_id, 
	customer_id,
	staff_id, 
	rental_id,
	amount,
	payment_date
	last_update
	FROM payment
);

USE noether_2029;

ALTER TABLE new_payment DROP COLUMN amount;
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
SELECT payment_id, amount * 100
FROM noether_2029.new_payment;

ALTER TABLE new_payment
MODIFY COLUMN amount INT(5) NOT NULL;


SELECT CAST(amount *100 AS UNSIGNED) AS amount
FROM new_payment;

# Find out how the current average pay in each department compares to the overall current pay for everyone at the company.

CREATE TEMPORARY TABLE noether_2029.stand_dev_functions AS (
	SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
	FROM employees.salaries
	WHERE to_date > NOW()
);

USE employees;
# Aggregate information

#############################
USE employees;

SHOW TABLES;

SELECT *
FROM employees
LIMIT 100;

SELECT *
FROM salaries
LIMIT 100;

SELECT *
FROM departments
LIMIT 100;

CREATE TEMPORARY TABLE noether_2029.salary_averages AS (
SELECT dept_name, AVG (salary) AS dept_average
FROM salaries a
JOIN dept_emp b
USING (emp_no)
JOIN departments c
USING (dept_no)
GROUP BY dept_name
);

USE noether_2029;

SELECT *
FROM salary_averages;

DROP TABLE IF EXISTS salary_averages;

ALTER TABLE noether_2029.salary_averages ADD overall_avg FLOAT(10, 2);
ALTER TABLE noether_2029.salary_averages ADD overall_std FLOAT(10, 2);
ALTER TABLE noether_2029.salary_averages ADD dept_zscore FLOAT(10, 2);

UPDATE noether_2029.salary_averages SET overall_avg = (SELECT avg_salary FROM noether_2029.stand_dev_functions);

UPDATE noether_2029.salary_averages SET overall_std = (SELECT std_salary FROM noether_2029.stand_dev_functions);

UPDATE noether_2029.salary_averages SET dept_zscore = (dept_average - overall_avg) / overall_std;

SELECT *
FROM noether_2029.salary_averages
ORDER BY dept_zscore DESC;


