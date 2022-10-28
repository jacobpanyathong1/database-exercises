USE join_example_db;

####

SELECT *
FROM roles; 

SELECT *
FROM users;

####

SELECT *
FROM roles
JOIN users ON users.id = roles.id;

-- Inner Join

SELECT *
FROM roles
LEFT JOIN users ON users.id = roles.id;

-- LEFT JOIN

SELECT *
FROM roles
RIGHT JOIN users ON users.id = roles.id;

SELECT roles.name, count(role_id) AS totalcount
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

-- Search query record reflects name of roles and total count of roles. 


#####

USE employees;

SHOW TABLES;

SELECT *
FROM departments;

SELECT *
FROM dept_manager;

SELECT *
FROM employees;

SELECT *
FROM titles;

SELECT *
FROM salaries;

SELECT *
FROM dept_emp;

SELECT dept_name AS 'Department Name', concat(first_name,' ',last_name) AS 'Department Manager'
FROM departments as a
JOIN dept_manager AS b
ON b.dept_no = a.dept_no
JOIN employees AS c
ON c.emp_no = b.emp_no
WHERE to_date = '9999-01-01'
ORDER BY dept_name ASC;

-- DEPT Name and Dept Manager

SELECT dept_name AS 'Department Name', concat(first_name,' ',last_name) AS 'Department Manager'
FROM departments as a
JOIN dept_manager AS b
ON b.dept_no = a.dept_no
JOIN employees AS c
ON c.emp_no = b.emp_no
WHERE to_date = '9999-01-01' AND gender = 'F'
ORDER BY dept_name ASC;

## review
SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE()
	AND gender = 'F'
JOIN departments AS d USING (dept_no)
WHERE to_date > CURDATE()
	AND gender = 'F';

-- Dept Name, Dept Manager, Female.

SELECT title AS Title, COUNT(*) AS "Count"
FROM dept_emp AS a
JOIN titles AS b
ON a.emp_no = b.emp_no AND b.to_date
JOIN departments AS c ON c.dept_no = a.dept_no
WHERE b.to_date AND a.to_date > CURDATE()
GROUP BY title;

-- Count of employees categorized by 'title'

## review

SELECT title, COUNT(*)
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
	AND t.to_date > CURDATE()
	AND de.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no
	AND dept_name = 'Customer Service'
GROUP BY title;



SELECT dept_name AS 'Department Name', CONCAT(first_name,' ',last_name) AS full_name, salary
FROM departments as a
JOIN dept_manager AS b
ON b.dept_no = a.dept_no
JOIN employees AS c
ON c.emp_no = b.emp_no
JOIN salaries AS d
ON b.emp_no = d.emp_no
WHERE b.to_date = '9999-01-01' AND d.to_date = '9999-01-01'
ORDER BY dept_name ASC;

-- Current salaries and current Manager. 

SELECT a.dept_no, dept_name, count(*) AS num_employees
FROM dept_emp AS a
JOIN employees AS b ON a.emp_no = b.emp_no
JOIN departments AS c ON a.dept_no = c.dept_no
WHERE a.to_date > curdate()
GROUP BY dept_name
ORDER BY a.dept_no
LIMIT 10;

## review

SELECT *
FROM dept_emp AS department JOIN departments AS d ON de.dept_no
	AND de.to_date > CURDATE();

SELECT COUNT(*)
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date > CURDATE();
	
SELECT d.dept_no, d.dept_name,
	COUNT(*)
FROM dept_emp AS de
	AND de.to_date > CURDATE()
GROUP BY dept_no, dept_name;

-- Current number of employees in each department

SELECT dept_name, avg(salary) AS average_salary
FROM departments AS a
JOIN dept_emp AS b
ON a.dept_no = b.dept_no
JOIN salaries AS c
ON b.emp_no = c.emp_no
WHERE c.to_date > curdate() AND b.to_date > curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
limit 1;

-- Department with the hightest average salary

SELECT first_name, last_name
FROM departments AS a
JOIN dept_emp AS b
ON a.dept_no = b.dept_no
JOIN salaries AS c
ON b.emp_no = c.emp_no
JOIN employees AS d
ON d.emp_no = b.emp_no
WHERE c.to_date > curdate() AND b.to_date > curdate()
	AND (dept_name LIKE 'Marketing')
ORDER BY salary DESC
limit 1;

-- Highest paid employee with the marketing department
SELECT first_name, last_name, salary, dept_name
FROM departments AS a
JOIN dept_emp AS b
ON a.dept_no = b.dept_no
JOIN salaries AS c
ON b.emp_no = c.emp_no
JOIN employees AS d
ON d.emp_no = b.emp_no
JOIN dept_manager AS e
ON e.emp_no = b.emp_no
WHERE c.to_date > curdate() AND e.to_date > curdate()
	AND (dept_name LIKE 'Marketing')
ORDER BY salary DESC
limit 10;
-- Highest paid current department manager

SELECT dept_name, round(avg(salary)) AS average_salary
FROM departments AS a
JOIN dept_emp AS b
ON a.dept_no = b.dept_no
JOIN salaries AS c
ON b.emp_no = c.emp_no
GROUP BY dept_name
ORDER BY average_salary DESC
limit 10;
-- Departments with average salary

SELECT first_name, last_name, dept_name(
		SELECT b.first_name, b.last_name
		FROM dept_manager as a 
		JOIN employees as b 
		ON a.emp_no = b_emp_no 
		WHERE b.to_date > CURDATE()
) AS 'Manager_Name'
FROM employees AS a
JOIN dept_emp AS b
ON a.emp_no = b.emp_no
JOIN departments AS c
ON c.dept_no = b.dept_no
JOIN dept_manager AS d
ON d.dept_no = b.dept_no
WHERE b.to_date > curdate() AND d.to_date > CURDATE()
GROUP BY first_name, last_name, dept_name, 'Manager_Name'
limit 300;
-- current employees, department name, and current manager
