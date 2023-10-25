create database employees_management;
-- 2.1 Select the last name of all employees.
use employees_management;
select lastname from employees;
-- 2.2 Select the last name of all employees, without duplicates.
select distinct lastname from employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
select * from employees where lastname="smith";

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from employees where lastname= "smith" or lastname= "doe";

-- 2.5 Select all the data of employees that work in department 14.

select * from employees where department =14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from employees where department =37 or department=77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
select * from employees where lastname like "s%";

-- 2.8 Select the sum of all the departments' budgets.
select sum(budget) from departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select count(*),department from employees group by department;

-- 2.10 Select all the data of employees, including each employee's department's data.
select * from employees,departments where employees.department=departments.code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select e.name,e.lastname,d.name,d.budget from employees e cross join departments d on e.department=d.code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select e.name,e.lastname,d.name,d.budget from employees e cross join departments d on e.department=d.code where budget>"60,000";

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select * from  departments where budget>(select avg(budget) from departments);

-- 2.14 Select the names of departments with more than two employees.
select name from departments where code in (select department from employees group  by department having count(department)>2);

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
select name,lastname from employees where department having (select budget from departments limit 2,1);


-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
insert into  departments (code,name,budget)
values ('11','Quality Assurance', 40000);


-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.

insert into  employees (ssn,name,lastname,department)
values ('847219811','mary','moore','11');

-- 2.17 Reduce the budget of all departments by 10%.
update departments set budget=budget*0.90;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update departments set code='77' where code='14';

-- 2.19 Delete from the table all employees in the IT department (code 14).
delete e.*,d.* from employees e inner join departments d on e.department=d.code where d.name='IT';
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

-- 2.21 Delete from the table all employees.