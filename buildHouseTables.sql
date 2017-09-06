-- phpMyAdmin SQL Dump
-- version 4.0.10.19
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 13, 2017 at 10:47 PM
-- Server version: 5.5.54
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `house`
--
CREATE DATABASE IF NOT EXISTS `house` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `house`;

-- --------------------------------------------------------

--
-- Table structure for table `powerReadings`
--
-- Creation: Apr 02, 2016 at 10:43 PM
--

DROP TABLE IF EXISTS `powerReadings`;
CREATE TABLE IF NOT EXISTS `powerReadings` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `houseTotal` int(11) NOT NULL,
  `waterHeating` int(11) NOT NULL,
  `solarPower` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Power readings in W (house from solar panels and for water heating';
--
-- Database: `measurements`
--
CREATE DATABASE IF NOT EXISTS `measurements` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `measurements`;

-- --------------------------------------------------------

--
-- Table structure for table `bmp180`
--
-- Creation: Apr 12, 2016 at 10:37 PM
--

DROP TABLE IF EXISTS `bmp180`;
CREATE TABLE IF NOT EXISTS `bmp180` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `pressure` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `humidity`
--
-- Creation: Apr 14, 2016 at 10:04 PM
--

DROP TABLE IF EXISTS `humidity`;
CREATE TABLE IF NOT EXISTS `humidity` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `temperature`
--
-- Creation: Mar 28, 2016 at 12:35 PM
--

DROP TABLE IF EXISTS `temperature`;
CREATE TABLE IF NOT EXISTS `temperature` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `sensor_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `temperature_hist`
--
-- Creation: Mar 20, 2017 at 10:59 PM
--

DROP TABLE IF EXISTS `temperature_hist`;
CREATE TABLE IF NOT EXISTS `temperature_hist` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `sensor_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `temperature_tst`
--
-- Creation: Mar 20, 2017 at 10:58 PM
--

DROP TABLE IF EXISTS `temperature_tst`;
CREATE TABLE IF NOT EXISTS `temperature_tst` (
  `dtg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperature` float NOT NULL,
  `sensor_id` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
