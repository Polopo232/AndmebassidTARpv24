-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 18, 2025 kell 02:05 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `nikiforov_raamat`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addbron` (IN `bron` INT, IN `kas_id` INT)   BEGIN
    INSERT INTO lauabron(laua_bron, kasutaja_id)
    VALUES (bron, kas_id);
    SELECT * FROM lauabron;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addkasutaja` (IN `enimi` VARCHAR(50), IN `pnimi` VARCHAR(50), IN `mail` VARCHAR(150))   BEGIN

    INSERT INTO kasutaja (eesnimi, perenimi, email)
    VALUES (enimi, pnimi, mail);

    SELECT * FROM kasutaja;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addkategooria` (IN `kategooria_nimi` VARCHAR(50))   BEGIN
    INSERT INTO kategooria (kategooria_nimi)
    VALUES (kategooria_nimi);
    SELECT * FROM kategooria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addretsept` (IN `rnimi` VARCHAR(100), IN `kirjeldus` VARCHAR(200), IN `juhend` VARCHAR(500), IN `sisestatud_kp` DATE, IN `kasutaja_id` INT, IN `kategooria_id` INT)   BEGIN
    INSERT INTO retsept (retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
    VALUES (rnimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id);
    SELECT * FROM retsept;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addtehtud` (IN `t_kp` DATE, IN `r_id` INT)   BEGIN
    INSERT INTO tehtud (tehtud_kp, retsept_id)
    VALUES (t_kp, r_id);
    SELECT * FROM tehtud;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delbron` (IN `id` INT)   BEGIN
    SELECT * FROM lauabron;

    DELETE FROM lauabron WHERE laua_id = id;

    SELECT * FROM lauabron;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perenimi` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `eesnimi`, `perenimi`, `email`) VALUES
(1, 'Albert', 'New york', 'albertnewyork@com'),
(2, 'Robert', 'Pris', 'roberparis@com'),
(3, 'Anton', 'Bulka', 'antonbulka@com'),
(4, 'Walter', 'White', 'walterwhite@com'),
(5, 'Nikita', 'Napoleon', 'nikitanapoleon@com');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kategooria`
--

CREATE TABLE `kategooria` (
  `kategooria_id` int(11) NOT NULL,
  `kategooria_nimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kategooria`
--

INSERT INTO `kategooria` (`kategooria_id`, `kategooria_nimi`) VALUES
(1, 'suppid'),
(2, 'magused'),
(3, 'roat'),
(4, 'jookid'),
(5, 'supised');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `koostis`
--

CREATE TABLE `koostis` (
  `koostis_id` int(11) NOT NULL,
  `kogus` int(11) DEFAULT NULL,
  `retsept_retsept_id` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL,
  `yhik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `koostis`
--

INSERT INTO `koostis` (`koostis_id`, `kogus`, `retsept_retsept_id`, `toiduaine_id`, `yhik_id`) VALUES
(6, 10, 1, 1, 1),
(7, 20, 2, 2, 2),
(8, 30, 3, 3, 3),
(9, 40, 4, 4, 4),
(10, 50, 5, 5, 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `lauabron`
--

CREATE TABLE `lauabron` (
  `laua_id` int(11) NOT NULL,
  `laua_bron` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `lauabron`
--

INSERT INTO `lauabron` (`laua_id`, `laua_bron`, `kasutaja_id`) VALUES
(1, '0000-00-00', 1),
(2, '0000-00-00', 2),
(3, '0000-00-00', 3),
(4, '0000-00-00', 4),
(5, '0000-00-00', 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `retsept`
--

CREATE TABLE `retsept` (
  `retsept_id` int(11) NOT NULL,
  `retsept_nimi` varchar(100) DEFAULT NULL,
  `kirjeldus` varchar(200) DEFAULT NULL,
  `juhend` varchar(500) DEFAULT NULL,
  `sisestatud_kp` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL,
  `kategooria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `retsept`
--

INSERT INTO `retsept` (`retsept_id`, `retsept_nimi`, `kirjeldus`, `juhend`, `sisestatud_kp`, `kasutaja_id`, `kategooria_id`) VALUES
(1, 'Pasta Carbonara', 'maitsev', 'kokkama', '0000-00-00', 1, 1),
(2, 'Chicken Curry', 'mitte kõigile', 'küpseta', '0000-00-00', 2, 2),
(3, 'Chocolate Cake', 'maitsev', 'küpseta', '0000-00-00', 3, 3),
(4, 'Caesar Salad', 'mitte kõigile', 'hakkida ja segada', '0000-00-00', 4, 4),
(5, 'Tomato Soup', 'mitte kõigile', 'hakkida ja segada', '0000-00-00', 5, 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tehtud`
--

CREATE TABLE `tehtud` (
  `tehtud_id` int(11) NOT NULL,
  `tehtud_kp` date DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `tehtud`
--

INSERT INTO `tehtud` (`tehtud_id`, `tehtud_kp`, `retsept_id`) VALUES
(1, '0000-00-00', 1),
(2, '0000-00-00', 2),
(3, '0000-00-00', 3),
(4, '0000-00-00', 4),
(5, '0000-00-00', 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `toiduaine`
--

CREATE TABLE `toiduaine` (
  `toiduaine_id` int(11) NOT NULL,
  `toitduaine_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `toiduaine`
--

INSERT INTO `toiduaine` (`toiduaine_id`, `toitduaine_nimi`) VALUES
(1, 'juust'),
(2, 'liha'),
(3, 'piim'),
(4, 'soola'),
(5, 'munad');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `yhik`
--

CREATE TABLE `yhik` (
  `yhik_id` int(11) NOT NULL,
  `yhik_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `yhik`
--

INSERT INTO `yhik` (`yhik_id`, `yhik_nimi`) VALUES
(1, 'ml'),
(2, 'g'),
(3, 'kg'),
(4, 'tl'),
(5, 'sl');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Indeksid tabelile `kategooria`
--
ALTER TABLE `kategooria`
  ADD PRIMARY KEY (`kategooria_id`);

--
-- Indeksid tabelile `koostis`
--
ALTER TABLE `koostis`
  ADD PRIMARY KEY (`koostis_id`),
  ADD KEY `retsept_retsept_id` (`retsept_retsept_id`),
  ADD KEY `toiduaine_id` (`toiduaine_id`),
  ADD KEY `yhik_id` (`yhik_id`);

--
-- Indeksid tabelile `lauabron`
--
ALTER TABLE `lauabron`
  ADD PRIMARY KEY (`laua_id`),
  ADD KEY `kasutaja_id` (`kasutaja_id`);

--
-- Indeksid tabelile `retsept`
--
ALTER TABLE `retsept`
  ADD PRIMARY KEY (`retsept_id`),
  ADD KEY `kasutaja_id` (`kasutaja_id`),
  ADD KEY `kategooria_id` (`kategooria_id`);

--
-- Indeksid tabelile `tehtud`
--
ALTER TABLE `tehtud`
  ADD PRIMARY KEY (`tehtud_id`),
  ADD KEY `retsept_id` (`retsept_id`);

--
-- Indeksid tabelile `toiduaine`
--
ALTER TABLE `toiduaine`
  ADD PRIMARY KEY (`toiduaine_id`);

--
-- Indeksid tabelile `yhik`
--
ALTER TABLE `yhik`
  ADD PRIMARY KEY (`yhik_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `kategooria`
--
ALTER TABLE `kategooria`
  MODIFY `kategooria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT tabelile `koostis`
--
ALTER TABLE `koostis`
  MODIFY `koostis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT tabelile `lauabron`
--
ALTER TABLE `lauabron`
  MODIFY `laua_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `retsept`
--
ALTER TABLE `retsept`
  MODIFY `retsept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `tehtud`
--
ALTER TABLE `tehtud`
  MODIFY `tehtud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `toiduaine`
--
ALTER TABLE `toiduaine`
  MODIFY `toiduaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT tabelile `yhik`
--
ALTER TABLE `yhik`
  MODIFY `yhik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `koostis`
--
ALTER TABLE `koostis`
  ADD CONSTRAINT `koostis_ibfk_1` FOREIGN KEY (`retsept_retsept_id`) REFERENCES `retsept` (`retsept_id`),
  ADD CONSTRAINT `koostis_ibfk_2` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_id`),
  ADD CONSTRAINT `koostis_ibfk_3` FOREIGN KEY (`yhik_id`) REFERENCES `yhik` (`yhik_id`);

--
-- Piirangud tabelile `lauabron`
--
ALTER TABLE `lauabron`
  ADD CONSTRAINT `lauabron_ibfk_1` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`);

--
-- Piirangud tabelile `retsept`
--
ALTER TABLE `retsept`
  ADD CONSTRAINT `retsept_ibfk_1` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`),
  ADD CONSTRAINT `retsept_ibfk_2` FOREIGN KEY (`kategooria_id`) REFERENCES `kategooria` (`kategooria_id`);

--
-- Piirangud tabelile `tehtud`
--
ALTER TABLE `tehtud`
  ADD CONSTRAINT `tehtud_ibfk_1` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
