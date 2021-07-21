-- DELIVERABLE 1
-- Number of retiring employees by title
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
-- INNER JOIN departments AS d
-- ON (de.dept_no = d.dept_no )
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (e.emp_no) e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO unique_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
-- INNER JOIN departments AS d
-- ON (de.dept_no = d.dept_no )
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC, t.to_date DESC;

-- retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title 
ORDER BY COUNT DESC;


-- DELIVERABLE 2
-- create a mentorship-eligibility table that holds the current employees
-- who were born between January 1, 1965 and December 31, 1965
SELECT DISTINCT ON (t.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no )
WHERE de.to_date = '9999-01-01' AND e.birth_date >= '1965-01-01' AND e.birth_date <= '1965-12-31'
ORDER BY t.emp_no;