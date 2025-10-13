CREATE DATABASE NikTrig

USE NikTrig

CREATE TABLE tree(
puuID int primary key identity(1,1)
,puuNimi varchar(100)
,kirjeldus varchar(250)
,pikkus decimal)

CREATE TABLE logs(
logID int primary key identity(1,1)
, kuupaev DATE
, toiming varchar(50)
, andmed varchar(250)
, kasutaja varchar(250)
)

CREATE TABLE puuLeht(
puuLehtID int primary key identity(1,1)
, lehtNimi varchar(100)
, puuID int
foreign key (puuID) references tree(puuID)
)

CREATE TRIGGER trg_insert_puu
ON tree
AFTER INSERT
AS
BEGIN
	INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
	SELECT 
	getdate()
	,'INSERT'
	,CONCAT('puuID: ', p.puuID, ', puuNimi: ', p.puuNimi, ', kirjeldus: ', p.kirjeldus, ', pikkus: ', p.pikkus)
	,SYSTEM_USER
	FROM inserted p
END;

INSERT INTO tree(puuNimi, kirjeldus, pikkus)
VALUES
('mänd', 'mustvalge', 557)

	CREATE TRIGGER trg_update_puu
	ON tree
	AFTER UPDATE
	AS
	BEGIN
		INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
		SELECT 
		getdate()
		,'UPDATE'
		,CONCAT('Kasutatud:', 'puuID: ', p.puuID, ', puuNimi: ', p.puuNimi, ', kirjeldus: ', p.kirjeldus, ', pikkus: ', p.pikkus,
		'Lisanud:', 'puuID: ', l.puuID, ', puuNimi: ', l.puuNimi, ', kirjeldus: ', l.kirjeldus, ', pikkus: ', l.pikkus)
		,SYSTEM_USER
		FROM deleted p INNER JOIN inserted l ON l.puuID = p.puuID
	END;

UPDATE tree SET puuNimi = 'bereza' WHERE puuID = 1

CREATE TRIGGER trg_delete_puu
ON tree
AFTER DELETE
AS
BEGIN
	INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
	SELECT 
	getdate()
	,'DELETE'
	,CONCAT('Kasutatud:', 'puuID: ', p.puuID, ', puuNimi: ', p.puuNimi, ', kirjeldus: ', p.kirjeldus, ', pikkus: ', p.pikkus)
	,SYSTEM_USER
	FROM deleted p
END;

DELETE FROM tree WHERE puuID = 1


SELECT * FROM logs
SELECT * FROM tree

--puuLeht

SELECT * FROM puuLeht

INSERT INTO puuLeht(lehtNimi, puuID)
VALUES
('Noelad', 2)

CREATE TRIGGER trg_insert_puuLeht
ON puuLeht
AFTER INSERT
AS
BEGIN
	INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
	SELECT 
	getdate()
	,'INSERT'
	,CONCAT('ID: ', p.puuLehtID, ', puuLehtNimi: ', p.lehtNimi, ', puu: ', j.puuNimi)
	,SYSTEM_USER
	FROM inserted p INNER JOIN tree j ON p.puuID = j.puuID
END;

CREATE TRIGGER trg_update_puuLeht
ON puuLeht
AFTER UPDATE
AS
BEGIN
	INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
	SELECT 
	getdate()
	,'UPDATE'
	,CONCAT('Kasutatud:', 'ID: ', p.puuLehtID, ', puuLehtNimi: ', p.lehtNimi, ', puu: ', j.puuNimi,
	'Lisanud:', 'ID: ', p.puuLehtID, ', puuLehtNimi: ', p.lehtNimi, ', puu: ', j.puuNimi)
	,SYSTEM_USER
	FROM deleted p
	INNER JOIN inserted l ON l.puuID = p.puuID
	INNER JOIN tree j ON j.puuID = l.puuID
	INNER JOIN tree j2 ON j2.puuID = p.puuID
END;

UPDATE puuLeht SET lehtNimi = 'lehed' WHERE puuLehtID = 4

CREATE TRIGGER trg_delete_puuLeht
ON puuLeht
AFTER DELETE
AS
BEGIN
	INSERT INTO logs (kuupaev, toiming, andmed, kasutaja)
	SELECT 
	getdate()
	,'DELETE'
	,CONCAT('Kasutatud:', 'ID: ', p.puuLehtID, ', puuLehtNimi: ', p.lehtNimi, ', puu: ', j.puuNimi)
	,SYSTEM_USER
	FROM deleted p
	INNER JOIN tree j ON j.puuID = p.puuID
END;

DELETE FROM puuLeht WHERE puuLehtID = 4
