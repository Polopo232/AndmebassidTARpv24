CREATE TRIGGER Insert_Makse
ON Makse
AFTER INSERT
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'INSERT',
SUSER_NAME(), 
GETDATE(),
CONCAT('Tellimus on makstud ID: ', telliID, ', Summa: ', summa, ', Aeg: ', maksaaeg)
FROM inserted;
END;

CREATE TRIGGER Update_Makse
ON Makse
AFTER UPDATE
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'UPDATE',
SUSER_NAME(), 
GETDATE(),
CONCAT(
'Muudetud ID: ', d.telliID, 
' , Vana: Summa: ', d.summa, ', Aeg: ', d.maksaaeg,
' | Uus: Summa: ', i.summa, ', Aeg: ', i.maksaaeg
)
FROM inserted i
INNER JOIN deleted d ON i.MakseID = d.MakseID;
END;


CREATE TRIGGER Delete_Makse
ON Makse
AFTER DELETE
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'DELETE',
SUSER_NAME(), 
GETDATE(),
CONCAT(
'Kustutatud makse ID: ', telliID, 
', Summa: ', summa, 
', Aeg: ', maksaaeg
)
FROM deleted;
END;

CREATE TRIGGER Insert_Tellimus
ON KlientTulemus
AFTER INSERT
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'INSERT',
SUSER_NAME(), 
GETDATE(),
CONCAT(
'Lisatud uus tellimus: ', i.telliID, 
', klient: ', k.eesnimi, 
', töötaja: ', t.eesnimi, 
', makseviis: ', m.makseviis
)
FROM inserted i
INNER JOIN Tootaja t ON i.tootajaID = t.tootajaID
INNER JOIN Klient k ON i.klientID = k.klientID
INNER JOIN Makse m ON i.telliID = m.telliID;
END;


CREATE TRIGGER Update_Tellimus
ON KlientTulemus
AFTER UPDATE
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'UPDATE',
SUSER_NAME(), 
GETDATE(),
CONCAT(
'Muudatused. Vana tellimus: ', d.telliID, 
', klient: ', kd.eesnimi, 
', töötaja: ', td.eesnimi, 
', makse ID: ', d.MakseID,
' | Uus tellimus: ', i.telliID, 
', klient: ', ki.eesnimi, 
', töötaja: ', ti.eesnimi, 
', makse ID: ', i.MakseID
)
FROM inserted i
INNER JOIN deleted d ON i.telliID = d.telliID
INNER JOIN Tootaja ti ON i.tootajaID = ti.tootajaID
INNER JOIN Klient ki ON i.klientID = ki.klientID
INNER JOIN Tootaja td ON d.tootajaID = td.tootajaID
INNER JOIN Klient kd ON d.klientID = kd.klientID;
END;

CREATE TRIGGER Deleted_Tellimus
ON KlientTulemus
AFTER DELETE
AS
BEGIN
INSERT INTO logi (tegevus, USER_add, LogTime, Message)
SELECT 
'DELETE',
SUSER_NAME(), 
GETDATE(),
CONCAT(
'Kustutatud tellimus ID: ', d.telliID, 
', klient: ', k.eesnimi, 
', töötaja: ', t.eesnimi, 
', makse ID: ', d.MakseID
)
FROM deleted d
INNER JOIN Tootaja t ON d.tootajaID = t.tootajaID
INNER JOIN Klient k ON d.klientID = k.klientID;
END;


CREATE TABLE logi(
    LogID int IDENTITY(1,1) PRIMARY KEY,
	tegevus VARCHAR(200),
	USER_add varchar(100),
    LogTime datetime DEFAULT GETDATE(),
    Message varchar(MAX)
	)

SELECT * FROM logi

SELECT * FROM Makse

DROP TRIGGER Insert_Makse
DROP TRIGGER Update_Makse
DROP TRIGGER Delete_Makse

DROP TRIGGER Insert_Tellimus
DROP TRIGGER Update_Tellimus
DROP TRIGGER Deleted_Tellimus