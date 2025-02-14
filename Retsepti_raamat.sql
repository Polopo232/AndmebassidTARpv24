--kasutaja
CREATE TABLE kasutaja(
kasutaja_id INT PRIMARY KEY IDENTITY(1,1)
,eesnimi VARCHAR(50)
,perenimi VARCHAR(50)
,email VARCHAR(150)
);

INSERT INTO kasutaja (eesnimi, perenimi, email)
VALUES
('Albert','New york','albertnewyork@com')
,('Robert','Pris','roberparis@com')
,('Anton','Bulka','antonbulka@com')
,('Walter','White','walterwhite@com')
,('Nikita','Napoleon','nikitanapoleon@com')

--kategooria
CREATE TABLE kategooria(
kategooria_id INT PRIMARY KEY IDENTITY(1,1)
,kategooria_nimi VARCHAR(50))

INSERT INTO kategooria (kategooria_nimi)
VALUES
('suppid')
,('magused')
,('roat')
,('jookid')
,('supised')

--toiduaine
CREATE TABLE toiduaine (
toiduaine_id INT PRIMARY KEY IDENTITY(1,1)
,toitduaine_nimi VARCHAR(100))

INSERT INTO toiduaine (toitduaine_nimi)
VALUES
('juust')
,('liha')
,('piim')
,('soola')
,('munad')

--yhik
CREATE TABLE yhik (
yhik_id INT PRIMARY KEY IDENTITY(1,1)
,yhik_nimi VARCHAR(100))

INSERT INTO yhik(yhik_nimi)
VALUES
('ml')
,('g')
,('kg')
,('tl')
,('sl')

--retsept
CREATE TABLE retsept (
retsept_id INT PRIMARY KEY IDENTITY(1,1)
,retsept_nimi VARCHAR(100)
,kirjeldus VARCHAR(200)
,juhend VARCHAR(500)
,sisestatud_kp DATE
,kasutaja_id INT
,kategooria_id INT
,FOREIGN KEY(kasutaja_id) REFERENCES kasutaja(kasutaja_id)
,FOREIGN KEY(kategooria_id) REFERENCES kategooria(kategooria_id))

INSERT INTO retsept(retsept_nimi, kirjeldus, juhend, sisestatud_kp,kasutaja_id,kategooria_id)
VALUES
('Pasta Carbonara','maitsev','kokkama','01-01-2025',1,1)
,('Chicken Curry','mitte kõigile','küpseta','02-02-2025',2,2)
,('Chocolate Cake','maitsev','küpseta','03-03-2025',3,3)
,('Caesar Salad','mitte kõigile','hakkida ja segada','04-04-2025',4,4)
,('Tomato Soup','mitte kõigile','hakkida ja segada','05-05-2025',5,5)

--koostis
CREATE TABLE koostis(
koostis_id INT PRIMARY KEY IDENTITY(1,1)
,kogus INT
,retsept_retsept_id INT
,FOREIGN KEY (retsept_retsept_id) REFERENCES retsept(retsept_id)
,toiduaine_id INT
,FOREIGN KEY (toiduaine_id) REFERENCES toiduaine(toiduaine_id)
,yhik_id INT
,FOREIGN KEY (yhik_id) REFERENCES yhik(yhik_id))

INSERT INTO koostis (kogus, retsept_retsept_id,toiduaine_id,yhik_id)
VALUES
(10,1,1,10)
,(20,2,2,9)
,(30,3,3,8)
,(40,4,4,7)
,(50,5,5,6)

--tehtud
CREATE TABLE tehtud(
tehtud_id INT PRIMARY KEY IDENTITY(1,1)
,tehtud_kp DATE
,retsept_id INT
,FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id))

INSERT INTO tehtud(tehtud_kp, retsept_id)
VALUES
('02-02-2025',1)
,('01-01-2025',2)
,('03-03-2025',3)
,('04-04-2025',4)
,('05-05-2025',5)

