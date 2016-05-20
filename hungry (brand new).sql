-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 21 2016 г., 00:08
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
  `dorm_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`dorm_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Дамп данных таблицы `dorms`
--

INSERT INTO `dorms` (`dorm_id`, `dorm_name`) VALUES
(1, 'Общежитие №6'),
(2, 'Общежитие №8'),
(3, 'Дубки К1'),
(4, 'Дубки К2'),
(5, 'Дубки К3');

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
  `dish` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dish_about` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `meet_time` datetime NOT NULL,
  PRIMARY KEY (`invite_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

--
-- Дамп данных таблицы `invitations`
--

INSERT INTO `invitations` (`invite_id`, `owner_id`, `dish`, `dish_about`, `meet_time`) VALUES
(57, '75', 'Рыбный стейк', 'Стейк из кеты, замаринованный в соевом соусе', '2016-05-20 21:35:00'),
(58, '77', 'Рис, тушенный с мясом', 'Мясо свинины, рис круглозерый. Потушил в грузинском соусе и аджике', '2016-05-20 22:55:00');

-- --------------------------------------------------------

--
-- Структура таблицы `meets`
--

CREATE TABLE IF NOT EXISTS `meets` (
  `meet_id` int(8) NOT NULL AUTO_INCREMENT,
  `invite_id` varchar(8) NOT NULL,
  `guest_id` varchar(8) NOT NULL,
  `status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`meet_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `meets`
--

INSERT INTO `meets` (`meet_id`, `invite_id`, `guest_id`, `status`) VALUES
(8, '57', '', NULL),
(9, '58', '', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `rating_id` int(8) NOT NULL AUTO_INCREMENT,
  `invite_id` int(8) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

--
-- Дамп данных таблицы `tokens`
--

INSERT INTO `tokens` (`token_id`, `user_id`, `refresh_token`, `expires`, `app_id`) VALUES
(73, '78', '0b15a023664ebcef00aed743ebf3eed95f9f501d', 1495302833, '1'),
(74, '75', '5faacb945e3dc63f881af0fef1f74e453ad634e6', 1495302940, '2'),
(75, '76', '10bc3ecdd94b5dcf84d2e02726a811be37a380a0', 1495303041, '3'),
(76, '77', '2e9d2f647b2a2580145b7e58c3505adb54d0ffe9', 1495303154, '4'),
(77, '75', 'cb845b0697047c9981362a88aacfa53b9e6f6f88', 1495304162, '5'),
(78, '77', '83f6b8ba7c544d51ba8f1ad134db53f646633505', 1495306498, '6'),
(79, '78', 'bf48e12280d7be19c66243758cec89727d089725', 1495306650, '7'),
(80, '76', 'f25406550a42a2271ef318a541fe6b9a5d00a531', 1495309924, '8');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(8) NOT NULL AUTO_INCREMENT,
  `surname` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=79 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `surname`, `name`, `gender`, `phone`, `email`, `vk`, `photo`, `dorm_id`, `flat`, `fac_id`, `pass`, `status`, `cookie`, `rating`, `eat`, `fed`, `code`) VALUES
(75, 'Мальцев', 'Роман', 'м', '89253494090', 'rmaltsev@edu.hse.ru', 'http://vk.com/peramor', NULL, '1', '234(1', '2', '297ecbfa550258008e73565a7438c99dd0343968', 'owner', 0, 0, 0, 0, 0),
(76, 'Матиев', 'Рустем', 'м', '89762342344', 'rmatiev@edu.hse.ru', 'http://vk.com/deadpool777', NULL, '1', '234(1', '1', '1adc205315fa83872b79fa50445e3911c4f34987', 'guest', 0, 0, 0, 0, 0),
(77, 'Лопатов', 'Никита', 'м', '89132582588', 'nlopatov@edu.hse.ru', 'http://vk.com/lopatov_nik_97', NULL, '1', '234(1', '1', '2acabb4fe3b94b5c1c53a640e86480982ca18216', 'owner', 0, 0, 0, 0, 0),
(78, 'Лошкарев', 'Антон', 'м', '89251231231', 'aloshkarev@edu.hse.ru', 'http://vk.com/therealcreogenic', NULL, '1', '234(1', '1', 'f43918af0ab41606c4d736378e063af2cf013046', 'guest', 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
