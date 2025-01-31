--AB loomine
Create database NikiforovBaas;

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
VALUES
('Nikita','Krutoi','2000-12-12',1,4.5),
('Nikita3','Krutoi','2000-12-12',1,4.5),
('Nikita2','Krutoi','2000-12-12',1,4.5),
('Nikita1','Krutoi', '2000-12-12',1,4.5)
--tabeli kasutamine
drop table opilane


DELETE FROM opilane WHERE opilaneId=5;
select * from opilane;

--andmete uuendamine
UPDATE opilane SET adress='SantaMaria' WHERE opilaneId=1

CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);

select * from Language;

INSERT INTO Language (ID, Code, Language)
VALUES
(2, 'RUS', 'vene'),
(3, 'ENG', 'English'),
(4, 'DE', 'saksa')

CREATE TABLE keelevalik (
    keelevalikID int IDENTITY(1,1) primary key, 
    valikudnimetus varchar(10) NOT NULL,
    opilaneId INT, 
    foreign key (opilaneId) references opilane(opilaneId),
    Language1 INT,
    foreign key (Language1) references Language(ID)
);


select * from keelevalik
select * from Language
select * from opilane

INSERT INTO keelevalik (valikudnimetus, opilaneId, Language1)
VALUES
('valik B', 1, 2),
('valik A', 2, 4),
('valik C', 4, 4),
('valik D', 5, 3),
('valik E', 7, 2),
('valik F', 8, 4)

SELECT opilane.eesnimi
FROM opilane, keelevalik
WHERE opilane.opilaneId=keelevalik.opilaneId
AND Language1 = keelevalik.Language1
AND Language1 = keelevalik.Language1

SELECT *
FROM opilane, Language keelevalik
WHERE opilane.opilaneId=keelevalik.opilaneId
AND Language.ID = keelevalik.Language

CREATE TABLE oppimine (
    oppimineNum INT PRIMARY KEY IDENTITY(1,1),
    aine VARCHAR(10) NOT NULL,
    aasta INT,
    opetaja VARCHAR(25),
    opilaneID INT,
    hinne DECIMAL(2,1)
);

select * from oppimine
