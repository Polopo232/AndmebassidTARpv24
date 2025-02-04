
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

