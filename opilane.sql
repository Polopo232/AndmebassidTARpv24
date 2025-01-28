--AB loomine
Create database NikiforovBass;

use NikiforovBass;
CREATE TABLE opilane(
opilaneId int primary key identity(1, 1), 
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
adress text,
keskmine_hinne decimal(2, 1))
select * from opilane;
--andmete lisamine tabelisse
INSERT INTO opilane(
eesnimi,
perenimi,
synniaeg,
stip,
keskmine_hinne)
VALUES(
'Nikita',
'Krutoi',
'2000-12-12',
1,
4.5
),
(
'Nikita3',
'Krutoi',
'2000-12-12',
1,
4.5
),
(
'Nikita2',
'Krutoi',
'2000-12-12',
1,
4.5
),
(
'Nikita1',
'Krutoi',
'2000-12-12',
1,
4.5
)
--tabeli kasutamine
--drop table opilane


DELETE FROM opilane WHERE opilaneId=3;
select * from opilane;

--andmete uuendamine
UPDATE opilane SET adress='SantaMaria' WHERE opilaneId=1
