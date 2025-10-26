-- tables
-- Table: Klient
CREATE TABLE Klient (
    klientID int  NOT NULL,
    eesnimi varchar(100)  NOT NULL,
    perekonna varchar(100)  NOT NULL,
    telenum int  NOT NULL,
    email varchar(150) NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY  (klientID)
);

-- Table: Ladu
CREATE TABLE Ladu (
    itemladuID int  NOT NULL,
    nimi varchar(50)  NOT NULL,
    kogus int  NOT NULL,
    ostuhind int  NOT NULL,
    tarnaja int  NOT NULL,
    CONSTRAINT Ladu_pk PRIMARY KEY  (itemladuID)
);

-- Table: Makse
CREATE TABLE Makse (
    MakseID int  NOT NULL,
    telliID int  NOT NULL,
    summa int  NOT NULL,
    makseviis varchar(30)  NOT NULL,
    maksaaeg date  NOT NULL,
    CONSTRAINT Makse_pk PRIMARY KEY  (MakseID)
);

SELECT * FROM Makse

-- Table: Menu
CREATE TABLE Menu (
    itemID int  NOT NULL,
    nimi varchar(100)  NOT NULL,
    kategooria varchar(50)  NOT NULL,
    hind int  NOT NULL,
    kattesaademus int  NOT NULL,
    CONSTRAINT Menu_pk PRIMARY KEY  (itemID)
);

-- Table: Reservatsioon
CREATE TABLE Reservatsioon (
    reservID int  NOT NULL,
    klientID int  NOT NULL,
    tabelinum int  NOT NULL,
    reservaeg date  NOT NULL,
    olek varchar(20)  NOT NULL,
    CONSTRAINT Reservatsioon_pk PRIMARY KEY  (reservID)
);

-- Table: Tellimus
CREATE TABLE Tellimus (
    telliID int  NOT NULL,
    Aeg date  NOT NULL,
    reservID int  NOT NULL,
    tootajaID int  NOT NULL,
    CONSTRAINT Tellimus_pk PRIMARY KEY  (telliID)
);

-- Table: Tellimusartikkel
CREATE TABLE Tellimusartikkel (
    telliID int  NOT NULL,
    itemID int  NOT NULL,
    kogus int  NOT NULL,
    hind int  NOT NULL
);

-- Table: Tootaja
CREATE TABLE Tootaja (
    tootajaID int  NOT NULL,
    eesnimi varchar(100)  NOT NULL,
    Perekonna varchar(100)  NOT NULL,
    positsion int  NOT NULL,
    palka int  NOT NULL,
    toolevotmese varchar(50)  NOT NULL,
    CONSTRAINT Tootaja_pk PRIMARY KEY  (tootajaID)
);

CREATE TABLE KlientTulemus (
    KliTulID int PRIMARY KEY IDENTITY(1,1)
    ,klientID int
    ,telliID int
    ,MakseID int
    ,tootajaID int
    ,FOREIGN KEY (klientID) REFERENCES Klient(klientID)
	,FOREIGN KEY (telliID) REFERENCES Tellimus(telliID)
    ,FOREIGN KEY (MakseID) REFERENCES Makse(MakseID)
    ,FOREIGN KEY (tootajaID) REFERENCES Tootaja(tootajaID)
);
-- foreign keys
-- Reference: Makse_Tellimus (table: Makse)
ALTER TABLE Makse ADD CONSTRAINT Makse_Tellimus
    FOREIGN KEY (telliID)
    REFERENCES Tellimus (telliID);

-- Reference: Reservatsioon_Klient (table: Reservatsioon)
ALTER TABLE Reservatsioon ADD CONSTRAINT Reservatsioon_Klient
    FOREIGN KEY (klientID)
    REFERENCES Klient (klientID);

-- Reference: Tellimus_Reservatsioon (table: Tellimus)
ALTER TABLE Tellimus ADD CONSTRAINT Tellimus_Reservatsioon
    FOREIGN KEY (reservID)
    REFERENCES Reservatsioon (reservID);

-- Reference: Tellimus_Tootaja (table: Tellimus)
ALTER TABLE Tellimus ADD CONSTRAINT Tellimus_Tootaja
    FOREIGN KEY (tootajaID)
    REFERENCES Tootaja (tootajaID);

