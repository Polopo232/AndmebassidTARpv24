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


SELECT * FROM kasutaja
SELECT * FROM retsept
SELECT * FROM kategooria
SELECT * FROM koostis
SELECT * FROM yhik
SELECT * FROM toiduaine
SELECT * FROM tehtud
