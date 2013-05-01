-- Host: localhost
-- Generation Time: Apr 24, 2013 at 03:32 AM
-- Server version: 5.5.30
-- PHP Version: 5.4.4-14

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT=0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `elecciones_2013`
--
CREATE DATABASE `elecciones_2013` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

GRANT ALL PRIVILEGES ON `elecciones_2013`.* to `elec_user`@localhost identified by 'elecciones_2013';

USE `elecciones_2013`;

-- --------------------------------------------------------

--
-- Table structure for table `candidato`
--
-- Creation: Apr 21, 2013 at 04:37 PM
--

DROP TABLE IF EXISTS `candidato`;
CREATE TABLE IF NOT EXISTS `candidato` (
  `id_candidato` int(11) NOT NULL AUTO_INCREMENT,
  `nom_candidato` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_candidato`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `candidato_partido`
--
-- Creation: Apr 21, 2013 at 05:19 PM
--

DROP TABLE IF EXISTS `candidato_partido`;
CREATE TABLE IF NOT EXISTS `candidato_partido` (
  `id_partido` int(11) NOT NULL,
  `id_candidato` int(11) NOT NULL,
  PRIMARY KEY (`id_partido`,`id_candidato`),
  UNIQUE KEY `id_partido` (`id_partido`),
  KEY `fk_candidato` (`id_candidato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONS FOR TABLE `candidato_partido`:
--   `id_candidato`
--       `candidato` -> `id_candidato`
--   `id_partido`
--       `partido` -> `id_partido`
--

-- --------------------------------------------------------

--
-- Table structure for table `centro`
--
-- Creation: Apr 21, 2013 at 05:23 PM
--

DROP TABLE IF EXISTS `centro`;
CREATE TABLE IF NOT EXISTS `centro` (
  `id_estado` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `id_parroquia` int(11) NOT NULL,
  `id_centro` int(11) NOT NULL,
  `nom_centro` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`,`id_municipio`,`id_parroquia`,`id_centro`),
  KEY `nom_centro` (`nom_centro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elecciones_2013_candidatos`
--
-- Creation: Apr 21, 2013 at 03:15 PM
--

DROP TABLE IF EXISTS `elecciones_2013_candidatos`;
CREATE TABLE IF NOT EXISTS `elecciones_2013_candidatos` (
  `estado` int(10) DEFAULT NULL,
  `municipio` int(10) DEFAULT NULL,
  `parroquia` int(10) DEFAULT NULL,
  `centro` int(10) DEFAULT NULL,
  `mesa` int(10) DEFAULT NULL,
  `candidato` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elecciones_2013_codigos`
--
-- Creation: Apr 21, 2013 at 10:09 PM
--

DROP TABLE IF EXISTS `elecciones_2013_codigos`;
CREATE TABLE IF NOT EXISTS `elecciones_2013_codigos` (
  `estado` int(10) NOT NULL,
  `municipio` int(10) NOT NULL,
  `parroquia` int(10) NOT NULL,
  `centro` int(10) NOT NULL,
  `mesa` int(10) NOT NULL,
  `ubicacion` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elecciones_2013_partidos`
--
-- Creation: Apr 21, 2013 at 03:15 PM
--

DROP TABLE IF EXISTS `elecciones_2013_partidos`;
CREATE TABLE IF NOT EXISTS `elecciones_2013_partidos` (
  `estado` int(10) DEFAULT NULL,
  `municipio` int(10) DEFAULT NULL,
  `parroquia` int(10) DEFAULT NULL,
  `centro` int(10) DEFAULT NULL,
  `mesa` int(10) DEFAULT NULL,
  `partido` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `estado`
--
-- Creation: Apr 22, 2013 at 12:28 AM
--

DROP TABLE IF EXISTS `estado`;
CREATE TABLE IF NOT EXISTS `estado` (
  `id_estado` int(11) NOT NULL,
  `nom_estado` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`),
  KEY `nom_stado` (`nom_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mesa`
--
-- Creation: Apr 21, 2013 at 05:24 PM
--

DROP TABLE IF EXISTS `mesa`;
CREATE TABLE IF NOT EXISTS `mesa` (
  `id_estado` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `id_parroquia` int(11) NOT NULL,
  `id_centro` int(11) NOT NULL,
  `id_mesa` int(11) NOT NULL,
  `nom_mesa` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`,`id_municipio`,`id_parroquia`,`id_centro`,`id_mesa`),
  KEY `nom_mesa` (`nom_mesa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `municipio`
--
-- Creation: Apr 21, 2013 at 05:22 PM
--

DROP TABLE IF EXISTS `municipio`;
CREATE TABLE IF NOT EXISTS `municipio` (
  `id_estado` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `nom_municipio` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`,`id_municipio`),
  KEY `nom_municipio` (`nom_municipio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONS FOR TABLE `municipio`:
--   `id_estado`
--       `estado` -> `id_estado`
--

-- --------------------------------------------------------

--
-- Table structure for table `parroquia`
--
-- Creation: Apr 21, 2013 at 05:23 PM
--

DROP TABLE IF EXISTS `parroquia`;
CREATE TABLE IF NOT EXISTS `parroquia` (
  `id_estado` int(11) NOT NULL,
  `id_municipio` int(11) NOT NULL,
  `id_parroquia` int(11) NOT NULL,
  `nom_parroquia` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_estado`,`id_municipio`,`id_parroquia`),
  KEY `nom_parroquia` (`nom_parroquia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partido`
--
-- Creation: Apr 21, 2013 at 04:38 PM
--

DROP TABLE IF EXISTS `partido`;
CREATE TABLE IF NOT EXISTS `partido` (
  `id_partido` int(11) NOT NULL AUTO_INCREMENT,
  `nom_partido` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_partido`),
  KEY `nom_partido` (`nom_partido`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Table structure for table `votos_candidatos_centro`
--
-- Creation: Apr 22, 2013 at 12:15 AM
--

DROP TABLE IF EXISTS `votos_candidatos_centro`;
CREATE TABLE IF NOT EXISTS `votos_candidatos_centro` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_parroquia` int(10) DEFAULT NULL,
  `id_centro` int(10) DEFAULT NULL,
  `id_candidato` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_candidatos_estado`
--
-- Creation: Apr 22, 2013 at 12:14 AM
--

DROP TABLE IF EXISTS `votos_candidatos_estado`;
CREATE TABLE IF NOT EXISTS `votos_candidatos_estado` (
  `id_estado` int(10) DEFAULT NULL,
  `id_candidato` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_candidatos_mesa`
--
-- Creation: Apr 22, 2013 at 12:15 AM
--

DROP TABLE IF EXISTS `votos_candidatos_mesa`;
CREATE TABLE IF NOT EXISTS `votos_candidatos_mesa` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_parroquia` int(10) DEFAULT NULL,
  `id_centro` int(10) DEFAULT NULL,
  `id_mesa` int(10) DEFAULT NULL,
  `id_candidato` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_candidatos_municipio`
--
-- Creation: Apr 22, 2013 at 12:16 AM
--

DROP TABLE IF EXISTS `votos_candidatos_municipio`;
CREATE TABLE IF NOT EXISTS `votos_candidatos_municipio` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_candidato` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_candidatos_parroquia`
--
-- Creation: Apr 22, 2013 at 12:13 AM
--

DROP TABLE IF EXISTS `votos_candidatos_parroquia`;
CREATE TABLE IF NOT EXISTS `votos_candidatos_parroquia` (
  `id_estado` int(10) NOT NULL,
  `id_municipio` int(10) NOT NULL,
  `id_parroquia` int(10) NOT NULL,
  `id_candidato` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) NOT NULL,
  `porcentaje` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_partidos_centro`
--
-- Creation: Apr 22, 2013 at 12:24 AM
--

DROP TABLE IF EXISTS `votos_partidos_centro`;
CREATE TABLE IF NOT EXISTS `votos_partidos_centro` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_parroquia` int(10) DEFAULT NULL,
  `id_centro` int(10) DEFAULT NULL,
  `id_partido` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_partidos_estado`
--
-- Creation: Apr 22, 2013 at 12:25 AM
--

DROP TABLE IF EXISTS `votos_partidos_estado`;
CREATE TABLE IF NOT EXISTS `votos_partidos_estado` (
  `id_estado` int(10) DEFAULT NULL,
  `id_partido` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_partidos_mesa`
--
-- Creation: Apr 22, 2013 at 12:23 AM
--

DROP TABLE IF EXISTS `votos_partidos_mesa`;
CREATE TABLE IF NOT EXISTS `votos_partidos_mesa` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_parroquia` int(10) DEFAULT NULL,
  `id_centro` int(10) DEFAULT NULL,
  `id_mesa` int(10) DEFAULT NULL,
  `id_partido` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_partidos_municipio`
--
-- Creation: Apr 22, 2013 at 12:25 AM
--

DROP TABLE IF EXISTS `votos_partidos_municipio`;
CREATE TABLE IF NOT EXISTS `votos_partidos_municipio` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_partido` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votos_partidos_parroquia`
--
-- Creation: Apr 22, 2013 at 12:24 AM
--

DROP TABLE IF EXISTS `votos_partidos_parroquia`;
CREATE TABLE IF NOT EXISTS `votos_partidos_parroquia` (
  `id_estado` int(10) DEFAULT NULL,
  `id_municipio` int(10) DEFAULT NULL,
  `id_parroquia` int(10) DEFAULT NULL,
  `id_partido` int(11) NOT NULL DEFAULT '0',
  `votos` int(10) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidato_partido`
--
ALTER TABLE `candidato_partido`
  ADD CONSTRAINT `fk_candidato` FOREIGN KEY (`id_candidato`) REFERENCES `candidato` (`id_candidato`),
  ADD CONSTRAINT `fk_partido` FOREIGN KEY (`id_partido`) REFERENCES `partido` (`id_partido`);

--
-- Constraints for table `centro`
--
ALTER TABLE `centro`
  ADD CONSTRAINT `fk_parroquia` FOREIGN KEY (`id_estado`, `id_municipio`, `id_parroquia`) REFERENCES `parroquia` (`id_estado`, `id_municipio`, `id_parroquia`);

--
-- Constraints for table `mesa`
--
ALTER TABLE `mesa`
  ADD CONSTRAINT `fk_centro` FOREIGN KEY (`id_estado`, `id_municipio`, `id_parroquia`, `id_centro`) REFERENCES `centro` (`id_estado`, `id_municipio`, `id_parroquia`, `id_centro`);

--
-- Constraints for table `municipio`
--
ALTER TABLE `municipio`
  ADD CONSTRAINT `fk_estado` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`);

--
-- Constraints for table `parroquia`
--
ALTER TABLE `parroquia`
  ADD CONSTRAINT `fk_municipio` FOREIGN KEY (`id_estado`, `id_municipio`) REFERENCES `municipio` (`id_estado`, `id_municipio`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
