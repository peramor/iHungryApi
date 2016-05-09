-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 09 2016 г., 15:36
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
  `guest_id` varchar(8) NOT NULL,
  `status` varchar(2) NOT NULL,
  PRIMARY KEY (`invite_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Дамп данных таблицы `invitations`
--

INSERT INTO `invitations` (`invite_id`, `owner_id`, `dish`, `dish_about`, `meet_time`, `guest_id`, `status`) VALUES
(1, '1', 'test', 'test', '2016-04-24 00:00:00', '', ''),
(2, '1', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(3, '1', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(4, '1', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(5, '1', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(6, '1', 'Banana', 'yelow', '0000-00-00 00:00:00', '', ''),
(7, '1', 'Banana', 'yelow', '0000-00-00 00:00:00', '', ''),
(8, '1', 'Banana', 'yelow', '0000-00-00 00:00:00', '', ''),
(9, '1', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(10, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(11, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(12, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(13, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(14, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(15, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(16, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(17, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(18, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(19, '14', 'myDish', 'smth here', '0000-00-00 00:00:00', '', ''),
(20, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(21, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(22, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(23, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(24, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(25, '15', 'eggs', 'i love eggs', '0000-00-00 00:00:00', '', ''),
(26, '1', 'new day new food', 'new day new food', '0000-00-00 00:00:00', '', ''),
(27, '14', 'new day new food', 'new day new food', '0000-00-00 00:00:00', '', ''),
(28, '14', 'new day new food', 'new day new food', '0000-00-00 00:00:00', '', ''),
(29, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00', '', ''),
(30, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00', '', ''),
(31, '1', 'Apples', 'green and tasty', '0000-00-00 00:00:00', '', ''),
(32, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(33, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(34, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(35, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(36, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(37, '67', 'smth', 'djs', '0000-00-00 00:00:00', '', ''),
(38, '64', 'test', 'testdfksd', '0000-00-00 00:00:00', '', ''),
(39, '64', 'new', 'new', '0000-00-00 00:00:00', '', ''),
(40, '64', 'test', 'test', '0000-00-00 00:00:00', '', ''),
(41, '64', 'new', 'new', '0000-00-00 00:00:00', '', ''),
(42, '64', 'new', 'new', '0000-00-00 00:00:00', '', ''),
(43, '64', 'sometextsometextsometextsometextsometextsometextsometextsometext', 'sosometextmetextsometextsometextsometextsometextsometextsometextsometextsometextsometextsometext', '0000-00-00 00:00:00', '', '');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=68 ;

--
-- Дамп данных таблицы `tokens`
--

INSERT INTO `tokens` (`token_id`, `user_id`, `refresh_token`, `expires`, `app_id`) VALUES
(47, '64', '512e5cf9c2eab8a2000ad6eea5a7771bb0559629', 1494328570, '3'),
(48, '64', 'bc1720679b8e098ec46e9590d49bab1e077c2832', 1493636289, '15'),
(49, '64', '5bc9edf67468f990c47b2c56f228ad648a87062f', 1494325328, '4'),
(50, '67', '6b1ac8bfd4039bf24b46df06f89ec16ce33754a6', 1493637786, '7'),
(51, '67', 'ec282487f64bbf77d717457f42dfba7cfbd55c27', 1493639764, '17'),
(53, '68', 'fba937524a557f6bdd26fffa2b2085c8cc55d108', 1493843350, '1'),
(60, '69', '9e9a5d9dddac90945f67ab9132bc8f4b5d3db64a', 1493845718, '2'),
(62, '70', '01a41eef6b91076675dc0f1793ca5799a22c617f', 1494104337, '1236'),
(63, '64', '004e33d7a38907cc003e4c11bb7d859144345606', 1494325335, '10'),
(67, '71', 'd6ea664b845f756f3cc1f5362de06986321ecc4b', 1494329191, '100');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=72 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `surname`, `name`, `gender`, `phone`, `email`, `vk`, `photo`, `dorm_id`, `flat`, `fac_id`, `pass`, `status`, `cookie`, `rating`, `eat`, `fed`, `code`) VALUES
(63, NULL, NULL, NULL, NULL, 'rmaltsev@edu.hse.ru', NULL, NULL, NULL, NULL, NULL, '', NULL, 0, 0, 0, 0, 0),
(64, NULL, NULL, NULL, NULL, 'malcev_r@icloud.com', NULL, NULL, NULL, NULL, NULL, 'ee71fb95a62f4a940968996d3686828f7404ecc8', 'owner', 0, 0, 0, 0, 0),
(67, NULL, NULL, NULL, NULL, 'per.amor.maltsev@gmail.com', NULL, NULL, NULL, NULL, NULL, 'bef439874c2622c518f08a08b79f8f0f578bc106', 'owner', 0, 0, 0, 0, 0),
(68, NULL, NULL, NULL, NULL, 'per_amor1997@mail.ru', NULL, NULL, NULL, NULL, NULL, 'a0889ca74c3c07e967a0c4fabb0773d8d2261aa2', NULL, 0, 0, 0, 0, 0),
(69, NULL, NULL, NULL, NULL, 'rmatiev@edu.hse.ru', NULL, NULL, NULL, NULL, NULL, '17c5047b4a197047b3fd14ae21777dd36bf2efbd', NULL, 0, 0, 0, 0, 0),
(70, '???????', NULL, '?', NULL, 'test@mail.ru', NULL, NULL, NULL, NULL, NULL, '99bdf7d9d5e4349c7b5ef6e19cf6cc0d27a70dc5', NULL, 0, 0, 0, 0, 0),
(71, 'Съешь Еще Этих Мягки', 'Съешь Еще Этих Мягки', NULL, NULL, 'test_utf8@mail.ru', NULL, NULL, NULL, NULL, NULL, '47afaa6c1cece689134ffd457bf3c3254d18fe43', NULL, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