-- Reference: Tellimusartikkel_Menu (table: Tellimusartikkel)
ALTER TABLE Tellimusartikkel ADD CONSTRAINT Tellimusartikkel_Menu
    FOREIGN KEY (itemID)
    REFERENCES Menu (itemID);

-- Reference: Tellimusartikkel_Tellimus (table: Tellimusartikkel)
ALTER TABLE Tellimusartikkel ADD CONSTRAINT Tellimusartikkel_Tellimus
    FOREIGN KEY (telliID)
    REFERENCES Tellimus (telliID);

-- End of file.

-- Заполнение таблицы Klient (Клиенты)
INSERT INTO Klient (klientID, eesnimi, perekonna, telenum, email) VALUES
(1, 'Mihhail', 'Ivanov', 55667788, 'mihhail.ivanov@email.ee'),
(2, 'Anna', 'Petrova', 56565656, 'anna.petrova@email.ee');

-- Заполнение таблицы Ladu (Склад)
INSERT INTO Ladu (itemladuID, nimi, kogus, ostuhind, tarnaja) VALUES
(1, 'Kohvioad', 50, 10, 101),
(2, 'Tassid', 200, 2, 102);

-- Заполнение таблицы Makse (Платежи)
INSERT INTO Makse (MakseID, telliID, summa, makseviis, maksaaeg) VALUES
(1, 1, 25, 'Kaart', '2025-05-28'),
(2, 2, 12, 'Sularaha', '2025-05-29');

-- Заполнение таблицы Menu (Меню)
INSERT INTO Menu (itemID, nimi, kategooria, hind, kattesaademus) VALUES
(1, 'Latte', 'Kohv', 3, 1),
(2, 'Juustukook', 'Magustoit', 5, 1);

-- Заполнение таблицы Reservatsioon (Бронирование)
INSERT INTO Reservatsioon (reservID, klientID, tabelinum, reservaeg, olek) VALUES
(1, 1, 5, '2025-05-29 18:00', 'Kinnitatud'),
(2, 2, 3, '2025-05-29 20:00', 'Ootel');

-- Заполнение таблицы Tellimus (Заказы)
INSERT INTO Tellimus (telliID, Aeg, reservID, tootajaID) VALUES
(1, '2025-05-29', 1, 1),
(2, '2025-05-29', 2, 2);

SELECT * FROM Tellimus
SELECT * FROM Menu
SELECT * FROM Reservatsioon
SELECT * FROM Tootaja

-- Заполнение таблицы Tellimusartikkel (Детали заказов)
INSERT INTO Tellimusartikkel (telliID, itemID, kogus, hind) VALUES
(1, 1, 2, 6),
(2, 2, 1, 5);
-- Заполнение таблицы Tootaja (Сотрудники)
INSERT INTO Tootaja (tootajaID, eesnimi, Perekonna, positsion, palka, toolevotmese) VALUES
(1, 'Sergei', 'Kuznetsov', 1, 1200, '2024-01-15'),
(2, 'Maria', 'Vasiljeva', 2, 1100, '2023-11-20');

CREATE TABLE MakseLog (
    MakseLogID int IDENTITY(1,1) PRIMARY KEY,
    MakseID int,
	USER_add varchar(100),
    LogTime datetime DEFAULT GETDATE(),
    Message varchar(MAX)
);

CREATE TRIGGER Insert_Makse
ON Makse
AFTER INSERT
AS
BEGIN
    INSERT INTO MakseLog (MakseID, USER_add, LogTime, Message)
    SELECT 
        MakseID, 
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
    INSERT INTO MakseLog (MakseID, USER_add, LogTime, Message)
    SELECT 
        i.MakseID, 
        SUSER_NAME(), 
        GETDATE(),
        CONCAT(
            'Muudetud ID: ', d.telliID, 
            ' , Vana: , Summa: ', d.summa, ', Aeg: ', d.maksaaeg,
            ' Uue: , Summa: ', i.summa, ', Aeg: ', i.maksaaeg
        )
    FROM inserted i
    INNER JOIN deleted d ON i.MakseID = d.MakseID;
END;

