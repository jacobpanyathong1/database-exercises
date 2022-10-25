USE employees;

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschosche, Zongker.

SELECT first_name, last_name
FROM employees
WHERE birth_date LIKE '%-12-25' AND hire_date LIKE '199%'
ORDER BY hire_date ASC
LIMIT 5;

-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup.

SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25' AND hire_date LIKE '199%'
ORDER BY hire_date ASC
LIMIT 50 OFFSET 50;

-- Limit will show the first # of rows for your search. OFFSET will show the # of the row you are searching for in table. i.e. limit will show your pages and offsett can skip the the page number of the book. 
