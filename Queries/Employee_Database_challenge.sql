
---------------------------------------------------------------------------------------------------------
-----------------------------------------DELIVERABLE 1---------------------------------------------------
---------------------------------------------------------------------------------------------------------

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