CREATE TRIGGER Delete_Makse
ON Makse
AFTER DELETE
AS
BEGIN
    INSERT INTO MakseLog (MakseID, USER_add, LogTime, Message)
    SELECT 
        MakseID, 
        SUSER_NAME(), 
        GETDATE(),
        CONCAT(
            'Kasutatud ID: ', telliID, 
            ' , Summa: ', summa, 
            ', Aeg: ', maksaaeg
        )
    FROM deleted;
END;

--Kontroll
INSERT INTO Makse (MakseID, telliID, summa, makseviis, maksaaeg) VALUES
(6, 3, 342, 'Kaart', '2025-01-18')
UPDATE Makse SET summa = 500 WHERE MakseID = 6
DELETE FROM Makse WHERE MakseID = 6
SELECT * FROM MakseLog
DROp TRIGGER Insert_makse
----------------------------------

INSERT INTO Makse (MakseID, telliID, summa, makseviis, maksaaeg) VALUES
(5, 3, 275, 'Kaart', '2025-09-18')

INSERT INTO Tellimus (telliID, Aeg, reservID, tootajaID) VALUES
(3, '2025-10-18', 1, 1)

CREATE TABLE TellimusLog (
    TellLogID int IDENTITY(1,1) PRIMARY KEY,
    telliID int,
	USER_add varchar(100),
    LogTime datetime DEFAULT GETDATE(),
    Message varchar(100)
);

CREATE TRIGGER Insert_Tellimus
ON KlientTulemus
AFTER INSERT
AS
BEGIN
    INSERT INTO TellimusLog (telliID, USER_add, LogTime, Message)
    SELECT 
        i.telliID, 
        SUSER_NAME(), 
        GETDATE(),
        CONCAT(
            'Lisatud uus tellimus: ', i.telliID, 
            ', klient: ', k.eesnimi, 
            ', töötaja: ', t.eesnimi, 
            ', makse ID: ', i.MakseID
        )
    FROM inserted i
    INNER JOIN Tootaja t ON i.tootajaID = t.tootajaID
    INNER JOIN Klient k ON i.klientID = k.klientID;
END;

CREATE TRIGGER Update_Tellimus
ON KlientTulemus
AFTER UPDATE
AS
BEGIN
    INSERT INTO TellimusLog (telliID, USER_add, LogTime, Message)
    SELECT 
        i.telliID, 
        SUSER_NAME(), 
        GETDATE(),
        CONCAT(
            'Muudatused. Vana: ', d.telliID, 
            ', klient: ', kd.eesnimi, 
            ', töötaja: ', td.eesnimi, 
            ', makse ID: ', d.MakseID,
            ' Uue: ', i.telliID, 
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
    INSERT INTO TellimusLog (telliID, USER_add, LogTime, Message)
    SELECT 
        d.telliID, 
        SUSER_NAME(), 
        GETDATE(),
        CONCAT(
            'Kasutatud ID: ', d.telliID, 
            ', klient: ', k.eesnimi, 
            ', töötaja: ', t.eesnimi, 
            ', makse ID: ', d.MakseID
        )
    FROM deleted d
    INNER JOIN Tootaja t ON d.tootajaID = t.tootajaID
    INNER JOIN Klient k ON d.klientID = k.klientID;
END;

DROP TRIGGER Update_Tellimus

INSERT INTO KlientTulemus (klientID, MakseID, telliID, tootajaID) VALUES
(2, 2, 2, 2)

UPDATE KlientTulemus SET tootajaID = 1 WHERE telliID = 2


ALTER TABLE TellimusLog
ALTER COLUMN Message varchar(MAX);

DELETE FROM KlientTulemus WHERE telliID = 2


SELECT * FROM TellimusLog

DROP TRIGGER Insert_Makse
DROP TRIGGER Update_Makse
DROP TRIGGER Delete_Makse

DROP TRIGGER Insert_Tellimus
DROP TRIGGER Update_Tellimus
DROP TRIGGER Deleted_Tellimus

GRANT SELECT, INSERT, UPDATE ON Klient TO KohvikWaiter
GRANT SELECT, INSERT, UPDATE ON Tellimus TO KohvikWaiter
GRANT SELECT, INSERT, UPDATE ON Reservatsioon TO KohvikWaiter
GRANT SELECT, INSERT, UPDATE ON KlientTulemus TO KohvikWaiter
