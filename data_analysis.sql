SELECT * FROM employees;

SELECT * FROM salaries;

--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s
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

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
-- using join 
SELECT d.dept_no, d.dept_name, dm.emp_no AS "Manager's_emp_no", e.last_name AS "Manager's_last_name", e.first_name AS "Manager's_first_name"
FROM departments AS d
INNER JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
INNER JOIN employees AS e
	ON dm.emp_no = e.emp_no
INNER JOIN titles AS t
	ON e.emp_title_id = t.title_id
WHERE e.emp_title_id = t.title_id;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
--using subquery




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