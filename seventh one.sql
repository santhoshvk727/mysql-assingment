-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
    
select p.id, p.name, max(a.address) as address
from people as p
left join address as a on p.id = a.id
group by p.id, p.name;


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE
    
select p.id, p.name, a.address
from people as p
left join (
    select id, max(updatedate) as max_date
    from address
    group by id
) as latest_date on p.id = latest_date.id
left join address as a on p.id = a.id and latest_date.max_date = a.updatedate;
