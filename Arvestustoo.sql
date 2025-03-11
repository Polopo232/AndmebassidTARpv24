CREATE DATABASE Arvestustoo

USE Arvestustoo

CREATE TABLE Autorid(
Autori_ID int primary key identity(1,1)
,Eesnimi VARCHAR(150)
,Perekonnanimi VARCHAR(150)
,Sünniaasta DATE
,Sünnikoht VARCHAR(100)
,Rahvust VARCHAR(150)
,Elukoht VARCHAR(150)
,CV varchar(200)
,Portree VARCHAR(200)
,Kodulehekülg VARCHAR (200))

INSERT INTO Autorid(Eesnimi,Perekonnanimi,Sünniaasta,Sünnikoht,Rahvust,Elukoht,CV,Portree,Kodulehekülg)
VALUES
('Nikita', 'Krutoi', '01-01-2000', 'Tallinn', 'Estonian', 'Tallinn', 'nikita-cv.com', 'nikita-portree', 'nikita-kodu-com')
,('Albert', 'En', '02-02-2000', 'Riga', 'Tallinn', 'Russian', 'albert-cv.com', 'albert-portree', 'albert-kodu-com')
,('Milana', 'Ill', '03-03-2000', 'Tallinn', 'Tallinn', 'Belgian', 'milana-cv.com', 'milana-portree', 'milana-kodu-com')

CREATE TABLE Teose_liik(
Liigi_ID INT PRIMARY KEY IDENTITY(1,1)
,Selgitav_text VARCHAR(MAX))

INSERT INTO Teose_liik(Selgitav_text)
VALUES
('Rahuolu'),('Drama'),('Minecraft')

CREATE TABLE Teosed(
Teosed_ID INT PRIMARY KEY IDENTITY(1,1)
,Pealkiri VARCHAR(150)
,Ilmumiskoht VARCHAR(100)
,Ilmumusaasta DATE
,Lk VARCHAR(10)
,Liigi_ID int
,FOREIGN KEY(Liigi_ID) REFERENCES Teose_liik(Liigi_ID))

INSERT INTO Teosed(Pealkiri,Ilmumiskoht,Ilmumusaasta,Lk,Liigi_ID)
VALUES
('Minecraft', 'Tallin', '01-01-2023', '100', 3)
,('DramRaamat', 'Riga', '02-02-2022', '450', 2)
,('RahouluRaamat', 'Mehiko', '03-03-2021', '200', 1)

CREATE TABLE Autorlus(
Autori_ID int
,Teosed_ID int
,FOREIGN KEY(Autori_ID) REFERENCES Autorid(Autori_ID)
,FOREIGN KEY(Teosed_ID) REFERENCES Teosed(Teosed_Id))

INSERT INTO Autorlus(Autori_ID, Teosed_ID)
VALUES
(1,1),(2,2),(3,3)

CREATE TABLE Kasutamine(
Sissekande_nr INT PRIMARY KEY IDENTITY(1,1)
,Teosed_ID int
,FOREIGN KEY (Teosed_ID) REFERENCES Teosed(Teosed_ID)
,Kasutusviisi_kirjeldus VARCHAR(150))

INSERT INTO Kasutamine(Teosed_ID, Kasutusviisi_kirjeldus)
VALUES
(1,'Huvitav'), (2,'Igav'), (3, 'Rahuolu')


SELECT * FROM Kasutamine
SELECT * FROM Autorlus
SELECT * FROM Teosed
SELECT * FROM Teose_liik
SELECT * FROM Autorid

SELECT Autorid.Eesnimi, Teosed.Pealkiri FROM Autorid JOIN Autorlus ON Autorid.Autori_ID = Autorlus.Autori_ID JOIN Teosed ON Teosed.Teosed_ID = Autorlus.Teosed_ID
WHERE Autorlus.Autori_ID = 1 AND Autorlus.Teosed_ID = 1;

