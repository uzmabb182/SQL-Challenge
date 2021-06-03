SELECT COUNT(*) FROM employees;

SELECT * FROM salaries;

SELECT * FROM dept_emp;

SELECT * FROM departments;

SELECT * FROM titles;

SELECT * FROM dept_manager;


--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE e.emp_no = s.emp_no;


--List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--WHERE hire_date >= '1986-01-01' 
--AND hire_date <= '1986-12-31';


SELECT * FROM titles
WHERE title = 'Manager';

SELECT * FROM employees
WHERE emp_title_id = 'm0001';

SELECT * FROM dept_manager;

-- List the manager of each department with the following information: department number, 
--department name, the manager's employee number,last name, first name.
-- using join 

SELECT d.dept_no, d.dept_name, dm.emp_no AS "Managers_emp_no", e.last_name AS "Managers_last_name", e.first_name AS "Managers_first_name", e.emp_title_id
FROM departments AS d
INNER JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
INNER JOIN employees AS e
	ON dm.emp_no = e.emp_no
INNER JOIN titles AS t
	ON e.emp_title_id = t.title_id
WHERE t.title = 'Manager';

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
--using subquery

SELECT d.dept_no, d.dept_name, dm.emp_no
FROM departments AS d
INNER JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
	WHERE dm.emp_no In (SELECT e.emp_no
						FROM employees As e
						JOIN titles AS t
							ON e.emp_title_id = t.title_id
						WHERE t.title = 'Manager');


-- Create View
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

--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name.
-- Now joining 'employees' table and 'managers_dept_no' view table to list the manager of each department.

SELECT e.emp_no, e.first_name, e.last_name, e.emp_title_id, md.dept_no, md.dept_name
FROM employees AS e
INNER JOIN managers_dept_no AS md
	ON md.emp_no = e.emp_no
WHERE md.emp_no = e.emp_no;
	


--List the department of each employee with the following information: employee number, last name, first name, and department name.
--using join
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS demp
	ON demp.emp_no = e.emp_no
INNER JOIN departments AS d
	ON demp.dept_no = d.dept_no
WHERE e.emp_no = demp.emp_no;




--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.