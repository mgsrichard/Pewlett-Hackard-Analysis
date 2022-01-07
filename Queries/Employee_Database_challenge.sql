-- 1. Retrieve emp_no, first_name, and last name from Employees table
-- 2. Retrieve title, from_date, and to_date from Titles table
-- 3. Create a new table using INTO
-- 4. Join both tables on the primary key
-- 5. Filter date on birth_date column for yrs 1952-1955

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO ret_elig_by_title
FROM employees as e
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;


-- 1. Retrieve emp_no, first_name, and last name from Employees table
-- 2. Retrieve title, from_date, and to_date from Titles table
-- 3. Create a new table using INTO
-- 4. Join both tables on the primary key
-- 5. Filter date on birth_date column for yrs 1952-1955

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO ret_elig_by_title
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

DROP TABLE ret_elig_by_title;

SELECT * FROM ret_elig_by_title;

SELECT * FROM titles;-- 1. Retrieve emp_no, first_name, and last name from Employees table
-- 2. Retrieve title, from_date, and to_date from Titles table
-- 3. Create a new table using INTO
-- 4. Join both tables on the primary key
-- 5. Filter date on birth_date column for yrs 1952-1955

SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO ret_elig_by_title
FROM employees as e
JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT COUNT(r.emp_no) 
FROM ret_elig_by_title AS r
JOIN employees as e
	ON r.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (r.to_date = '9999-01-01');



DROP TABLE ret_elig_by_title;

SELECT * FROM ret_elig_by_title;

SELECT COUNT(emp_no) FROM titles;

-- 9.  Retrieve the employee number, first and last name, and title columns 
--     from the Retirement Titles Table - ret_elig_by_title
-- 10. Use Dictinct with Orderby to remove duplicate rows and retrieve the first occurence of 
--     the employee number for each set of rows defined by the ON() clause
-- 11. Exclude those employees that have already left the company by filtering on to_date
--     to keep only those dates that are equal to '9999-01-01'
-- 12. Create a Unique Titles table using the INTO clause

SELECT DISTINCT ON (emp_no) emp_no,
			first_name,
			last_name,
			title
INTO unique_titles
FROM ret_elig_by_title 
WHERE to_date = '9999-01-01'
ORDER BY emp_no, last_name DESC;

SELECT COUNT(emp_no) FROM unique_titles;

DROP TABLE unique_titles;

-- 16. Write a query to retrieve the number of employees by their most recent job title who are about to retire
-- 17. First, retrieve the number of titles from the unique titles table
-- 18. Then, create a Retiring Titles table to hold the required information
-- 19. Group by title, the sort the count column in descending order 

SELECT COUNT(emp_no), title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT COUNT(emp_no) FROM retirement_info;

SELECT COUNT(emp_no), title
--INTO retiring_titles
FROM ret_elig_by_title
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

DROP TABLE unique_titles;
SELECT COUNT(emp_no) FROM unique_titles;
SELECT * FROM unique_titles;

--------------------------trying to figure out 72458 bs 90368 mismatch on data-----------------------

DROP TABLE retirement_titles;
DROP TABLE unique_titles;
DROP TABLE test;

SELECT e.emp_no, 
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date >= '1952-01-01' AND e.birth_date <= '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;
SELECT COUNT (emp_no) FROM retirement_titles_clean;
SELECT COUNT (emp_no) FROM unique_titles;


SELECT DISTINCT ON(emp_no) emp_no,
		first_name,
		last_name,
		title,
		to_date
INTO unique_titles
FROM retirement_titles
--WHERE(to_date = '9999-01-01')
ORDER BY emp_no;




SELECT COUNT(emp_no), title
--INTO retiring_titles
FROM unique_titles
--WHERE(to_date = '9999-01-01')
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT * FROM retirement_titles;

SELECT emp_no, title, from_date, to_date
INTO titles_clean
FROM titles 
WHERE to_date = '9999-01-01';

SELECT e.emp_no, 
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles_clean
FROM employees AS e
JOIN titles_clean as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date >= '1952-01-01' AND e.birth_date <= '1955-12-31')
ORDER BY e.emp_no;

---------------------------------------------------------------------------------------------------------
-----CORRECT CODING FOR DELIVERABLE 1 - SO IT MATCHES PICTURE IN MODULE--------------------------------
---------BUT IT IS BEFORE TAKING OUT ALL WHOSE TO_DATE = 9999-01-01----------------------------------------
-------------------------------------------------------------------------------------------------------

-- 1. Retrieve emp_no, first_name, and last name from Employees table
-- 2. Retrieve title, from_date, and to_date from Titles table
-- 3. Create a new table using INTO
-- 4. Join both tables on the primary key
-- 5. Filter date on birth_date column for yrs 1952-1955, order by employee number


--DROP Coding to use as needed
--DROP TABLE retirement_titles;
--DROP TABLE unique_titles_90;
--DROP TABLE retiring_titles;

SELECT e.emp_no, 
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date >= '1952-01-01' AND e.birth_date <= '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- 9.  Retrieve the employee number, first and last name, and title columns 
--     from the Retirement Titles Table
-- 10. Use Distinct ON with Orderby to remove duplicate rows and retrieve the first occurence of 
--     the employee number for each set of rows defined by the ON() clause
-- 11. Exclude those employees that have already left the company by filtering on to_date
--     to keep only those dates that are equal to '9999-01-01'
-- 12. Create a Unique Titles table using the INTO clause
-- 13. Order the table ascending by employee number and descending by the to_date to control which record DISTINCT keeps

SELECT DISTINCT ON(emp_no) emp_no,
		first_name,
		last_name,
		title,
		to_date
INTO unique_titles
FROM retirement_titles
--WHERE(to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- 16. Write a query to retrieve the number of employees by their most recent job title who are about to retire
-- 17. First, retrieve the number of titles from the unique titles table
-- 18. Then, create a Retiring Titles table to hold the required information
-- 19. Group by title, the sort the count column in descending order 


SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
--WHERE(to_date = '9999-01-01')
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT * FROM retiring_titles;


-------------------------------------------- Deliverable 2---------------------------------------------------------------
-- 1. Retrieve the emp_no, first_name, last_name, and birth_date from the employees table
-- 2. Retrieve the from_date and the to_date columns from the department employee table
-- 3. Retrieve the title from the titles table
-- 4. Use a Distinct on() statement to retrieve the first occurence of the employee number
--    for each set of rows defined by the on() clause
-- 5. Create a new table, mentorship_eligibility, using the INTO clause
-- 6. Join the employees and the department employee tables on the primary key
-- 7. Join the employees and titles tables on the primary key
-- 8. Filter the data on to_date = 9999-01-01 to get current employees, and filter birth_date
--    between 1965-01-01 and 1965-12-31
-- 9. Order the table by employee number ascending and to_date descending (to control which row is chosen when there are duplicates)

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, t.to_date DESC;


