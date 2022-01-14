
---------------------------------------------------------------------------------------------------------
-----------------------------------------DELIVERABLE 1---------------------------------------------------
---------------------------------------------------------------------------------------------------------

-- 1. Retrieve emp_no, first_name, and last name from Employees table
-- 2. Retrieve title, from_date, and to_date from Titles table
-- 3. Create a new table using INTO
-- 4. Join both tables on the primary key
-- 5. Filter date on birth_date column for yrs 1952-1955, order by employee number


--Drop Coding to use as needed
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


-- Inspect table before exporting
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
WHERE(to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Inspect table before exporting
SELECT * FROM unique_titles;

-- 16. Write a query to retrieve the number of employees by their most recent job title who are about to retire
-- 17. First, retrieve the number of titles from the unique titles table
-- 18. Then, create a Retiring Titles table to hold the required information
-- 19. Group by title, the sort the count column in descending order 


SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Inspect table before exporting
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


---------------------------------------------------------------------------------------------------------------------
---------------------------------Additional queries for written analysis---------------------------------------------
---------------------------------------------------------------------------------------------------------------------

--For analysis section
--Do mentorship employees come from the right departments and in the right proportions? Will there be enough of them to 
--be spread evenly in their departments?
-- 1. look at counts for all employees by department
-- 2. pull in departments into mentorship_eligibility and do counts
-- 3. pull counts tables together to compare
-- 4. pull into excel to do a proportionality comparison
-- 5. do 1. - 4. by title


---------------------------Departments-------------------------------------------

--Pull department info into active employees list

SELECT e.emp_no, 
		e.first_name, 
		e.last_name, 
		de.dept_no, 
		d.dept_name
INTO active_depts
FROM employees AS e
LEFT OUTER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
JOIN departments as d
	ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY d.dept_no;

--Group active by departments and count
SELECT COUNT(emp_no), dept_name
INTO active_depts_counts
FROM active_depts
GROUP BY dept_name
ORDER BY dept_name;
	 
	  
	  

--Pull department info into mentorship_eligibility 

SELECT me.emp_no, 
		me.first_name, 
		me.last_name, 
		de.dept_no, 
		d.dept_name
INTO mentorship_depts
FROM mentorship_eligibility AS me
LEFT OUTER JOIN dept_emp AS de
	ON me.emp_no = de.emp_no
JOIN departments as d
	ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
ORDER BY d.dept_no;

--Group mentorship employee departments and count
SELECT COUNT(emp_no), dept_name
INTO mentorship_depts_counts
FROM mentorship_depts
GROUP BY dept_name
ORDER BY dept_name;

--Create a new table that compares mentorship and active department counts
SELECT adc.dept_name, adc.count as active_count, mdc.count as mentorship_count
INTO mentorship_active_compare
FROM active_depts_counts as adc
JOIN mentorship_depts_counts as mdc
	ON adc.dept_name = mdc.dept_name
ORDER BY dept_name;




-----------------------------------Titles----------------------------------

--pull titles into active data
	  SELECT e.emp_no, 
		e.first_name, 
		e.last_name, 
		t.title,
		t.to_date
INTO active_titles
FROM employees AS e
LEFT OUTER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY e.emp_no;


--inspect data
SELECT * FROM active_titles;

--Group active by titles and count
SELECT COUNT(emp_no), title
INTO active_titles_counts
FROM active_titles
GROUP BY title
ORDER BY title;

--Pull title info into mentorship_eligibility 

SELECT me.emp_no, 
		me.first_name, 
		me.last_name, 
		t.title, 
		t.to_date
INTO mentorship_titles
FROM mentorship_eligibility AS me
LEFT OUTER JOIN titles AS t
	ON me.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY t.title;

--Group mentorship employee titles and count
SELECT COUNT(emp_no), title
INTO mentorship_titles_counts
FROM mentorship_titles
GROUP BY title
ORDER BY title;

--Create a new table that compares mentorship and active title counts
SELECT atc.title, atc.count as active_count, mtc.count as mentorship_count
INTO mentorship_active_titles_compare
FROM active_titles_counts as atc
JOIN mentorship_titles_counts as mtc
	ON atc.title = mtc.title
ORDER BY title;

--inspect table
SELECT * FROM mentorship_active_titles_compare;


--------------------------------------Expanded Mentorship for Summary-----------------------------------------------
-----------fun fact: the latest birthdate in the dataset is in February 1965, which is highly ----------------------
--------------------suspicious, except that we know this is a fake database. ---------------------------------------
--------------------------------------------------------------------------------------------------------------------

--Compute mentorship group for those born in 1964
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility_64
FROM employees AS e
JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1964-01-01' AND '1964-12-31')
ORDER BY e.emp_no, t.to_date DESC;

--Pull title info into mentorship_eligibility for those born in 1964 

SELECT me.emp_no, 
		me.first_name, 
		me.last_name, 
		t.title, 
		t.to_date
INTO mentorship_titles_64
FROM mentorship_eligibility_64 AS me
LEFT OUTER JOIN titles AS t
	ON me.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY t.title;

--Group mentorship employee titles and count for those born in 64
SELECT COUNT(emp_no), title
INTO mentorship_titles_counts_64
FROM mentorship_titles_64
GROUP BY title
ORDER BY title;

--Compute mentorship group for those born in 1963
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility_63
FROM employees AS e
JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (t.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1963-01-01' AND '1963-12-31')
ORDER BY e.emp_no, t.to_date DESC;

--Pull title info into mentorship_eligibility for those born in 63

SELECT me.emp_no, 
		me.first_name, 
		me.last_name, 
		t.title, 
		t.to_date
INTO mentorship_titles_63
FROM mentorship_eligibility_63 AS me
LEFT OUTER JOIN titles AS t
	ON me.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY t.title;

--Group mentorship employee titles and count for those born in 63
SELECT COUNT(emp_no), title
INTO mentorship_titles_counts_63
FROM mentorship_titles_63
GROUP BY title
ORDER BY title;