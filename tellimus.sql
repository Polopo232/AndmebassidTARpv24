-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2025-05-02 08:04:30.522

CREATE DATABASE Tellimus
USE Tellimus 

-- tables
-- Table: Aadress
CREATE TABLE Aadress (
    AadressID int  NOT NULL,
    kl_aadress varchar(50)  NOT NULL,
    klientID int  NOT NULL,
    CONSTRAINT Aadress_pk PRIMARY KEY  (AadressID)
);

-- Table: klient
CREATE TABLE klient (
    klientID int  NOT NULL,
    klient varchar(50)  NOT NULL,
    CONSTRAINT klient_pk PRIMARY KEY  (klientID)
);

-- Table: komm
CREATE TABLE komm (
    kommID int  NOT NULL,
    Komminimetus varchar(100)  NOT NULL,
    hind int  NOT NULL,
    kommityypID int  NOT NULL,
    kehvitusaeg date  NOT NULL,
    CONSTRAINT komm_pk PRIMARY KEY  (kommID)
);

-- Table: kommityyp
CREATE TABLE kommityyp (
    kommityypID int  NOT NULL,
    komityyp varchar(100)  NOT NULL,
    CONSTRAINT kommityyp_pk PRIMARY KEY  (kommityypID)
);

-- Table: pakkija
CREATE TABLE pakkija (
    pakkijaID int  NOT NULL,
    pakkija varchar(150)  NOT NULL,
    CONSTRAINT pakkija_pk PRIMARY KEY  (pakkijaID)
);

-- Table: tellimus
CREATE TABLE tellimus (
    tellimusID int  NOT NULL,
    AadressID int  NOT NULL,
    tell_kuupaev date  NOT NULL,
    kommID int  NOT NULL,
    kogus int  NOT NULL,
    pakkijaID int  NOT NULL,
    CONSTRAINT tellimus_pk PRIMARY KEY  (tellimusID)
);

-- foreign keys
-- Reference: Aadress_klient (table: Aadress)
ALTER TABLE Aadress ADD CONSTRAINT Aadress_klient
    FOREIGN KEY (klientID)
    REFERENCES klient (klientID);

-- Reference: komm_kommityyp (table: komm)
ALTER TABLE komm ADD CONSTRAINT komm_kommityyp
    FOREIGN KEY (kommityypID)
    REFERENCES kommityyp (kommityypID);

-- Reference: tellimus_Aadress (table: tellimus)
ALTER TABLE tellimus ADD CONSTRAINT tellimus_Aadress
    FOREIGN KEY (AadressID)
    REFERENCES Aadress (AadressID);

-- Reference: tellimus_komm (table: tellimus)
ALTER TABLE tellimus ADD CONSTRAINT tellimus_komm
    FOREIGN KEY (kommID)
    REFERENCES komm (kommID);

-- Reference: tellimus_pakkija (table: tellimus)
ALTER TABLE tellimus ADD CONSTRAINT tellimus_pakkija
    FOREIGN KEY (pakkijaID)
    REFERENCES pakkija (pakkijaID);

-- End of file.


INSERT INTO klient (klientID, klient) VALUES
(1, 'Иван Иванов'),
(2, 'Мария Петрова'),
(3, 'Андрес Саар');

INSERT INTO Aadress (AadressID, kl_aadress, klientID) VALUES
(1, 'ул. Центральная, 5', 1),
(2, 'ул. Зеленая, 12', 2),
(3, 'ул. Розовая, 20', 3);

INSERT INTO kommityyp (kommityypID, komityyp) VALUES
(1, 'Шоколадные'),
(2, 'Карамельные'),
(3, 'Фруктовые');

INSERT INTO komm (kommID, Komminimetus, hind, kommityypID, kehvitusaeg) VALUES
(1, 'Шоколадный трюфель', 150, 1, '2025-12-01'),
(2, 'Карамельная тянучка', 100, 2, '2025-11-15'),
(3, 'Апельсиновая карамель', 120, 3, '2026-01-10');

INSERT INTO pakkija (pakkijaID, pakkija) VALUES
(1, 'ООО "Сладкий мир"'),
(2, 'ЗАО "Кондитерский дом"');

INSERT INTO tellimus (tellimusID, AadressID, tell_kuupaev, kommID, kogus, pakkijaID) VALUES
(1, 1, '2025-05-01', 1, 10, 1),
(2, 2, '2025-05-02', 2, 15, 2),
(3, 3, '2025-05-03', 3, 20, 1);

SELECT * FROM klient
SELECT * FROM Aadress
SELECT * FROM komm
SELECT * FROM kommityyp
SELECT * FROM pakkija
SELECT * FROM tellimus

SELECT tellimus.tell_kuupaev, tellimus.kogus, komm.Komminimetus, Aadress.kl_aadress
, pakkija.pakkija FROM tellimus
INNER JOIN komm on komm.kommID = tellimus.kommID
INNER JOIN Aadress on Aadress.AadressID = tellimus.AadressID
INNER JOIN pakkija on pakkija.pakkijaID = tellimus.pakkijaID

SELECT t.tell_kuupaev, t.kogus, k.Komminimetus, a.kl_aadress
, p.pakkija FROM tellimus t
INNER JOIN komm k on k.kommID = t.kommID
INNER JOIN Aadress a on a.AadressID = t.AadressID
INNER JOIN pakkija p on p.pakkijaID = t.pakkijaID
