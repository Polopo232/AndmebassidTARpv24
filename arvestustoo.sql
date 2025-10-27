USE NikArvestus

CREATE TABLE Turniir(
TurniirID INT PRIMARY KEY IDENTITY(1,1)
,TurniirNimi VARCHAR(100)
)

CREATE TABLE Voistlus(
VoistlusID INT PRIMARY KEY IDENTITY(1,1)
,VoistlusNimi VARCHAR(200)
,OsalejateArv INT
,TurniirID int
,FOREIGN KEY (TurniirID) REFERENCES Turniir(TurniirID)
)

CREATE TABLE Osaleja (
OsalejaID INT PRIMARY KEY IDENTITY(1,1)
,OsalejaNimi VARCHAR(200)
,VoistlusID INT
,FOREIGN KEY (VoistlusID) REFERENCES Voistlus(VoistlusID)
)

GRANT SELECT, INSERT ON Turniir TO opilane123
GRANT SELECT, INSERT, DELETE ON Voistlus TO opilane123
GRANT SELECT, INSERT ON Osaleja TO opilane123

-----------------------------------------------------------------------------------------

CREATE TABLE logi(
ID INT PRIMARY KEY IDENTITY(1,1)
,kasutaja VARCHAR(100)
,kuupaev DATE
,tegevus VARCHAR(MAX)
,andmed TEXT
)

CREATE TRIGGER Voistlus_deleted
ON Voistlus
AFTER DELETE
AS
BEGIN
INSERT INTO logi(kasutaja,kuupaev,tegevus,andmed)
SELECT
SYSTEM_USER
,GETDATE()
,'DELETE'
,CONCAT('Kasuta voistlus: ', d.VoistlusNimi, ', ID: ', d.VoistlusID)
FROM deleted d
END;

CREATE TRIGGER Voistlus_insert
ON Voistlus
AFTER INSERT
AS
BEGIN
INSERT INTO logi(kasutaja,kuupaev,tegevus,andmed)
SELECT
SYSTEM_USER
,GETDATE()
,'INSERT'
,CONCAT('Lisa uus voistlus: ', i.VoistlusNimi
, ' ID: ', i.VoistlusID
, ' Osalejate arv: ', i.OsalejateArv
, ' Turniir ID: ', t.TurniirNimi)
FROM inserted i
INNER JOIN Turniir t ON i.TurniirID = t.TurniirID
END

DROP TRIGGER Voistlus_insert

SELECT * FROM logi
----------------------------------------------------------------
CREATE PROCEDURE VoistlusByNimi
@VoistlusName VARCHAR(200)

AS
BEGIN
SELECT
s.VoistlusID
,s.VoistlusNimi
,s.OsalejateArv
,t.TurniirNimi AS VoistlusNimi
FROM Voistlus s
INNER JOIN Turniir t ON s.TurniirID = t.TurniirID
WHERE t.TurniirNimi = @VoistlusName
ORDER BY s.VoistlusNimi
END

EXEC VoistlusByNimi 'test1'

------------------------------------------------------
BEGIN TRANSACTION;
SAVE TRANSACTION Savepoint1;

BEGIN TRY

INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('Voistlus 2', 32, 2);

COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION Savepoint1;
ROLLBACK

COMMIT TRANSACTION;

END CATCH;
--------------------------------------------------------------------------------

CREATE VIEW TurniirAnalitika AS
SELECT
t.TurniirID AS Turniir_ID,
t.TurniirNimi AS Turniir_Nimi,
COUNT(DISTINCT v.VoistlusID) AS Voistluse_arv,
COUNT(DISTINCT o.OsalejaID) AS Osaleja_arv,
SUM(v.OsalejateArv) AS Osaleja_arvu_plaan,
AVG(v.OsalejateArv) AS Keskmine_osaleja_arv,
MAX(v.OsalejateArv) AS Maksimaalne_osaleja_arv,
MIN(v.OsalejateArv) AS Minimaalne_osaleja_arv,
CASE
    WHEN COUNT(o.OsalejaID) > 3 THEN 'Maraton'
    WHEN COUNT(o.OsalejaID) > 2 THEN 'Populaarne'
    WHEN COUNT(o.OsalejaID) > 1 THEN 'Aktiivne'
    ELSE 'Osalejaid pole'
    END AS Turniir_olek
FROM Turniir t
INNER JOIN Voistlus v ON t.TurniirID = v.TurniirID
LEFT JOIN Osaleja o ON v.VoistlusID = o.VoistlusID
GROUP BY t.TurniirID, t.TurniirNimi;

DROP VIEW TurniirAnalitika

SELECT * FROM TurniirAnalitika

SELECT * FROM Voistlus
SELECT * FROM Osaleja

INSERT INTO Osaleja(OsalejaNimi, VoistlusID)
VALUES
('Lena', 3)