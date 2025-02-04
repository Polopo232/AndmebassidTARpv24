--SQL SERVER

CREATE TABLE opilane(
opilaneId int primary key identity(1,1), 
eesnimi varchar(25) not null,
perenimi varchar(25) not null,
synniaeg date,
stip bit,
adress text,
keskmine_hinne decimal(2, 1));

INSERT INTO opilane(
eesnimi,
perenimi,	
synniaeg,
stip,
keskmine_hinne)
VALUES
('Donald','Trump','2000-12-12',1,4.5),
('Walter','White','2000-07-22',1,4.5),
('Peter','Grifiin','2000-05-02',1,4.5),
('Michle','Jakson', '2000-06-12',1,4.5),
('Ivan','Rudskoi','2000-06-23',1,4.5)

--tabeli kasutamine
drop table opilane

DELETE FROM opilane WHERE opilaneId=5;

UPDATE opilane SET adress='SantaMaria' WHERE opilaneId=1

CREATE TABLE Language
(
ID int NOT NULL PRIMARY KEY,
Code char(3) NOT NULL,
Language varchar(50) NOT NULL,
IsOfficial bit,
Percentage smallint
);

INSERT INTO Language (ID, Code, Language)
VALUES
(1, 'RUS', 'vene'),
(2, 'ENG', 'English'),
(3, 'DE', 'saksa')

CREATE TABLE keelevalik (
    keelevalikID int primary key identity(1,1), 
    valikudnimetus varchar(10) NOT NULL,
    opilaneId INT, 
    foreign key (opilaneId) references opilane(opilaneId),
    Language1 INT,
    foreign key (Language1) references Language(ID)
);

INSERT INTO keelevalik (valikudnimetus, opilaneId, Language1)
VALUES
('A', 1, 2),
('B', 2, 3),
('C', 3, 1)


CREATE PROCEDURE lisaOpilane
@Onimi varchar(30)
,@Opernimi varchar(30)
,@sunni date
,@stip bit
,@adress text
,@kesk decimal(2,1)
AS
BEGIN
INSERT INTO opilane(eesnimi,perenimi,synniaeg,stip,adress,keskmine_hinne)
VALUES (@Onimi, @Opernimi, @sunni, @stip, @adress, @kesk)
SELECT * FROM opilane;
END;

EXEC lisaOpilane 'Artjom', 'Põldsaar', '2004-05-14', 0, 'Home 12', 4

CREATE PROCEDURE kustutaOpilane
@deleteID int
AS
BEGIN
SELECT * FROM opilane;
DELETE FROM opilane WHERE opilaneId=@deleteID;
SELECT * FROM opilane;
END

EXEC kustutaOpilane 4;

CREATE PROCEDURE OpilaneOts

@ots CHAR(1)
AS;
BEGIN;
SELECT * FROM opilane
WHERE eesnimi LIKE @ots + '%';
END;

EXEC  OpilaneOts w;

CREATE PROCEDURE OpilaneUpdate
@opID int
,@stip bit
AS
BEGIN
SELECT * FROM opilane;
UPDATE opilane SET stip=@stip
WHERE opilaneId=@opID;
SELECT * FROM opilane;
END;

EXEC OpilaneUpdate 6, 1

select * from opilane
select * from Language
select * from keelevalik

--