----------------------------------------PROCEDURES-----------------------------------------------

CREATE PROCEDURE addkasutaja
@enimi VARCHAR(50)
,@pnimi VARCHAR(50)
,@mail VARCHAR(150)
AS
BEGIN
	INSERT INTO kasutaja(eesnimi, perenimi, email)
	VALUES (@enimi, @pnimi, @mail)
	SELECT * FROM kasutaja
END;

exec addkasutaja 'Saddam', 'Hussein', 'sadamhusein@com';

CREATE PROCEDURE addretsept
    @rnimi VARCHAR(100),
    @kirjeldus VARCHAR(200),
    @juhend VARCHAR(500),
    @sisestatud_kp DATE,
    @kasutaja_id INT,
    @kategooria_id INT
AS
BEGIN
    INSERT INTO retsept (retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
    VALUES (@rnimi, @kirjeldus, @juhend, @sisestatud_kp, @kasutaja_id, @kategooria_id);
    SELECT * FROM retsept;
END;

CREATE PROCEDURE addkategooria
    @kategooria_nimi VARCHAR(50)
AS
BEGIN
    INSERT INTO kategooria (kategooria_nimi)
    VALUES (@kategooria_nimi);
    SELECT * FROM kategooria;
END;

CREATE PROCEDURE addtehtud
    @tehtud_kp DATE,
    @retsept_id INT
AS
BEGIN
    INSERT INTO tehtud (tehtud_kp, retsept_id)
    VALUES (@tehtud_kp, @retsept_id);
    SELECT * FROM tehtud;
END;


CREATE PROCEDURE veeruLisaKustuta
@valik VARCHAR(20)
,@veerunimi VARCHAR(20)
,@tyyp VARCHAR(20) = NULL
,@tabname VARCHAR(50)

AS
BEGIN
DECLARE @sqltegevus AS VARCHAR(MAX)
SET @sqltegevus=CASE
WHEN @valik = 'add' THEN CONCAT('ALTER TABLE ',@tabname,' ADD ', @veerunimi, ' ', @tyyp)
WHEN @valik = 'drop' THEN CONCAT('ALTER TABLE ',@tabname,' DROP COLUMN ', @veerunimi)
END;
PRINT @sqltegevus;
BEGIN
EXEC (@sqltegevus);
END
END;


EXEC veeruLisaKustuta @valik='add', @tabname='kasutaja', @veerunimi='test3', @tyyp='int';
EXEC veeruLisaKustuta @valik='drop', @tabname='kasutaja', @veerunimi='test3'

-------------------------------------------------------------------------------------------

CREATE TABLE lauabron(
laua_id INT PRIMARY KEY IDENTITY(1,1)
,laua_bron DATE
,kasutaja_id INT
,FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id))

INSERT INTO lauabron(laua_bron, kasutaja_id)
VALUES
('01-01-2025', 1)
,('02-02-2025', 2)
,('03-03-2025', 3)
,('04-04-2025', 4)
,('05-05-2025', 5)

CREATE PROCEDURE addbron
    @bron DATE,
    @kas_id INT
AS
BEGIN
    INSERT INTO lauabron(laua_bron, kasutaja_id)
    VALUES (@bron, @kas_id);
    SELECT * FROM lauabron;
END;

EXEC addbron '09-09-2025', 3

--Kastuta bron
CREATE PROCEDURE delbron
    @id INT
AS
BEGIN
	SELECT * FROM lauabron
	DELETE FROM lauabron WHERE laua_id=@id
    SELECT * FROM lauabron
END;

exec delbron 6


--Kõik tables
SELECT * FROM kasutaja
SELECT * FROM lauabron
SELECT * FROM retsept
SELECT * FROM kategooria
SELECT * FROM koostis
SELECT * FROM yhik
SELECT * FROM toiduaine
SELECT * FROM tehtud
