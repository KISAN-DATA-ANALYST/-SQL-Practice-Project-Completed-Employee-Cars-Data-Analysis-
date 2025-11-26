
-- # ✅ **BASIC SQL QUESTIONS**

-- 1. Show all employees
select*from employee;
-- 2. Show only name and salary
select name, salary from employee;
-- 3. Count how many employees are in each department
select dept, count(*) from employee
group by dept;
-- 4. Find the employee with the highest salary
select*from employee
order by salary desc
limit 1;
-- 5. Count employees in the IT department
select count(*) from employee
where dept='IT';

-- # 🎯 **INTERMEDIATE SQL QUESTIONS**

-- 6. Find average salary per department
select dept, avg(salary) from employee
group by dept;
-- 7. Find minimum salary per department
select dept, min(salary) from employee
group by dept;
-- 8. Show employees with salary > 5000
select*from employee
where salary>5000;
-- 9. Show employees whose name starts with 'A'
select* from employee
where name like 'A%';
-- 10. Find highest salary employee in each department (using window function)
-- select dept, max(salary) from employee
-- group by dept;
select*from(
			select*,row_number() over(partition by dept order by salary) as rn
			from employee
			)x
where rn =1;
-- # ⚡ **ADVANCED SQL QUESTIONS**

-- 11. Show salary rank within each department
select*,
		rank() over(partition by dept order by salary desc) as salary_rank
from employee;
-- 12. Show total salary and running total inside each department
select*,
		sum(salary) over(partition by dept) as dept_salary,
		sum(salary) over(partition by dept order by salary desc) as running_salary
from employee;
-- 13. Show highest & lowest salary in each department
select*,
		max(salary) over(partition by dept) as highest_salary,
		min(salary) over(partition by dept) as lowest_salary
from employee;
-- 14. Which department spends the most salary?
select dept, sum(salary) as total_salary
from employee
group by dept
order by total_salary
limit 1;
-- ---

-- # 🔥 **SUBQUERY / CTE QUESTIONS**

-- 15. Show employees whose salary is greater than their department average
select*from employee e
where salary > (select avg(salary) from employee
				where dept = e.dept
				);
-- 16. Find the 2nd highest salary
select salary from employee
order by salary desc
offset 1 limit 1;
-- 17. Find the 2nd highest salary employee per department
select* from(
			select*,dense_rank() over(partition by dept order by salary desc) as rnk
			from employee
			)x
			where rnk=2;
-- # 🎓 **INTERVIEW-FOCUSED QUESTIONS**

-- 18. Highest salary employee in IT department
select*from employee
where dept='IT'
order by salary desc
limit 1;
-- 19. Increase salary of all employees by 10%
update employee
set salary=salary*1.10;
select * from employee;
-- 20. Increase salary of IT department employees by 1000
update employee
set salary=salary+1000
where dept='IT';
select * from employee;
-- 21. Classify employees as Low / Medium / High based on salary
select*,
case
	when salary < 3000 then 'Low'
	when salary between 3000 and 6000 then 'Medium'
	else 'High'
end as salary_level
from employee;
-- # 🧠 **ANALYTICAL / WINDOW FUNCTION QUESTIONS**

-- 22. Calculate salary percentile within each department
select*,
		percent_rank() over(partition by dept order by salary) as pct
from employee;
-- 23. Show cumulative count of employees per department
select*,
		count(*) over(partition by dept order by salary) as running_salary
from employee;
-- 24. Show difference between employee salary and highest salary in their department
select*,
		max(salary) over(partition by dept) - salary as diff_from_top
from employee;
-- # 🚀 **PRO-LEVEL QUESTIONS**

-- 25. Average salary excluding the highest salary
select avg(salary) from employee
where salary < (select max(salary) from employee);
-- 26. Find duplicate employee names
select name, count(*) from employee
group by name
having count(*)>1;
-- 27. Calculate department-wise salary standard deviation
select dept, stddev(salary)
from employee
group by dept;
-- 28. Assign alphabetical row number to employees
select*,
		row_number() over(order by name) as alphabetical_serial
from employee;