-- 3.1
use the_warehouse;
select * from Warehouses;

-- 3.2
select * from Boxes where Value > 150;

-- 3.3
select distinct Contents from Boxes;

-- 3.4
select avg(Value) from Boxes;

-- 3.5
select Warehouse, avg(Value) from Boxes group by Warehouse;

-- 3.6
select Warehouse, avg(Value) from Boxes group by Warehouse having avg(Value) > 150;

-- 3.7
select b.Code, w.Location
from Boxes b
join Warehouses w on b.Warehouse = w.Code;

-- 3.8
select w.Code, coalesce(count(b.Code), 0) as BoxCount
from Warehouses w
left join Boxes b on w.Code = b.Warehouse
group by w.Code;

-- 3.9
select Code from Warehouses where (select count(*) from Boxes where Warehouse = Code) > Capacity;

-- 3.10
select Code from Warehouses where Location = 'Chicago';

-- 3.11
insert into Warehouses (Code, Location, Capacity) values (6, 'New York', 3);

-- 3.12
insert into Boxes (Code, Contents, Value, Warehouse) values ('H5RT', 'Papers', 200, 2);

-- 3.13
update Boxes set Value = Value * 0.85;

-- 3.14
delete from Boxes where Value < 100;

-- 3.15
delete from Boxes where Warehouse in (select Code from Warehouses where (select count(*) from Boxes where Warehouse = Code) > Capacity);

-- 3.16
alter table Boxes add index (Warehouse);

-- 3.17
show index from Boxes;

-- 3.18
alter table Boxes drop index Warehouse;
