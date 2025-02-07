
--SQL salvetatud protseduur - funktsioon, mis käivitab serveris mitu SQL tegevust järgest.
-- Kasutamine SQL Server
CREATE DATABASE ProtseduurNikiforov;

USE ProtseduurNikiforov;
CREATE TABLE linn(
linnId INT PRIMARY KEY IDENTITY(1,1)
,linnNimi VARCHAR(30)
,rahvaArv INT)

SELECT * FROM linn

INSERT INTO linn(linnNimi,rahvaArv)

VALUES
('Tallinn', 500000)
,('Tartu', 100000)
,('Narva', 60000)
,('Rakvere', 10000)
,('Riga', 150000)
,('Moscow', 13000000)

--Protseduuri loomine
--Protseduur, mis lisab uus linn ja kohe näitab tabelis

CREATE PROCEDURE lisaLinn
@Lnimi varchar(30)
,@rArv int
AS

BEGIN
INSERT INTO linn(linnNimi,rahvaArv)
VALUES (@Lnimi, @rArv)
SELECT * FROM linn;

END;

--Protseduuri kutse
EXEC lisaLinn @Lnimi='Riga',@rArv=123123

--lihtsam
EXEC lisaLinn 'Pärnu', 40000

--kirje kastutamine
DELETE FROM linn WHERE linnID=5

--protseduur, mis kustutab linn id järgi
CREATE PROCEDURE kustutaLinn
@deleteID int
AS
BEGIN
SELECT * FROM linn;
DELETE FROM linn WHERE linnID=@deleteID;
SELECT * FROM linn;
END

--kutse 
EXEC kustutaLinn 4;
--proceduri kustutamine
DROP PROCEDURE kustutaLinn;


--Protseduur, mis otsiblinn esimese tähte järgi
CREATE PROCEDURE LinnOts

@ots CHAR(1)
AS;
BEGIN;
SELECT * FROM linn
WHERE linnNimi LIKE @ots + '%';
--% - kõik teised tähed
END;
--kutse
EXEC LinnOts A;
--result
-- LinnID linnnimi rahvaarv
--   6     Almaty  321312


--tabeli uuendamine - rahvaarv kasvab 10 % võrra
UPDATE linn SET rahvaArv=rahvaArv*1.1
WHERE linnID=7;
SELECT * FROM linn;

CREATE PROCEDURE RahvaArvUuendus
@linnID int
,@koef decimal(2,1)
AS
BEGIN
SELECT * FROM linn;
UPDATE linn SET rahvaArv=rahvaArv*@koef
WHERE linnID=@linnID;
SELECT * FROM linn;
END;

EXEC RahvaArvUuendus 8, 1.2;

-- uue veeru lisamine
ALTER TABLE linn ADD test INT;
--veeru kustamine
ALTER TABLE linn DROP COLUMN test;

CREATE PROCEDURE veeruLisaKustuta
@valik VARCHAR(20)
,@veerunimi VARCHAR(20)
,@tyyp VARCHAR(20) = NULL

AS
BEGIN
DECLARE @sqltegevus AS VARCHAR(MAX)
SET @sqltegevus=CASE
WHEN @valik = 'add' THEN CONCAT('ALTER TABLE linn ADD ', @veerunimi, ' ', @tyyp)
WHEN @valik = 'drop' THEN CONCAT('ALTER TABLE linn DROP COLUMN ', @veerunimi)
END;
PRINT @sqltegevus;
BEGIN
EXEC (@sqltegevus);
END
END;

--kutse
EXEC veeruLisaKustuta @valik='add', @veerunimi='test3', @tyyp='int';
EXEC veeruLisaKustuta @valik='drop', @veerunimi='test3'

SELECT * FROM linn

CREATE PROCEDURE veeruLisaKustutaTabelis
@valik VARCHAR(20)
,@tabelinimi VARCHAR(20)
,@veerunimi VARCHAR(20)
,@tyyp VARCHAR(20) = NULL

AS
BEGIN
DECLARE @sqltegevus AS VARCHAR(MAX)
SET @sqltegevus=CASE
WHEN @valik = 'add' THEN CONCAT('ALTER TABLE ',@tabelinimi,' ADD ', @veerunimi, ' ', @tyyp)
WHEN @valik = 'drop' THEN CONCAT('ALTER TABLE ',@tabelinimi,' DROP COLUMN ', @veerunimi)
END;
PRINT @sqltegevus;
BEGIN
EXEC (@sqltegevus);
END
END;

EXEC veeruLisaKustutaTabelis @valik='add', @tabelinimi='linn', @veerunimi='test3', @tyyp='int';
EXEC veeruLisaKustutaTabelis @valik='drop',@tabelinimi='linn',@veerunimi='test3'

--protseduur tingimusega
CREATE PROCEDURE rahvaHinna
@piir int

AS
BEGIN
SELECT linnNimi, rahvaArv, IIF(rahvaArv<@piir, 'väike linn', 'suur linn') as Hinnang
FROM linn;
END;

DROP PROCEDURE rahvaHinna;

EXEC rahvaHinna 10000000;
--Agregaat funktsioonid: SUM(), AVG(), MIN(), MAX, COUNT()

CREATE PROCEDURE kokkuRahvaarv

AS
BEGIN
SELECT SUM(rahvaArv) AS 'kokku rahvaArv', AVG(rahvaArv) AS 'keskmine rahvaArv', COUNT(*) AS 'linnade arv'
FROM linn
END
-------------------------------------------------------------------------------------------------------------------
Kasutamine XAMPP / localhost
CREATE DATABASE ProtseduurNikiforov;

USE ProtseduurNikiforov;

CREATE TABLE linn(
linnId INT PRIMARY KEY AUTO_INCREMENT
,linnNimi VARCHAR(30)
,rahvaArv INT);

INSERT INTO linn(linnNimi,rahvaArv)
VALUES
('Tallinn', 500000)
,('Tartu', 100000)
,('Narva', 60000)
--lisaLinn
BEGIN
    INSERT INTO linn(linnNimi, rahvaArv)
    VALUES (Lnimi, rArv);
    SELECT * FROM linn;
END
    
--kustutaLinn
BEGIN
SELECT * FROM linn;
DELETE FROM linn WHERE linnID=deleteID;
SELECT * FROM linn;
END
    
--LinnOts
BEGIN
    SELECT * FROM linn
    WHERE LinnNimi LIKE CONCAT('ots', '%');
END

--RahvaArvUuendus
BEGIN
    SELECT * FROM filmid;
    UPDATE filmid SET zant=Fzant
    WHERE filmID=id;
    SELECT * FROM filmid;
END
