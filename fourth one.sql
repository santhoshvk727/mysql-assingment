-- 5.1
select Name from Pieces;

-- 5.2
select * from Providers;

-- 5.3
select Piece, avg(Price) from Provides group by Piece;

-- 5.4
select p.Name
from Pieces p
join Provides pr on p.Code = pr.Piece
where pr.Provider = 'HAL';

-- 5.5
select p.Name
from Pieces p
join Provides pr on p.Code = pr.Piece
where pr.Provider = 'HAL';

-- 5.6
select p.Name as PieceName, pr.Name as ProviderName, max(pr.Price) as Price
from Provides pr
join Pieces p on pr.Piece = p.Code
where (pr.Piece, pr.Price) in (select Piece, max(Price) from Provides group by Piece);

-- 5.7
insert into Provides (Piece, Provider, Price) values (1, 'TNBC', 7);

-- 5.8
update Provides set Price = Price + 1;

-- 5.9
delete from Provides where Provider = 'RBT' and Piece = 4;

-- 5.10
update Provides set Piece = null where Provider = 'RBT';
