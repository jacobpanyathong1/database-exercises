USE employees;

SHOW TABLES;

SELECT last_name, CONCAT(SUBSTR(last_name, 1,1)) AS sub_str, Left(last_name, 1) 
FROM employees
limit 1;

SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name, dept_no, from_date, to_date,
IF(to_date > CURDATE(), TRUE, FALSE) AS 'is_current_employee'
FROM employees a
JOIN dept_emp b
USING (emp_no)
LIMIT 100;

-- 1. Columns to see if employees are still with the company.

SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name, dept_no, from_date, to_date,
CASE
	WHEN LEFT(last_name, 1) IN ('A','B','C','D','E','F','G','H') THEN 'A-H'
	WHEN LEFT(last_name, 1) IN ('I','J','K','L','M','N','O','P') THEN 'I-P'
	WHEN LEFT(last_name, 1) IN ('Q','R','S','T','U','V','W','X','Y','Z') THEN 'Q-Z'
	ELSE 'NOT OKAY' 
END AS alpha_group
FROM employees a
JOIN dept_emp b
USING (emp_no)
LIMIT 100;

-- returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT min(birth_date), max(birth_date) FROM employees;

-- Birth year min and max

SELECT CONCAT(first_name,' ', last_name) AS full_name, LEFT(birth_date, 4) AS birth_year_decade,
CASE
	WHEN birth_date >= '1960-01-01' THEN '60s'
	WHEN birth_date >= '1950-01-01' THEN '50s'
END AS 'decade'
FROM employees
GROUP BY full_name, birth_year_decade, decade
LIMIT 100;

-- Current or previous employees with decade column.


SELECT
	CASE
		WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
		WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS 'New_dept_name', round(avg(salary)) AS avg_salary
FROM departments
JOIN dept_emp a
USING (dept_no)
JOIN salaries b
USING (emp_no)
WHERE a.to_date > CURDATE()
	AND b.to_date > CURDATE()
GROUP BY new_dept_name
ORDER BY avg_salary DESC;

-- Current average salary for each of the department groups