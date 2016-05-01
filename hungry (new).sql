-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 01 2016 г., 18:00
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

--
-- Дамп данных таблицы `invitations`
--

INSERT INTO `invitations` (`invite_id`, `owner_id`, `dish`, `dish_about`, `meet_time`) VALUES
(1, '1', 'test', 'test', '2016-04-24 00:00:00'),
(2, '1', 'test', 'test', '0000-00-00 00:00:00'),
(3, '1', 'test', 'test', '0000-00-00 00:00:00'),
(4, '1', 'test', 'test', '0000-00-00 00:00:00'),
(5, '1', 'test', 'test', '0000-00-00 00:00:00'),
(6, '1', 'Banana', 'yelow', '0000-00-00 00:00:00'),
(7, '1', 'Banana', 'yelow', '0000-00-00 00:00:00'),
(8, '1', 'Banana', 'yelow', '0000-00-00 00:00:00'),
(9, '1', 'test', 'test', '0000-00-00 00:00:00'),
(10, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(11, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(12, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(13, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(14, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(15, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(16, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(17, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(18, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(19, '14', 'myDish', 'smth here', '0000-00-00 00:00:00'),
(20, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(21, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(22, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(23, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(24, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(25, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00'),
(26, '1', 'new day new food', 'new day new food', '0000-00-00 00:00:00'),
(27, '14', 'new day new food', 'new day new food', '0000-00-00 00:00:00'),
(28, '14', 'new day new food', 'new day new food', '0000-00-00 00:00:00'),
(29, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00'),
(30, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00'),
(31, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00'),
(32, '67', 'smth', 'djs', '0000-00-00 00:00:00'),
(33, '67', 'smth', 'djs', '0000-00-00 00:00:00'),
(34, '67', 'smth', 'djs', '0000-00-00 00:00:00'),
(35, '67', 'smth', 'djs', '0000-00-00 00:00:00'),
(36, '67', 'smth', 'djs', '0000-00-00 00:00:00'),
(37, '67', 'smth', 'djs', '0000-00-00 00:00:00');

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
-- Структура таблицы `tokens`
--

CREATE TABLE IF NOT EXISTS `tokens` (
  `token_id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(8) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `expires` int(12) NOT NULL,
  `app_id` varchar(255) NOT NULL,
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `app_id` (`app_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;

--
-- Дамп данных таблицы `tokens`
--

INSERT INTO `tokens` (`token_id`, `user_id`, `refresh_token`, `expires`, `app_id`) VALUES
(47, '67', '74e28851dd03f5260477d9eb01802aed723c3979', 1493638928, '3'),
(48, '64', 'bc1720679b8e098ec46e9590d49bab1e077c2832', 1493636289, '15'),
(49, '64', '1d836b4c900088dd60608261ce0e58070feeea5c', 1493636439, '4'),
(50, '67', '6b1ac8bfd4039bf24b46df06f89ec16ce33754a6', 1493637786, '7'),
(51, '67', 'ec282487f64bbf77d717457f42dfba7cfbd55c27', 1493639764, '17');

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
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=68 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `surname`, `name`, `gender`, `phone`, `email`, `vk`, `photo`, `dorm_id`, `flat`, `fac_id`, `pass`, `status`, `cookie`, `rating`, `eat`, `fed`, `code`) VALUES
(63, NULL, NULL, NULL, NULL, 'rmaltsev@edu.hse.ru', NULL, NULL, NULL, NULL, NULL, '', NULL, 0, 0, 0, 0, 0),
(64, NULL, NULL, NULL, NULL, 'malcev_r@icloud.com', NULL, NULL, NULL, NULL, NULL, 'ee71fb95a62f4a940968996d3686828f7404ecc8', NULL, 0, 0, 0, 0, 0),
(67, NULL, NULL, NULL, NULL, 'per.amor.maltsev@gmail.com', NULL, NULL, NULL, NULL, NULL, 'bef439874c2622c518f08a08b79f8f0f578bc106', 'owner', 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
