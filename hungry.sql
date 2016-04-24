-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Апр 15 2016 г., 13:57
-- Версия сервера: 5.5.46
-- Версия PHP: 5.4.45-0+deb7u2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `hungry`
--

-- --------------------------------------------------------

--
-- Структура таблицы `campuses`
--

CREATE TABLE IF NOT EXISTS `campuses` (
  `campus_id` int(8) NOT NULL AUTO_INCREMENT,
  `campus_name` int(20) NOT NULL,
  `address` int(40) NOT NULL,
  PRIMARY KEY (`campus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `dorms`
--

CREATE TABLE IF NOT EXISTS `dorms` (
  `dorm_id` int(8) NOT NULL AUTO_INCREMENT,
  `dorm_name` varchar(20) NOT NULL,
  `total_pop` int(5) NOT NULL,
  `app_pop` int(5) NOT NULL,
  `app_pop_share` int(5) NOT NULL,
  PRIMARY KEY (`dorm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `faculties`
--

CREATE TABLE IF NOT EXISTS `faculties` (
  `fac_id` int(8) NOT NULL AUTO_INCREMENT,
  `campus_id` int(8) NOT NULL,
  `fac_name` varchar(40) NOT NULL,
  PRIMARY KEY (`fac_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `invitations`
--

CREATE TABLE IF NOT EXISTS `invitations` (
  `invite_id` int(8) NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(8) NOT NULL,
  `dish` varchar(64) NOT NULL,
  `dish_about` varchar(256) NOT NULL,
  `meet_time` datetime NOT NULL,
  PRIMARY KEY (`invite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `meets`
--

CREATE TABLE IF NOT EXISTS `meets` (
  `meet_id` int(8) NOT NULL,
  `invite_id` int(8) NOT NULL,
  `guest_id` int(8) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` int(8) NOT NULL AUTO_INCREMENT,
  `meet_id` int(8) NOT NULL,
  `rating` int(1) NOT NULL,
  `comment` varchar(256) NOT NULL,
  PRIMARY KEY (`rating_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `surname` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `vk` varchar(30) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `dorm_id` varchar(8) DEFAULT NULL,
  `flat` varchar(5) DEFAULT NULL,
  `fac_id` varchar(5) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL,
  `cookie` int(3) NOT NULL DEFAULT '0',
  `rating` int(4) NOT NULL DEFAULT '0',
  `eat` int(4) NOT NULL DEFAULT '0',
  `fed` int(4) NOT NULL DEFAULT '0',
  `code` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `surname`, `name`, `gender`, `phone`, `email`, `vk`, `photo`, `dorm_id`, `flat`, `fac_id`, `pass`, `status`, `cookie`, `rating`, `eat`, `fed`, `code`) VALUES
(1, 'Babaev', 'Mihail', 'm', '1234', 'mmbabaev@gmail.com', 'id1234', '', '', '', '', '', '', 0, 0, 0, 0, 0),
(2, 'user2', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0),
(3, 'user2', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0),
(5, 'asdf', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0),
(6, 'asdf', NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
