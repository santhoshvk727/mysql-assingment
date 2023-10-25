create database research;
use research;

-- 6.1
select s.Name as ScientistName, p.Name as ProjectName, p.Hours
from Scientists s
join AssignedTo a on s.SSN = a.Scientist
join Projects p on a.Project = p.Code
order by ProjectName, ScientistName;

-- 6.2
select Name
from Projects
where Code not in (select Project from AssignedTo);
