SHOW DATABASES;

USE employees;

SELECT count(first_name)
FROM employees
WHERE first_name IN ('Irena',  'Vidya', 'Maya');

-- There are 709 records of the first name: 'Irena', 'Vidya', 'Maya'

SELECT count(first_name)
FROM employees
WHERE first_name = 'Irene' OR first_name = 'Vidya' OR first_name ='Maya';

-- There are 731 records for the SQL search query above.
SELECT *
FROM employees
WHERE (first_name = 'Irene' OR first_name = 'Vidya' OR first_name ='Maya')
	AND gender = 'M';

-- There are 455 records for the SQL search query above. 

-- 5 is below

SELECT count(last_name)
FROM employees
WHERE last_name LIKE 'E%';

-- There are 7330 records for this SQL query table above.

SELECT count(last_name)
FROM employees
WHERE last_name Like 'E%' OR last_name LIKE '%e';

-- There are 30723 records for this SQL query table above.

SELECT count(last_name)
FROM employees
WHERE last_name Like 'E%' AND last_name LIKE '%e';

SELECT count(last_name)
FROM employees
WHERE last_name Like 'E%e'

-- There are 899 records for this SQL query table above.

SELECT count(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- There are 135214 records for the above SQL query table above.

SELECT Count(birth_date)
FROM employees
WHERE birth_date LIKE '%12-25%';

-- There are 842 records for the above SQL query table.

SELECT count(*)
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%12-25'
ORDER BY hire_date DESC;

-- There are 362 records for the above SQL query table.

SELECT count(last_name)
FROM employees
WHERE last_name LIKE '%q%';

-- There are 1873 records for the above SQL query table. 

SELECT count(last_name)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- There are 547 records for the above SQL query table. 