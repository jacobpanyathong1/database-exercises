-- What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
USE employees; 

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- Top: 'Irena Acton' Bottom: Vidya Zweizig

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Top: 'Irena Acton' Bottom: Maya Zyda

SELECT emp_no, first_name, last_name
FROM employees 
WHERE last_name LIKE 'E%e'
ORDER BY emp_no;

/* 899 records 
	1. emp_#: 10021 name(First, Last): Ramzi, Erde 
	2. emp_#: 499648 name(First, Last): Tadahiro Erde */

SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'E%e'
ORDER BY hire_date DESC;

/* 899 records 
	1. emp_#: 67892 name(First, Last): Teiji, Eldridge 
	2. emp_#: 233488 name(First, Last): Sergi Erde */

SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25' and hire_date LIKE '199%'
ORDER BY birth_date ASC, hire_date DESC;
/* 362 records
	1. Khun Bernini
	2. Douadi Pettis
*/ 

-- This is where functions exercise begins.


USE employees;

SELECT CONCAT(SUBSTR(first_name, 1, 50), SUBSTR(last_name, 1, 50)) AS full_name
FROM employees
WHERE last_name LIKE 'E%e';

-- CONCAT full_name

SELECT UPPER(CONCAT(SUBSTR(first_name, 1, 50), SUBSTR(last_name, 1, 50))) AS full_name
FROM employees
WHERE last_name LIKE 'E%e';

-- ALL UPPERCASE

SELECT *, datediff(now(), hire_date) AS days_currently_employed
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND (birth_date LIKE '%-12-25')
ORDER BY days_currently_employed DESC;

-- Days employed with birth_date DEC 25th and hire_date in the 1990s.

USE employees;

SHOW TABLES;

Select MIN(salary) AS lowest, MAX(salary) AS highest
FROM salaries;

-- Lowest and Highest salaries

SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), '_', SUBSTR(birth_date, 6, 2), substr(birth_date, 3, 2)) AS user_name, first_name, last_name, birth_date
FROM employees;


