-- phpMyAdmin SQL Dump

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `zombies`
--

-- --------------------------------------------------------

--
-- Table structure for table `zre_born`
--

CREATE TABLE IF NOT EXISTS `zre_born` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_buildings`
--

CREATE TABLE IF NOT EXISTS `zre_buildings` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `building` varchar(50) CHARACTER SET utf8 NOT NULL,
  `size` int(11) NOT NULL,
  `finish` tinyint(1) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_death`
--

CREATE TABLE IF NOT EXISTS `zre_death` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_kills`
--

CREATE TABLE IF NOT EXISTS `zre_kills` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `kills` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_stats`
--

CREATE TABLE IF NOT EXISTS `zre_stats` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `stat` int(11) NOT NULL,
  `statchange` varchar(10) CHARACTER SET utf8 NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT 'plus',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_support`
--

CREATE TABLE IF NOT EXISTS `zre_support` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `support` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_weather`
--

CREATE TABLE IF NOT EXISTS `zre_weather` (
  `id` double NOT NULL AUTO_INCREMENT,
  `weather` varchar(50) CHARACTER SET utf8 NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zre_wins`
--

CREATE TABLE IF NOT EXISTS `zre_wins` (
  `id` double NOT NULL AUTO_INCREMENT,
  `side` varchar(50) CHARACTER SET utf8 NOT NULL,
  `survivors` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;
