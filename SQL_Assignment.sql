



CREATE TABLE departments (
    dept_no varchar   NOT NULL,
    dept_name varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (dept_no)
);


CREATE TABLE dept_emp (
    emp_no  int  NOT NULL,
    dept_no varchar   NOT NULL
);

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL
);

CREATE TABLE employees (
	emp_no int  NOT NULL,
	emp_title_id varchar NOT NULL,
	birth_date date NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	sex varchar NOT NULL,
	hire_date date NOT NULL,
	 CONSTRAINT "pk_employees" PRIMARY KEY (emp_no)
	);
    

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL
);


CREATE TABLE titles (
--     emp_no int   NOT NULL,
	title_id varchar NOT NULL,
    title varchar   NOT NULL
);
drop table titles;

COPY departments 
FROM '/Users/ajinkyabhonsle/Public/departments.csv' 
DELIMITER ',' CSV HEADER;
COPY dept_emp 
FROM '/Users/ajinkyabhonsle/Public/dept_emp.csv' 
DELIMITER ',' CSV HEADER;
COPY dept_manager 
FROM '/Users/ajinkyabhonsle/Public/dept_manager.csv' 
DELIMITER ',' CSV HEADER;
COPY employees 
FROM '/Users/ajinkyabhonsle/Public/employees.csv' 
DELIMITER ',' CSV HEADER;
COPY salaries 
FROM '/Users/ajinkyabhonsle/Public/salaries.csv' 
DELIMITER ',' CSV HEADER;
COPY titles 
FROM '/Users/ajinkyabhonsle/Public/titles.csv' 
DELIMITER ',' CSV HEADER;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no,e.last_name,e.first_name,e.sex, s.salary
from employees e
join salaries s
on e.emp_no = s.emp_no
-- List first name, last name, and hire date for employees who were hired in 1986.
select e.emp_no,e.first_name,e.last_name,e.hire_date
from employees e
where e.hire_date BETWEEN '1986-01-01' AND '1987-01-01'
-- List the manager of each department with the following information: department number, department name, the manager’s employee number, last name, first name.
select d.dept_no,d.dept_name, m.emp_no,e.last_name,e.first_name
from departments d
join dept_manager m
on d.dept_no = m.dept_no
join employees e
on m.emp_no = e.emp_no
-- List the department of each employee with the following information: employee number, last name, first name, and department name.
select d.emp_no,ds.dept_name,e.last_name,e.first_name
from dept_emp d
join employees e
on d.emp_no = e.emp_no
join departments ds
on ds.dept_no = d.dept_no
-- List first name, last name, and sex for employees whose first name is “Hercules” and last names begin with “B.”
select e.first_name,e.last_name,e.sex
from employees e
where first_name = 'Hercules' and last_name LIKE 'B%'
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
select d.emp_no, e.last_name,e.first_name,ds.dept_name
from employees e
join dept_emp d
on d.emp_no = e.emp_no
join departments ds
on ds.dept_no = d.dept_no
where ds.dept_name = 'Sales'
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select d.emp_no, e.last_name,e.first_name,ds.dept_name
from employees e
join dept_emp d
on d.emp_no = e.emp_no
join departments ds
on ds.dept_no = d.dept_no
where ds.dept_name = 'Sales'
OR ds.dept_name = 'Development'
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "Emp_count"
from employees
group by 1
order by count(last_name) desc
