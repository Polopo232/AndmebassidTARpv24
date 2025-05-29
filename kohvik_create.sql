-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-05-29 06:17:39.358
CREATE DATABASE kohvik_nikiforov
USE kohvik_nikiforov

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
(1, '2025-05-29 18:15', 1, 1),
(2, '2025-05-29 20:10', 2, 2);

-- Заполнение таблицы Tellimusartikkel (Детали заказов)
INSERT INTO Tellimusartikkel (telliID, itemID, kogus, hind) VALUES
(1, 1, 2, 6),
(2, 2, 1, 5);

-- Заполнение таблицы Tootaja (Сотрудники)
INSERT INTO Tootaja (tootajaID, eesnimi, Perekonna, positsion, palka, toolevotmese) VALUES
(1, 'Sergei', 'Kuznetsov', 1, 1200, '2024-01-15'),
(2, 'Maria', 'Vasiljeva', 2, 1100, '2023-11-20');

CREATE VIEW Tellimus_Klient AS
SELECT
	T.telliID, K.eesnimi AS klient_nimi, K.perekonna AS klient_perekonna, T.Aeg AS tellimuse_aeg
FROM Tellimus T INNER JOIN Klient K ON T.telliID = K.klientID;

SELECT * FROM Tellimus_Klient ORDER BY tellimuse_aeg DESC;

CREATE VIEW Ladu_Menu AS
SELECT 
    L.nimi AS ladu_nimi, L.kogus, M.nimi AS menu_item, M.hind
FROM Ladu L INNER JOIN Menu M ON L.itemladuID = M.itemID WHERE L.kogus > 0;

SELECT * FROM Ladu_Menu ORDER BY menu_item;

GRANT SELECT ON tellimus TO kohvik_tootaja;
REVOKE INSERT, UPDATE, DELETE ON tootaja FROM kohvik_tootaja;

GRANT SELECT, INSERT, UPDATE ON tootaja TO kohvik_direktor;
REVOKE DELETE ON tellimus FROM kohvik_direktor;
DROP PROCEDURE AddKlient

CREATE PROCEDURE AddKlient(
    @p_klientID INT,
    @p_eesnimi VARCHAR(100),
    @p_perekonna VARCHAR(100),
    @p_telenum INT,
    @p_email VARCHAR(100)
)
AS
BEGIN
    INSERT INTO Klient (klientID, eesnimi, perekonna, telenum, email) 
    VALUES (@p_klientID, @p_eesnimi, @p_perekonna, @p_telenum, @p_email);
END

EXEC AddKlient 3, 'Ivan', 'Petrov', 55661234, 'ivan.petrov@email.ee';

SELECT * FROM Klient

CREATE PROCEDURE CheckStock(
@p_itemladuID INT
)
AS
BEGIN
    DECLARE @v_kogus INT;

    SELECT @v_kogus = kogus FROM Ladu WHERE itemladuID = @p_itemladuID;

    IF @v_kogus > 0 
        PRINT 'Toode laos: ' + CAST(@v_kogus AS VARCHAR) + ' tk.';
    ELSE 
        PRINT 'Toode otsas';
END

EXEC CheckStock 1

CREATE PROCEDURE AddLaduItem(
    @p_itemladuID INT,
    @p_nimi VARCHAR(50),
    @p_kogus INT,
    @p_ostuhind INT,
    @p_tarnaja INT
)
AS
BEGIN
    INSERT INTO Ladu (itemladuID, nimi, kogus, ostuhind, tarnaja) 
    VALUES (@p_itemladuID, @p_nimi, @p_kogus, @p_ostuhind, @p_tarnaja);
END

EXEC AddLaduItem 201, 'Kohvioad', 50, 12, 102;

SELECT * FROM Ladu

CREATE PROCEDURE UpdateReservationStatus(
    @p_reservID INT,
    @p_new_status VARCHAR(20)
)
AS
BEGIN
    UPDATE Reservatsioon
    SET olek = @p_new_status
    WHERE reservID = @p_reservID;
END

EXEC UpdateReservationStatus 1, 'Tühistatud';

SELECT * FROM Reservatsioon

CREATE PROCEDURE GetClientTotalSpent(
    @p_klientID INT
)
AS
BEGIN
    SELECT K.eesnimi AS Eesnimi, K.perekonna AS Perekonna, SUM(M.summa) AS TullemuseSumma
    FROM Klient K
    INNER JOIN Reservatsioon R ON K.klientID = R.klientID
    INNER JOIN Tellimus T ON R.reservID = T.reservID
    INNER JOIN Makse M ON T.telliID = M.telliID
    WHERE K.klientID = @p_klientID
    GROUP BY K.eesnimi, K.perekonna;
END


EXEC GetClientTotalSpent 2;
