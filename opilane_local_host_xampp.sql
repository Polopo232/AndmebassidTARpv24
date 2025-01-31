CREATE TABLE opilane(
opilaneId int primary key AUTO_INCREMENT, 
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
    keelevalikID int primary key AUTO_INCREMENT, 
    valikudnimetus varchar(10) NOT NULL,
    opilaneId INT, 
    foreign key (opilaneId) references opilane(opilaneId),
    Language1 INT,
    foreign key (Language1) references Language(ID)
);
