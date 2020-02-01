--DATA ENGINEERING: CREATE TABLE SCHEMAS
CREATE TABLE employees(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date DATE,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	gender VARCHAR(10),
	hire_date DATE
);

CREATE TABLE departments(
	dept_no VARCHAR(50) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50)
);

CREATE TABLE dept_emp(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(50),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date DATE,
	to_date DATE
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(50),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date DATE,
	to_date DATE
);

CREATE TABLE salaries(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT,
	from_date DATE,
	to_date DATE
);

CREATE TABLE titles(
	emp_no INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(255),
	from_date DATE,
	to_date DATE
);

---------------------------------------------------------
--QUERIES--
---------------------------------------------------------
--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01';

--3. List the manager of each department with the following information: department number, department name, 
--   the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date 
FROM dept_manager as dm
	LEFT JOIN departments as d
	ON dm.dept_no = d.dept_no
	LEFT JOIN employees as e
	ON dm.emp_no = e.emp_no;

--4. List the department of each employee with the following information: employee number, last name, first name, 
--  and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de
	LEFT JOIN departments AS d
	ON de.dept_no = d.dept_no 
	LEFT JOIN employees AS e
	ON de.emp_no = e.emp_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, 
--   last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name  
FROM dept_emp as de
	LEFT JOIN departments as d 
	ON de.dept_no = d.dept_no
	LEFT JOIN employees as e
	ON de.emp_no = e.emp_no
	where d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their 
--   employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name  
FROM dept_emp as de
	LEFT JOIN departments as d 
	ON de.dept_no = d.dept_no
	LEFT JOIN employees as e
	ON de.emp_no = e.emp_no
	where d.dept_name = 'Sales' or d.dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, 
--   i.e., how many employees share each last name.
SELECT e.last_name, COUNT(e.last_name) AS "Count of Last Name"
FROM employees AS e
GROUP BY last_name
ORDER BY "Count of Last Name" DESC;




	





	
	
