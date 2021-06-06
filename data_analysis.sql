SELECT COUNT(*) FROM employees;

SELECT * FROM salaries;

SELECT * FROM dept_emp;

SELECT * FROM departments;

SELECT * FROM titles;

SELECT * FROM dept_manager;


--Querying the following details of each employee: 
--employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no;

-----------------------------------------------------------------------------

--List first name, last name, and hire date for 
--employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--WHERE hire_date >= '1986-01-01' 
--AND hire_date <= '1986-12-31';

----------------------------------------------------------------------------------------

SELECT * FROM titles
WHERE title = 'Manager';

SELECT * FROM employees
WHERE emp_title_id = 'm0001';

SELECT * FROM dept_manager;

-- List the manager of each department with the following information: department number, 
--department name, the manager's employee number,last name, first name.

-- Solution 1: using join 

SELECT d.dept_no, d.dept_name, dm.emp_no AS "Managers_emp_no", e.last_name AS "Managers_last_name", e.first_name AS "Managers_first_name", e.emp_title_id
FROM departments AS d
INNER JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
INNER JOIN employees AS e
	ON dm.emp_no = e.emp_no
INNER JOIN titles AS t
	ON e.emp_title_id = t.title_id
WHERE t.title = 'Manager';

--Solution 2:

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.

--First using subquery to retrieve department number, 
--department name, the manager's employee number

SELECT d.dept_no, d.dept_name, dm.emp_no
FROM departments AS d
INNER JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
	WHERE dm.emp_no In (SELECT e.emp_no
						FROM employees As e
						JOIN titles AS t
							ON e.emp_title_id = t.title_id
						WHERE t.title = 'Manager');

-- Creating View of subquery
DROP VIEW managers_dept_no;
CREATE VIEW managers_dept_no AS
SELECT d.dept_no, d.dept_name, dm.emp_no
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
WHERE dm.emp_no In (SELECT e.emp_no
						FROM employees As e
						JOIN titles AS t
							ON e.emp_title_id = t.title_id
					WHERE t.title = 'Manager');


--Query all from view
SELECT * FROM managers_dept_no;


-- Now joining 'employees' table and 'managers_dept_no' view table to list the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.

SELECT e.emp_no, e.first_name, e.last_name, e.emp_title_id, md.dept_no, md.dept_name
FROM employees AS e
LEFT JOIN managers_dept_no AS md
	ON md.emp_no = e.emp_no
WHERE md.emp_no = e.emp_no;
	
---------------------------------------------------------------------------------------------------------------------------------

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

--Solution 1:
--using join on three tables

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT count(*) FROM dept_emp;

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS dp
	ON e.emp_no = dp.emp_no
LEFT JOIN departments AS d
	ON d.dept_no = dp.dept_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

--Solution 2:

--using view

--writing query to create for view
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no
FROM employees AS e
INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
WHERE e.emp_no IN (
		SELECT de.emp_no 
		FROM dept_emp AS de);
		
-- creating view
DROP VIEW employees_dept;
CREATE VIEW employees_dept AS
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no
FROM employees AS e
INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
WHERE e.emp_no IN (
		SELECT de.emp_no 
		FROM dept_emp AS de);
		
--querying view
SELECT * FROM employees_dept;

--Now joining 'departments' table and view

SELECT ed.emp_no, ed.last_name, ed.first_name, d.dept_name
FROM employees_dept AS ed
LEFT JOIN departments AS d
	ON d.dept_no = ed.dept_no;


-----------------------------------------------------------------------------------------------------------------------------------------


--List first name, last name, and sex for employees 
--whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name like 'B%';

---------------------------------------------------------------------------------------------------------------------------------

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

SELECT COUNT(*) FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT COUNT(*) FROM dept_emp;

-- querying the dept_no of 'Sales' dept.

SELECT dept_no
FROM departments
WHERE dept_name = 'Sales';

--Solution 1

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name, d.dept_no
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.dept_no IN (
		SELECT de.dept_no
		FROM dept_emp AS de
		JOIN departments AS d
			ON d.dept_no = de.dept_no
		WHERE d.dept_name = 'Sales')
ORDER BY e.last_name;

--Solution 2

--querying by creating view
DROP VIEW sales_emp;
CREATE VIEW sales_emp AS
SELECT de.emp_no, de.dept_no, d.dept_name
FROM dept_emp AS de
RIGHT JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

--querying view

SELECT * FROM sales_emp;

-- now joining employees table and sales_emp view

SELECT e.emp_no, e.last_name, e.first_name, se.dept_name, se.dept_no
FROM employees AS e
LEFT JOIN sales_emp AS se
	ON se.emp_no = e.emp_no   
WHERE se.emp_no = e.emp_no
ORDER BY e.last_name;

-----------------------------------------------------------------------------------------------------------------------------------

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.

SELECT * FROM departments;

-- querying the dept_no of 'Development' dept.

SELECT dept_no
FROM departments
WHERE dept_name = 'Development';


SELECT e.emp_no, e.last_name, e.first_name, d.dept_name, d.dept_no
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE de.dept_no IN (
		SELECT de.dept_no
		FROM dept_emp AS de
		JOIN departments AS d
			ON d.dept_no = de.dept_no
		WHERE d.dept_name = 'Sales'
		OR d.dept_name = 'Development')
ORDER BY e.last_name;

----------------------------------------------------------------------------------------------------------------------------------

--In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name.

SELECT last_name, count(last_name) AS freq_count_last_name
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;

-----------------------------------------------------------------------------------------------------------------------------
--BONUS: Average salary by title

DROP VIEW average_salaries;
CREATE VIEW average_salaries AS
SELECT ROUND(AVG(s.salary)) As avg_salaries, t.title
FROM salaries AS s
LEFT JOIN employees AS e
	ON e.emp_no = s.emp_no
LEFT JOIN titles AS t
	ON  e.emp_title_id = t.title_id 
GROUP BY t.title;

--querying data from view

SELECT * FROM average_salaries;
