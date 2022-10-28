SHOW databases;

USE employees;

SHOW TABLES;


SELECT a.first_name, a.last_name, a.hire_date
FROM (
		SELECT *
		FROM employees
		WHERE hire_date = '1990-10-22') AS a
		;
		
-- employees with same hire date as emp_no 101010


SELECT c.title AS Title, a.emp_no AS 'Employee Number', CONCAT(a.first_name,' ', a.last_name) AS 'Full Name'
FROM (
		SELECT *
		FROM employees
		WHERE first_name LIKE '%Aamod'
) AS a
JOIN dept_emp AS b ON b.emp_no = a.emp_no
JOIN titles AS c ON c.emp_no = a.emp_no AND c.to_date > CURDATE()
;
-- employees named 'Aamod' currently employed with Titles.

SELECT /*a.first_name, a.last_name, b.to_date, */ COUNT(*)
FROM (
		SELECT *
		FROM employees
		
) AS a
JOIN dept_emp AS b ON b.emp_no = a.emp_no AND b.to_date NOT LIKE '%9999%'
JOIN titles AS c ON c.emp_no = a.emp_no;

-- total count of employees who resigned/left employer.
SELECT *
FROM (SELECT emp_no, dept_no
		FROM dept_manager
		WHERE to_date > CURDATE()
) AS a
JOIN employees AS b ON a.emp_no = b.emp_no
JOIN departments as c ON a.dept_no = c.dept_no 
WHERE gender = 'F'
LIMIT 10;

-- Current Female department Managers
SELECT *
FROM titles;