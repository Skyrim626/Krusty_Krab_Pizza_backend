-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2023 at 02:00 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza_runner`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `callForDataMart` ()   BEGIN
	SELECT customer_orders.order_id, runner_orders.runner_id, customer_orders.customer_id, pizza_names.pizza_name FROM customer_orders
JOIN runner_orders
ON runner_orders.order_id = customer_orders.order_id
JOIN pizza_names
ON pizza_names.pizza_id = customer_orders.pizza_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get20RecentlyRegistered` ()   BEGIN
	SELECT customers.customer_id, customers.first_name, customers.last_name, customers.email, customers.registration_date FROM customers ORDER BY registration_date DESC LIMIT 20;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRunnerOrders` (IN `r_runner_id` INT)   BEGIN 

	SELECT * FROM runner_orders
    WHERE runner_orders.runner_id = r_runner_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRunnersCompletedOrders` ()   BEGIN
	SELECT runner_orders.runner_id, COUNT(runner_orders.order_id) AS 'completed_orders' 
    FROM runner_orders 
    WHERE runner_orders.cancellation IS NULL OR runner_orders.cancellation = '' 
    GROUP BY(runner_orders.runner_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTopPizzas` ()   BEGIN
	
    SELECT pizza_names.pizza_id, pizza_names.pizza_name, COUNT(customer_orders.pizza_id) as 'Total_Orders' FROM customer_orders
    JOIN pizza_names ON pizza_names.pizza_id = customer_orders.pizza_id
    GROUP BY (pizza_names.pizza_id)
    ORDER BY Total_Orders DESC
    LIMIT 10;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `most_ordered_pizza_in_a_day` (IN `p_OrderDate` DATE)   BEGIN
    SELECT p.pizza_name, COUNT(cu.order_id) as 'num_of_pizzas_ordered'
    FROM pizza_names p
    JOIN customer_orders cu
    ON p.pizza_id = cu.pizza_id
    WHERE DATE(cu.order_date) = p_OrderDate
    GROUP BY p.pizza_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `number_of_customer_orders` ()   BEGIN
	SELECT DISTINCT customer_id, COUNT(DISTINCT order_id) AS 'num_of_orders', exclusions, extras, order_date
FROM customer_orders
GROUP BY customer_id
ORDER BY num_of_orders;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_customer_orders_in_a_day` (IN `p_OrderDate` DATE)   BEGIN

SELECT DATE(order_date) as 'order_date', COUNT(order_id) as 'num_of_orders'
FROM customer_orders
WHERE DATE(order_date) = p_OrderDate;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_customer_orders_per_day` ()   BEGIN 

SELECT DISTINCT DATE(order_date) as 'order_date', COUNT(order_id) as 'num_of_orders'
FROM customer_orders
GROUP BY DATE(order_date)
ORDER BY order_date DESC;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `address`, `created_at`) VALUES
(1, 'admin123', 'admin123', 'admin@email.com', 'adminAddressUniversal', '2023-06-07 03:24:03');

-- --------------------------------------------------------

--
-- Table structure for table `audit_table`
--

CREATE TABLE `audit_table` (
  `order_id` int(11) DEFAULT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `time_cancellation` time DEFAULT NULL,
  `date_of_cancellation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `audit_table`
--

INSERT INTO `audit_table` (`order_id`, `runner_id`, `time_cancellation`, `date_of_cancellation`) VALUES
(6, 3, '11:07:50', '2023-06-02'),
(6, 3, '11:07:50', '2023-06-02'),
(63, 32, '07:19:27', '2023-06-24'),
(64, 33, '07:19:27', '2023-06-24'),
(66, 35, '07:19:27', '2023-06-24'),
(67, 36, '07:19:27', '2023-06-24'),
(68, 33, '07:19:27', '2023-06-24'),
(69, 38, '07:19:27', '2023-06-24'),
(70, 32, '07:19:27', '2023-06-24'),
(71, 36, '07:19:27', '2023-06-24'),
(72, 41, '07:19:27', '2023-06-24'),
(73, 34, '07:19:27', '2023-06-24'),
(75, 38, '07:19:27', '2023-06-24'),
(76, 33, '07:19:27', '2023-06-24'),
(77, 46, '07:19:27', '2023-06-24'),
(78, 32, '07:19:27', '2023-06-24'),
(79, 36, '07:19:27', '2023-06-24'),
(80, 49, '07:19:27', '2023-06-24'),
(81, 50, '07:19:27', '2023-06-24'),
(82, 51, '07:19:27', '2023-06-24'),
(83, 33, '07:19:27', '2023-06-24'),
(85, 35, '07:19:27', '2023-06-24'),
(86, 36, '07:19:27', '2023-06-24'),
(87, 33, '07:19:27', '2023-06-24'),
(88, 38, '07:19:27', '2023-06-24'),
(89, 32, '07:19:27', '2023-06-24'),
(90, 36, '07:19:27', '2023-06-24'),
(91, 41, '07:19:27', '2023-06-24'),
(92, 34, '07:19:27', '2023-06-24'),
(94, 38, '07:19:27', '2023-06-24'),
(95, 33, '07:19:27', '2023-06-24'),
(96, 46, '07:19:27', '2023-06-24'),
(97, 32, '07:19:27', '2023-06-24'),
(98, 36, '07:19:27', '2023-06-24'),
(99, 49, '07:19:27', '2023-06-24'),
(100, 50, '07:19:27', '2023-06-24'),
(101, 51, '07:19:27', '2023-06-24'),
(102, 33, '07:19:27', '2023-06-24'),
(104, 35, '07:19:27', '2023-06-24'),
(105, 36, '07:19:27', '2023-06-24'),
(106, 33, '07:19:27', '2023-06-24'),
(107, 38, '07:19:27', '2023-06-24'),
(108, 32, '07:19:27', '2023-06-24'),
(109, 36, '07:19:27', '2023-06-24'),
(110, 41, '07:19:27', '2023-06-24'),
(111, 34, '07:19:27', '2023-06-24');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(25) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  `registration_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `registration_date`) VALUES
(1, 'Marc', 'Flipsen', 'mflipsen0@tinyurl.com', 'atguhwhikUD773Kns+', '184-465-9080', '121.31.19.174', 'Labuhankananga', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(2, 'Flin', 'Dessent', 'fdessent1@hugedomains.com', 'ukgntqgylZO935`cw(ue)nL\"Y', '486-917-1316', '3.246.123.179', 'Paris 13', 'Île-de-France', '75638 CEDEX 13', NULL, '2023-06-12 14:20:20'),
(3, 'Hailee', 'Joslow', 'hjoslow2@drupal.org', 'huqxkcsxoWR2629KoFqjzJe8}', '692-647-2879', '104.137.42.113', 'Fortaleza', NULL, '60000-000', NULL, '2023-06-12 14:20:20'),
(4, 'Aindrea', 'Lunnon', 'alunnon3@moonfruit.com', 'csesstzbxBQ951QKdZ', '654-334-0178', '37.244.7.48', 'Geshan', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(5, 'Vassili', 'Ludmann', 'vludmann4@google.co.uk', 'vxneyxucnLI547okD', '780-195-8957', '124.210.87.54', 'Mesopotam', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(6, 'Jennie', 'Winspire', 'jwinspire5@state.gov', 'zxjabdozfAM221Hc4!3a5su', '189-742-6922', '245.130.120.105', 'Kultayevo', NULL, '614520', NULL, '2023-06-12 14:20:20'),
(7, 'Kevina', 'Enticknap', 'kenticknap6@intel.com', 'lzdhnhtwkWX571XoQ_T8Luq$%', '444-970-9489', '169.143.134.225', 'Unanu', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(8, 'Cortie', 'Snoden', 'csnoden7@bandcamp.com', 'xrhtslacvDG619\"%Y%5VPGuBD', '167-272-4049', '107.42.118.115', 'Yangji', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(9, 'Rhetta', 'Kettles', 'rkettles8@oakley.com', 'tcbjvsiveEZ512wJM8A(=V>!N', '579-551-0975', '37.74.154.250', 'Chadi', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(10, 'Darren', 'O\'Corrigane', 'docorrigane9@canalblog.com', 'fbvansqnaGY134O72Db6uGYA', '269-871-1246', '33.108.145.176', 'Khoroshëvo-Mnevniki', NULL, '676280', NULL, '2023-06-12 14:20:20'),
(11, 'Morgan', 'Amphlett', 'mamphletta@google.fr', 'fiudxvuvjKD892/!/pu5', '600-738-0795', '131.225.106.48', 'Kolomyagi', NULL, '198264', NULL, '2023-06-12 14:20:20'),
(12, 'Katti', 'Rainforth', 'krainforthb@mac.com', 'drstpqpkjWA0767', '200-393-5672', '141.3.222.201', 'Drayton Valley', 'Alberta', 'T7A', NULL, '2023-06-12 14:20:20'),
(13, 'Eugenia', 'Saint', 'esaintc@g.co', 'fucfneeiiQM7897$i.2<DN', '950-277-4588', '21.36.14.175', 'Bordeaux', 'Aquitaine', '33100', NULL, '2023-06-12 14:20:20'),
(14, 'Fielding', 'Haye', 'fhayed@geocities.com', 'tnlekyjwyLO206842NBC+IT', '461-561-2023', '109.178.46.214', 'Huaikan', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(15, 'Alanna', 'Fomichkin', 'afomichkine@howstuffworks.com', 'fxqhbvtofOO4146_1/c4qgRi8', '585-337-3440', '6.212.60.9', 'Rochester', 'New York', '14604', NULL, '2023-06-12 14:20:20'),
(16, 'Alejoa', 'Falco', 'afalcof@pcworld.com', 'kltejvquhSP3390am_Qw#lx', '921-823-1331', '28.194.158.81', 'Vorontsovka', NULL, '353664', NULL, '2023-06-12 14:20:20'),
(17, 'Edyth', 'Lindmark', 'elindmarkg@google.it', 'wjadrkihoOR486`!', '300-486-1063', '62.70.14.199', 'Ansheng', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(18, 'Ingrim', 'Cockitt', 'icockitth@blogspot.com', 'jgoxovgtiFE151(m#7', '366-905-3238', '60.157.155.234', 'Tanshan', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(19, 'Vi', 'Carneck', 'vcarnecki@utexas.edu', 'soodqqymyKV136li|zr', '792-776-5075', '92.158.155.127', 'Concordia', NULL, '3200', NULL, '2023-06-12 14:20:20'),
(20, 'Gray', 'Tafani', 'gtafanij@virginia.edu', 'zfriybvpqWA7324Pt1wqx9u_9', '155-508-3283', '152.220.116.225', 'Norrköping', 'Östergötland', '602 34', NULL, '2023-06-12 14:20:20'),
(21, 'Elizabet', 'Keaton', 'ekeatonk@hugedomains.com', 'llicsdknyDH291~n#_P!~%\'Jk', '319-189-1446', '10.148.110.33', 'Kamieniec Ząbkowicki', NULL, '57-230', NULL, '2023-06-12 14:20:20'),
(29, 'Liam', 'Klagge', 'lklagges@myspace.com', 'sscfyzryvSB407vN1cgQ#JV3', '408-663-7605', '205.147.240.236', 'Niitsu-honchō', NULL, '959-1855', NULL, '2023-06-12 14:20:20'),
(30, 'Kane', 'Brisland', 'kbrislandt@bloglines.com', 'yatuxltizDI084UyBry', '961-416-4601', '41.198.185.236', 'Vitória de Santo Antão', NULL, '55600-000', NULL, '2023-06-12 14:20:20'),
(31, 'Jameson', 'Zouch', 'jzouchu@utexas.edu', 'qiojwemcqWA945IyI{S4~B', '633-634-9399', '231.29.140.15', 'Kanzaki', NULL, '842-0001', NULL, '2023-06-12 14:20:20'),
(32, 'Ronalda', 'McLagain', 'rmclagainv@msn.com', 'bqukdkxpiOB8323laky=B9~o', '179-781-9954', '118.215.137.58', 'Infanta', NULL, '4336', NULL, '2023-06-12 14:20:20'),
(33, 'Aprilette', 'Hekkert', 'ahekkertw@slashdot.org', 'tsieyrukuZS454o<CFjZ_,,\'', '381-942-6979', '138.243.247.53', 'Daxin', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(34, 'Darby', 'Morling', 'dmorlingx@quantcast.com', 'enuwzpjncPQ7071D0RKVHO', '542-262-5944', '222.37.46.217', 'Sanchang', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(35, 'Katharyn', 'Flanagan', 'kflanagany@histats.com', 'cwnzbvkexRA546E`u', '560-783-7163', '161.162.88.24', 'Wangmo', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(36, 'Ganny', 'Kernermann', 'gkernermannz@storify.com', 'hcuueysjnQC068fNa07g', '108-732-3555', '133.233.253.217', 'Letovice', NULL, '679 61', NULL, '2023-06-12 14:20:20'),
(37, 'Guy', 'Swaby', 'gswaby10@discovery.com', 'rzrrkrocyJL570agn', '433-322-8647', '118.135.58.228', 'Jingxiyuan', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(38, 'Wyn', 'Carous', 'wcarous11@ehow.com', 'ffyxtamnrQE861F8csc0Yl', '549-434-6944', '64.254.183.31', 'Kétou', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(39, 'Danni', 'Bellson', 'dbellson12@shutterfly.com', 'zahnuvuudEN887sLkvlDp+', '176-195-8784', '11.7.75.59', 'Rengasdengklok', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(40, 'Ula', 'Leile', 'uleile13@xinhuanet.com', 'yhmjutssnRT377{py7|=t#', '398-808-5712', '95.119.128.42', 'Shenshu', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(41, 'Bridgette', 'Gaw', 'bgaw14@ed.gov', 'drljfksaeEY339tn\"#c9QM(lD', '799-687-0230', '152.224.195.155', 'La Paz Centro', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(42, 'Adrea', 'Jammet', 'ajammet15@thetimes.co.uk', 'roagaqnrrKR957BA}6', '674-550-3352', '129.51.110.85', 'Santos Evos', 'Viseu', '3505-318', NULL, '2023-06-12 14:20:20'),
(43, 'Brody', 'Demoge', 'bdemoge16@wired.com', 'lpfxyochvRQ026pjQ8\",*QOLh', '850-634-7558', '157.2.29.188', 'La Cumbre', NULL, '760518', NULL, '2023-06-12 14:20:20'),
(44, 'Creighton', 'Kunisch', 'ckunisch17@nydailynews.com', 'cdsgurgeyFR5739TTL', '155-145-7287', '218.51.235.46', 'Safonovo', NULL, '308510', NULL, '2023-06-12 14:20:20'),
(45, 'Alano', 'Miliffe', 'amiliffe18@phpbb.com', 'rnduckyulRG937HsP$MfBBGh', '345-712-2674', '167.8.141.92', 'Gracias', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(46, 'Kora', 'Pedlow', 'kpedlow19@blog.com', 'zroxfgicrFV432Qm=xOD~xw_', '231-526-2736', '11.66.60.137', 'Stavanger', 'Rogaland', '4025', NULL, '2023-06-12 14:20:20'),
(47, 'Alleen', 'Mayze', 'amayze1a@spiegel.de', 'yxdunsvxzZE569+WvNY=`q>%G', '223-374-8716', '218.213.214.186', 'Zernograd', NULL, '347743', NULL, '2023-06-12 14:20:20'),
(48, 'Kattie', 'Mouat', 'kmouat1b@utexas.edu', 'sutzuqaczCZ194m6tor&agSVY', '274-616-8060', '18.110.107.181', 'Kemiri', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(49, 'Angil', 'Tomsen', 'atomsen1c@youtube.com', 'sopoxxgkrUO115h8O}nIY~m4p', '201-102-5576', '62.176.94.196', 'Zhaoqing', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(50, 'Arlene', 'Dulinty', 'adulinty1d@illinois.edu', 'metlloperJA208bV5QT', '293-439-5119', '134.201.209.244', 'Uyskoye', NULL, '456470', NULL, '2023-06-12 14:20:20'),
(51, 'Parsifal', 'Stanbra', 'pstanbra1e@discovery.com', 'ifrejhydpOC5263\'', '812-721-6989', '198.223.134.27', 'Tangjia', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(52, 'Terri', 'Tramel', 'ttramel1f@jiathis.com', 'dxxfjkiefAS2871S(Q?0%C+=r', '439-529-2708', '93.27.253.180', 'Basqal', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(53, 'Putnem', 'Bramley', 'pbramley1g@google.com.au', 'kabqlkgkdBK9360', '299-338-6454', '52.57.33.241', 'Nova Viçosa', NULL, '45920-000', NULL, '2023-06-12 14:20:20'),
(54, 'Kira', 'Coopper', 'kcoopper1h@hubpages.com', 'uasqszdjgUH691Aa6}', '964-696-9206', '112.33.94.196', 'Buriram', NULL, '31180', NULL, '2023-06-12 14:20:20'),
(55, 'Kendall', 'Randle', 'krandle1i@sitemeter.com', 'vdvgtfahnET717URJU=', '260-181-5538', '8.54.246.103', 'Tagoloan', NULL, '9222', NULL, '2023-06-12 14:20:20'),
(56, 'Briny', 'Blueman', 'bblueman1j@hatena.ne.jp', 'ouxitddnoMB97188', '860-625-5674', '130.218.209.175', 'Aūa', NULL, '96799', NULL, '2023-06-12 14:20:20'),
(57, 'Taffy', 'Barthelme', 'tbarthelme1k@ca.gov', 'ubsuokambYN595\"H_', '715-344-9423', '27.29.239.2', 'Takāb', NULL, NULL, NULL, '2023-06-12 14:20:20'),
(58, 'Hans Zin ', 'Sanchez', 'sanchez@Gologolo.om', 'sanchez123', '777-6666-1111', 'lapasan', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 10:59:35'),
(59, 'Hans Zin ', 'Sanchez', 'sanchez@Gologolo.om', 'sanchez123', '777-6666-1111', 'lapasan', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:01:55'),
(60, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:02:34'),
(61, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:03:24'),
(62, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:03:53'),
(63, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:05:12'),
(64, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:08:02'),
(65, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:08:04'),
(66, 'Hello', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:12:11'),
(67, 'Hel', 'World', 'world@gmail.com', '12345', '7777-111-2222', 'UwU', 'CDO', 'Lapasan', '9000', 'Philippines', '2023-06-23 11:12:57'),
(68, 'Karl', 'Marx', 'marxZuckerber@yahoo.com', 'karl123', '0000-1111-2222', 'Address 5801', 'CDO', 'United', '9000', 'Philippines', '2023-06-23 11:23:09'),
(69, 'Hector', 'Barbossa', 'UwU@gmail.com', 'justKillTheCode', '123456789', 'Lapsan', 'cagayan', 'meow', 'f678', 'USA', '2023-06-23 11:30:19'),
(70, 'Hector ', 'Dragon', 'Dragon@gmaill.com', '123', '9999-999-9999', 'Lapasan', 'Wadiya', 'New Zealand', '8000', 'MeowWorld', '2023-06-23 11:39:47');

-- --------------------------------------------------------

--
-- Table structure for table `customer_orders`
--

CREATE TABLE `customer_orders` (
  `order_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `pizza_id` int(11) DEFAULT NULL,
  `exclusions` varchar(4) DEFAULT NULL,
  `extras` varchar(4) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_orders`
--

INSERT INTO `customer_orders` (`order_id`, `customer_id`, `pizza_id`, `exclusions`, `extras`, `order_date`) VALUES
(1, 101, 1, '', '', '2021-01-01 18:05:02'),
(2, 101, 1, '', '', '2021-01-01 19:00:52'),
(3, 102, 1, '', '', '2021-01-02 23:51:23'),
(3, 102, 2, '', 'NaN', '2021-01-02 23:51:23'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 2, '4', '', '2021-01-04 13:23:46'),
(5, 104, 1, NULL, '1', '2021-01-08 21:00:29'),
(1, 101, 1, '', '', '2021-01-01 18:05:02'),
(2, 101, 1, '', '', '2021-01-01 19:00:52'),
(3, 102, 1, '', '', '2021-01-02 23:51:23'),
(3, 102, 2, '', 'NaN', '2021-01-02 23:51:23'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 1, '4', '', '2021-01-04 13:23:46'),
(4, 103, 2, '4', '', '2021-01-04 13:23:46'),
(5, 104, 1, NULL, '1', '2021-01-08 21:00:29'),
(63, 1, 10, 'none', 'extr', '2023-06-24 07:42:59'),
(64, 2, 12, 'none', 'baco', '2023-06-24 07:42:59'),
(65, 3, 15, 'oliv', 'mush', '2023-06-24 07:42:59'),
(66, 4, 11, 'none', 'extr', '2023-06-24 07:42:59'),
(67, 5, 18, 'onio', 'pepp', '2023-06-24 07:42:59'),
(68, 6, 14, 'none', 'oliv', '2023-06-24 07:42:59'),
(69, 7, 13, 'none', 'extr', '2023-06-24 07:42:59'),
(70, 8, 16, 'none', 'pepp', '2023-06-24 07:42:59'),
(71, 9, 19, 'none', 'extr', '2023-06-24 07:42:59'),
(72, 10, 10, 'none', 'mush', '2023-06-24 07:42:59'),
(73, 11, 12, 'none', 'baco', '2023-06-24 07:42:59'),
(74, 12, 11, 'none', 'extr', '2023-06-24 07:42:59'),
(75, 13, 14, 'none', 'pepp', '2023-06-24 07:42:59'),
(76, 14, 13, 'none', 'oliv', '2023-06-24 07:42:59'),
(77, 15, 15, 'onio', 'mush', '2023-06-24 07:42:59'),
(78, 16, 16, 'none', 'extr', '2023-06-24 07:42:59'),
(79, 17, 17, 'none', 'pepp', '2023-06-24 07:42:59'),
(80, 18, 20, 'none', 'baco', '2023-06-24 07:42:59'),
(81, 19, 10, 'none', 'extr', '2023-06-24 07:42:59'),
(82, 20, 13, 'none', 'oliv', '2023-06-24 07:42:59'),
(83, 21, 11, 'none', 'extr', '2023-06-24 07:42:59'),
(84, 22, 14, 'none', 'mush', '2023-06-24 07:42:59'),
(85, 23, 15, 'onio', 'pepp', '2023-06-24 07:42:59'),
(86, 24, 18, 'none', 'extr', '2023-06-24 07:42:59'),
(87, 25, 16, 'none', 'pepp', '2023-06-24 07:42:59'),
(88, 26, 19, 'none', 'baco', '2023-06-24 07:42:59'),
(89, 27, 12, 'none', 'extr', '2023-06-24 07:42:59'),
(90, 28, 11, 'none', 'oliv', '2023-06-24 07:42:59'),
(91, 29, 13, 'none', 'mush', '2023-06-24 07:42:59'),
(92, 30, 14, 'none', 'pepp', '2023-06-24 07:42:59'),
(93, 31, 17, 'none', 'extr', '2023-06-24 07:42:59'),
(94, 32, 20, 'none', 'baco', '2023-06-24 07:42:59'),
(95, 33, 10, 'none', 'extr', '2023-06-24 07:42:59'),
(96, 34, 12, 'none', 'oliv', '2023-06-24 07:42:59'),
(97, 35, 11, 'none', 'mush', '2023-06-24 07:42:59'),
(98, 36, 13, 'none', 'pepp', '2023-06-24 07:42:59'),
(99, 37, 15, 'onio', 'extr', '2023-06-24 07:42:59'),
(100, 38, 16, 'none', 'pepp', '2023-06-24 07:42:59'),
(101, 39, 19, 'none', 'baco', '2023-06-24 07:42:59'),
(102, 40, 14, 'none', 'extr', '2023-06-24 07:42:59'),
(103, 41, 10, 'none', 'oliv', '2023-06-24 07:42:59'),
(104, 42, 11, 'none', 'mush', '2023-06-24 07:42:59'),
(105, 43, 12, 'none', 'pepp', '2023-06-24 07:42:59'),
(106, 44, 17, 'none', 'extr', '2023-06-24 07:42:59'),
(107, 45, 18, 'none', 'baco', '2023-06-24 07:42:59'),
(108, 46, 15, 'onio', 'extr', '2023-06-24 07:42:59'),
(109, 47, 16, 'none', 'oliv', '2023-06-24 07:42:59'),
(110, 48, 13, 'none', 'mush', '2023-06-24 07:42:59'),
(111, 49, 14, 'none', 'pepp', '2023-06-24 07:42:59'),
(112, 50, 19, 'none', 'extr', '2023-06-24 07:42:59'),
(63, 1, 10, 'none', 'extr', '2023-06-24 07:45:58'),
(63, 1, 10, 'none', 'extr', '2023-06-24 07:46:31'),
(64, 2, 12, 'none', 'baco', '2023-06-24 07:46:31'),
(65, 3, 15, 'oliv', 'mush', '2023-06-24 07:46:31'),
(66, 4, 11, 'none', 'extr', '2023-06-24 07:46:31'),
(67, 5, 18, 'onio', 'pepp', '2023-06-24 07:46:31'),
(68, 6, 14, 'none', 'oliv', '2023-06-24 07:46:31'),
(69, 7, 13, 'none', 'extr', '2023-06-24 07:46:31'),
(70, 8, 16, 'none', 'pepp', '2023-06-24 07:46:31'),
(71, 9, 19, 'none', 'extr', '2023-06-24 07:46:31'),
(72, 10, 10, 'none', 'mush', '2023-06-24 07:46:31'),
(73, 11, 12, 'none', 'baco', '2023-06-24 07:46:31'),
(74, 12, 11, 'none', 'extr', '2023-06-24 07:46:31'),
(75, 13, 14, 'none', 'pepp', '2023-06-24 07:46:31'),
(76, 14, 13, 'none', 'oliv', '2023-06-24 07:46:31'),
(77, 15, 15, 'onio', 'mush', '2023-06-24 07:46:31'),
(78, 16, 16, 'none', 'extr', '2023-06-24 07:46:31'),
(79, 17, 17, 'none', 'pepp', '2023-06-24 07:46:31'),
(80, 18, 20, 'none', 'baco', '2023-06-24 07:46:31'),
(81, 19, 10, 'none', 'extr', '2023-06-24 07:46:31'),
(82, 20, 13, 'none', 'oliv', '2023-06-24 07:46:31'),
(83, 21, 11, 'none', 'extr', '2023-06-24 07:46:31'),
(84, 22, 14, 'none', 'mush', '2023-06-24 07:46:31'),
(85, 23, 15, 'onio', 'pepp', '2023-06-24 07:46:31'),
(86, 24, 18, 'none', 'extr', '2023-06-24 07:46:31'),
(87, 25, 16, 'none', 'pepp', '2023-06-24 07:46:31'),
(88, 26, 19, 'none', 'baco', '2023-06-24 07:46:31'),
(89, 27, 12, 'none', 'extr', '2023-06-24 07:46:31'),
(90, 28, 11, 'none', 'oliv', '2023-06-24 07:46:31'),
(91, 29, 13, 'none', 'mush', '2023-06-24 07:46:31'),
(92, 30, 14, 'none', 'pepp', '2023-06-24 07:46:31'),
(93, 31, 17, 'none', 'extr', '2023-06-24 07:46:31'),
(94, 32, 20, 'none', 'baco', '2023-06-24 07:46:31'),
(95, 33, 10, 'none', 'extr', '2023-06-24 07:46:31'),
(96, 34, 12, 'none', 'oliv', '2023-06-24 07:46:31'),
(97, 35, 11, 'none', 'mush', '2023-06-24 07:46:31'),
(98, 36, 13, 'none', 'pepp', '2023-06-24 07:46:31'),
(99, 37, 15, 'onio', 'extr', '2023-06-24 07:46:31'),
(100, 38, 16, 'none', 'pepp', '2023-06-24 07:46:31'),
(101, 39, 19, 'none', 'baco', '2023-06-24 07:46:31'),
(102, 40, 14, 'none', 'extr', '2023-06-24 07:46:31'),
(103, 41, 10, 'none', 'oliv', '2023-06-24 07:46:31'),
(104, 42, 11, 'none', 'mush', '2023-06-24 07:46:31'),
(105, 43, 12, 'none', 'pepp', '2023-06-24 07:46:31'),
(106, 44, 17, 'none', 'extr', '2023-06-24 07:46:31'),
(107, 45, 18, 'none', 'baco', '2023-06-24 07:46:31'),
(108, 46, 15, 'onio', 'extr', '2023-06-24 07:46:31'),
(109, 47, 16, 'none', 'oliv', '2023-06-24 07:46:31'),
(110, 48, 13, 'none', 'mush', '2023-06-24 07:46:31'),
(111, 49, 14, 'none', 'pepp', '2023-06-24 07:46:31'),
(112, 50, 19, 'none', 'extr', '2023-06-24 07:46:31');

-- --------------------------------------------------------

--
-- Table structure for table `denormalized_table`
--

CREATE TABLE `denormalized_table` (
  `order_id` int(11) DEFAULT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `pizza_id` int(11) NOT NULL DEFAULT 0,
  `pizza_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `denormalized_table`
--

INSERT INTO `denormalized_table` (`order_id`, `runner_id`, `customer_id`, `pizza_id`, `pizza_name`) VALUES
(1, 1, 101, 1, 'Meat Lovers'),
(2, 1, 101, 1, 'Meat Lovers'),
(3, 1, 102, 1, 'Meat Lovers'),
(3, 1, 102, 2, 'Vegetarian'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 2, 'Vegetarian'),
(5, 3, 104, 1, 'Meat Lovers'),
(1, 1, 101, 1, 'Meat Lovers'),
(2, 1, 101, 1, 'Meat Lovers'),
(3, 1, 102, 1, 'Meat Lovers'),
(3, 1, 102, 2, 'Vegetarian'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 1, 'Meat Lovers'),
(4, 2, 103, 2, 'Vegetarian'),
(5, 3, 104, 1, 'Meat Lovers');

-- --------------------------------------------------------

--
-- Table structure for table `pizza_names`
--

CREATE TABLE `pizza_names` (
  `pizza_id` int(11) NOT NULL,
  `pizza_name` text DEFAULT NULL,
  `pizza_image` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pizza_names`
--

INSERT INTO `pizza_names` (`pizza_id`, `pizza_name`, `pizza_image`) VALUES
(1, 'Meat Lovers', NULL),
(2, 'Vegetarian', NULL),
(10, 'Hawaiian Pizza', ''),
(11, 'Mozarella Cheese', ''),
(12, 'Ham and Cheese Pizzawrap', ''),
(13, 'Spam Hawaiian Pizzawrap', ''),
(14, 'Chorizo Pepperoni Pizzawrap', ''),
(15, 'Spam Hawaiian Pizzawrap Value Meal', ''),
(16, 'Chorizo Pepperoni Pizzawrap Value Meal', ''),
(17, 'Chowking Pizza', NULL),
(18, 'Margherita', ''),
(19, 'Pepperoni', ''),
(20, 'Hawaiian', ''),
(21, 'Mushroom', ''),
(22, 'BBQ Chicken', ''),
(23, 'Supreme', ''),
(24, 'Veggie Delight', ''),
(25, 'Four Cheese', ''),
(26, 'Spinach Alfredo', ''),
(27, 'Mediterranean', ''),
(28, 'Buffalo Chicken', ''),
(29, 'Meat Feast', ''),
(30, 'Capricciosa', ''),
(31, 'Barbecue Bacon', ''),
(32, 'Truffle Mushroom', ''),
(33, 'Chicken Tikka', ''),
(34, 'Greek', ''),
(35, 'Seafood', ''),
(36, 'Vegan', ''),
(37, 'Spicy Italian', '');

--
-- Triggers `pizza_names`
--
DELIMITER $$
CREATE TRIGGER `after_insert_on_pizza_names` AFTER INSERT ON `pizza_names` FOR EACH ROW BEGIN
		
   INSERT INTO pizza_recipes(pizza_id) VALUES (NEW.pizza_id);     
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pizza_recipes`
--

CREATE TABLE `pizza_recipes` (
  `pizza_id` int(11) NOT NULL,
  `toppings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pizza_recipes`
--

INSERT INTO `pizza_recipes` (`pizza_id`, `toppings`) VALUES
(1, '1,2,3,4,5,6,7,8,10'),
(2, '4,6,7,9,11,12'),
(17, NULL),
(18, NULL),
(19, NULL),
(20, NULL),
(21, NULL),
(22, NULL),
(23, NULL),
(24, NULL),
(25, NULL),
(26, NULL),
(27, NULL),
(28, NULL),
(29, NULL),
(30, NULL),
(31, NULL),
(32, NULL),
(33, NULL),
(34, NULL),
(35, NULL),
(36, NULL),
(37, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pizza_toppings`
--

CREATE TABLE `pizza_toppings` (
  `topping_id` int(11) NOT NULL,
  `topping_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pizza_toppings`
--

INSERT INTO `pizza_toppings` (`topping_id`, `topping_name`) VALUES
(741, 'Bacon'),
(742, 'BBQ Sauce'),
(743, 'Beef'),
(744, 'Cheese'),
(745, 'Chicken'),
(746, 'Mushrooms'),
(747, 'Onions'),
(748, 'Pepperoni'),
(749, 'Peppers'),
(750, 'Salami'),
(751, 'PTomatoes'),
(752, 'Tomato Sauce');

--
-- Triggers `pizza_toppings`
--
DELIMITER $$
CREATE TRIGGER `prevent_duplicate_toppings` BEFORE INSERT ON `pizza_toppings` FOR EACH ROW BEGIN
    -- Check if the topping already exists for the pizza
    IF EXISTS (
        SELECT 1
        FROM pizza_toppings
        WHERE topping_id = NEW.topping_id
        AND topping_name = NEW.topping_name
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate topping for pizza.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `runners`
--

CREATE TABLE `runners` (
  `runner_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `registration_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `runners`
--

INSERT INTO `runners` (`runner_id`, `first_name`, `last_name`, `age`, `birth_date`, `registration_date`) VALUES
(1, 'Karl', 'Urban', NULL, NULL, '2021-01-01'),
(2, '', '', NULL, NULL, '2021-01-03'),
(3, '', '', NULL, NULL, '2021-01-08'),
(32, 'John', 'Doe', 28, '1994-05-10', '2023-06-24'),
(33, 'Jane', 'Smith', 35, '1986-09-22', '2023-06-24'),
(34, 'Michael', 'Johnson', 42, '1979-02-08', '2023-06-24'),
(35, 'Emily', 'Brown', 31, '1990-07-16', '2023-06-24'),
(36, 'Daniel', 'Wilson', 26, '1996-11-28', '2023-06-24'),
(37, 'Sophia', 'Lee', 29, '1992-04-03', '2023-06-24'),
(38, 'Matthew', 'Taylor', 33, '1988-12-01', '2023-06-24'),
(39, 'Olivia', 'Anderson', 36, '1985-03-19', '2023-06-24'),
(40, 'William', 'Thomas', 27, '1995-08-07', '2023-06-24'),
(41, 'Ava', 'Harris', 30, '1991-06-14', '2023-06-24'),
(42, 'James', 'Clark', 39, '1983-10-25', '2023-06-24'),
(43, 'Isabella', 'Lewis', 24, '1998-02-18', '2023-06-24'),
(44, 'Benjamin', 'Hall', 32, '1989-09-09', '2023-06-24'),
(45, 'Mia', 'Young', 34, '1987-01-31', '2023-06-24'),
(46, 'Alexander', 'Walker', 25, '1997-07-12', '2023-06-24'),
(47, 'Charlotte', 'Green', 38, '1984-04-24', '2023-06-24'),
(48, 'Henry', 'Baker', 23, '1999-12-06', '2023-06-24'),
(49, 'Amelia', 'Hill', 40, '1982-08-03', '2023-06-24'),
(50, 'Daniel', 'Adams', 37, '1985-11-15', '2023-06-24'),
(51, 'Sophia', 'King', 43, '1978-06-22', '2023-06-24'),
(52, 'Michael', 'Parker', 22, '2000-03-14', '2023-06-24'),
(53, 'Emily', 'White', 41, '1981-07-11', '2023-06-24'),
(54, 'Matthew', 'Carter', 26, '1995-09-17', '2023-06-24'),
(55, 'Olivia', 'Scott', 31, '1990-12-03', '2023-06-24'),
(56, 'William', 'Nelson', 33, '1989-02-26', '2023-06-24'),
(57, 'Ava', 'Jackson', 28, '1994-05-10', '2023-06-24'),
(58, 'James', 'Anderson', 35, '1986-09-22', '2023-06-24'),
(59, 'Sophia', 'Martin', 42, '1979-02-08', '2023-06-24'),
(60, 'Emily', 'Thomas', 31, '1990-07-16', '2023-06-24'),
(61, 'Daniel', 'Harris', 26, '1996-11-28', '2023-06-24'),
(62, 'Olivia', 'Taylor', 29, '1992-04-03', '2023-06-24'),
(63, 'Matthew', 'Johnson', 33, '1988-12-01', '2023-06-24'),
(64, 'Sophia', 'Brown', 36, '1985-03-19', '2023-06-24'),
(65, 'William', 'Lee', 27, '1995-08-07', '2023-06-24'),
(66, 'Ava', 'Smith', 30, '1991-06-14', '2023-06-24'),
(67, 'James', 'Walker', 39, '1983-10-25', '2023-06-24'),
(68, 'Isabella', 'Clark', 24, '1998-02-18', '2023-06-24'),
(69, 'Benjamin', 'Young', 32, '1989-09-09', '2023-06-24'),
(70, 'Mia', 'Lewis', 34, '1987-01-31', '2023-06-24'),
(71, 'Alexander', 'Hall', 25, '1997-07-12', '2023-06-24'),
(72, 'Charlotte', 'Johnson', 38, '1984-04-24', '2023-06-24'),
(73, 'Henry', 'Baker', 23, '1999-12-06', '2023-06-24'),
(74, 'Amelia', 'Hill', 40, '1982-08-03', '2023-06-24'),
(75, 'Daniel', 'Adams', 37, '1985-11-15', '2023-06-24'),
(76, 'Sophia', 'King', 43, '1978-06-22', '2023-06-24'),
(77, 'Michael', 'Parker', 22, '2000-03-14', '2023-06-24'),
(78, 'Emily', 'White', 41, '1981-07-11', '2023-06-24'),
(79, 'Matthew', 'Carter', 26, '1995-09-17', '2023-06-24'),
(80, 'Olivia', 'Scott', 31, '1990-12-03', '2023-06-24'),
(81, 'William', 'Nelson', 33, '1989-02-26', '2023-06-24');

--
-- Triggers `runners`
--
DELIMITER $$
CREATE TRIGGER `before_insert_runner` BEFORE INSERT ON `runners` FOR EACH ROW BEGIN
    SET NEW.registration_date = CURDATE();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `runner_orders`
--

CREATE TABLE `runner_orders` (
  `order_id` int(11) NOT NULL,
  `runner_id` int(11) DEFAULT NULL,
  `pickup_time` varchar(19) DEFAULT NULL,
  `distance` varchar(7) DEFAULT NULL,
  `duration` varchar(10) DEFAULT NULL,
  `cancellation` varchar(23) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `runner_orders`
--

INSERT INTO `runner_orders` (`order_id`, `runner_id`, `pickup_time`, `distance`, `duration`, `cancellation`) VALUES
(1, 1, '2021-01-01 18:15:34', '20km', '32 minutes', ''),
(2, 1, '2021-01-01 19:10:54', '20km', '27 minutes', ''),
(3, 1, '2021-01-03 00:12:37', '13.4km', '20 minutes', ''),
(4, 2, '2021-01-04 13:53:03', '23.4 km', '40 minutes', 'NaN'),
(5, 3, '2021-01-08 21:10:57', '10 km', '15 minutes', 'NaN'),
(6, 3, NULL, NULL, NULL, 'NaN'),
(7, 2, '2020-01-08 21:30:45', '25 km', '25 minutes', NULL),
(8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minutes', NULL),
(9, 2, '2020-01-08 21:30:45', '25 km', '25 minutes', NULL),
(10, 2, '2020-01-10 00:15:02', '23.4 km', '15 minutes', NULL),
(11, 2, NULL, NULL, NULL, 'Customer Cancellation'),
(12, 1, '2020-01-11 18:50:20', '10 km', '10 minutes', NULL),
(63, 32, '2023-06-24 09:30:00', '3.2 km', '20 minutes', NULL),
(64, 33, '2023-06-24 10:15:00', '2.7 km', '15 minutes', NULL),
(65, 32, '2023-06-24 11:00:00', '4.5 km', '25 minutes', 'Customer Cancellation'),
(66, 35, '2023-06-24 11:45:00', '1.8 km', '10 minutes', NULL),
(67, 36, '2023-06-24 12:30:00', '3.9 km', '22 minutes', NULL),
(68, 33, '2023-06-24 13:15:00', '2.4 km', '13 minutes', NULL),
(69, 38, '2023-06-24 14:00:00', '5.1 km', '30 minutes', NULL),
(70, 32, '2023-06-24 14:45:00', '2.1 km', '12 minutes', NULL),
(71, 36, '2023-06-24 15:30:00', '3.6 km', '20 minutes', NULL),
(72, 41, '2023-06-24 16:15:00', '2.9 km', '16 minutes', NULL),
(73, 34, '2023-06-24 17:00:00', '4.8 km', '27 minutes', NULL),
(74, 43, '2023-06-24 17:45:00', '1.5 km', '8 minutes', 'Restaurant Closed'),
(75, 38, '2023-06-24 18:30:00', '3.3 km', '18 minutes', NULL),
(76, 33, '2023-06-24 19:15:00', '2.6 km', '14 minutes', NULL),
(77, 46, '2023-06-24 20:00:00', '4.2 km', '24 minutes', NULL),
(78, 32, '2023-06-24 20:45:00', '1.9 km', '11 minutes', NULL),
(79, 36, '2023-06-24 21:30:00', '3.8 km', '21 minutes', NULL),
(80, 49, '2023-06-24 22:15:00', '2.3 km', '13 minutes', NULL),
(81, 50, '2023-06-24 23:00:00', '5.0 km', '28 minutes', NULL),
(82, 51, '2023-06-25 09:30:00', '3.1 km', '18 minutes', NULL),
(83, 33, '2023-06-25 10:15:00', '2.7 km', '15 minutes', NULL),
(84, 52, '2023-06-25 11:00:00', '4.5 km', '25 minutes', 'Customer Cancellation'),
(85, 35, '2023-06-25 11:45:00', '1.8 km', '10 minutes', NULL),
(86, 36, '2023-06-25 12:30:00', '3.9 km', '22 minutes', NULL),
(87, 33, '2023-06-25 13:15:00', '2.4 km', '13 minutes', NULL),
(88, 38, '2023-06-25 14:00:00', '5.1 km', '30 minutes', NULL),
(89, 32, '2023-06-25 14:45:00', '2.1 km', '12 minutes', NULL),
(90, 36, '2023-06-25 15:30:00', '3.6 km', '20 minutes', NULL),
(91, 41, '2023-06-25 16:15:00', '2.9 km', '16 minutes', NULL),
(92, 34, '2023-06-25 17:00:00', '4.8 km', '27 minutes', NULL),
(93, 43, '2023-06-25 17:45:00', '1.5 km', '8 minutes', 'Restaurant Closed'),
(94, 38, '2023-06-25 18:30:00', '3.3 km', '18 minutes', NULL),
(95, 33, '2023-06-25 19:15:00', '2.6 km', '14 minutes', NULL),
(96, 46, '2023-06-25 20:00:00', '4.2 km', '24 minutes', NULL),
(97, 32, '2023-06-25 20:45:00', '1.9 km', '11 minutes', NULL),
(98, 36, '2023-06-25 21:30:00', '3.8 km', '21 minutes', NULL),
(99, 49, '2023-06-25 22:15:00', '2.3 km', '13 minutes', NULL),
(100, 50, '2023-06-25 23:00:00', '5.0 km', '28 minutes', NULL),
(101, 51, '2023-06-26 09:30:00', '3.1 km', '18 minutes', NULL),
(102, 33, '2023-06-26 10:15:00', '2.7 km', '15 minutes', NULL),
(103, 52, '2023-06-26 11:00:00', '4.5 km', '25 minutes', 'Customer Cancellation'),
(104, 35, '2023-06-26 11:45:00', '1.8 km', '10 minutes', NULL),
(105, 36, '2023-06-26 12:30:00', '3.9 km', '22 minutes', NULL),
(106, 33, '2023-06-26 13:15:00', '2.4 km', '13 minutes', NULL),
(107, 38, '2023-06-26 14:00:00', '5.1 km', '30 minutes', NULL),
(108, 32, '2023-06-26 14:45:00', '2.1 km', '12 minutes', NULL),
(109, 36, '2023-06-26 15:30:00', '3.6 km', '20 minutes', NULL),
(110, 41, '2023-06-26 16:15:00', '2.9 km', '16 minutes', NULL),
(111, 34, '2023-06-26 17:00:00', '4.8 km', '27 minutes', NULL),
(112, 43, '2023-06-26 17:45:00', '1.5 km', '8 minutes', 'Restaurant Closed'),
(172, 32, '2023-06-24 09:00:00', '1.5 km', '00:10:00', ''),
(173, 33, '2023-06-24 10:15:00', '2.8 km', '00:18:00', ''),
(174, 34, '2023-06-24 11:30:00', '1.9 km', '00:12:00', ''),
(175, 35, '2023-06-24 12:45:00', '3.2 km', '00:20:00', ''),
(176, 36, '2023-06-24 14:00:00', '2.1 km', '00:14:00', ''),
(177, 37, '2023-06-24 15:15:00', '1.7 km', '00:11:00', ''),
(178, 38, '2023-06-24 16:30:00', '2.9 km', '00:19:00', ''),
(179, 39, '2023-06-24 17:45:00', '1.8 km', '00:12:00', ''),
(180, 40, '2023-06-24 19:00:00', '3.5 km', '00:22:00', ''),
(181, 41, '2023-06-25 09:00:00', '2.5 km', '00:16:00', ''),
(182, 42, '2023-06-25 10:15:00', '1.6 km', '00:10:00', ''),
(183, 43, '2023-06-25 11:30:00', '3.0 km', '00:18:00', ''),
(184, 44, '2023-06-25 12:45:00', '1.7 km', '00:11:00', ''),
(185, 45, '2023-06-25 14:00:00', '2.9 km', '00:20:00', ''),
(186, 46, '2023-06-25 15:15:00', '2.2 km', '00:15:00', ''),
(187, 47, '2023-06-25 16:30:00', '1.8 km', '00:12:00', ''),
(188, 48, '2023-06-25 17:45:00', '3.1 km', '00:20:00', ''),
(189, 49, '2023-06-25 19:00:00', '1.6 km', '00:10:00', ''),
(190, 50, '2023-06-25 20:15:00', '3.7 km', '00:23:00', ''),
(191, 51, '2023-06-26 09:00:00', '2.8 km', '00:18:00', ''),
(192, 52, '2023-06-26 10:15:00', '1.9 km', '00:12:00', ''),
(193, 53, '2023-06-26 11:30:00', '3.3 km', '00:21:00', ''),
(194, 54, '2023-06-26 12:45:00', '1.8 km', '00:12:00', ''),
(195, 55, '2023-06-26 14:00:00', '2.7 km', '00:17:00', ''),
(196, 56, '2023-06-26 15:15:00', '2.1 km', '00:14:00', ''),
(197, 57, '2023-06-26 16:30:00', '1.7 km', '00:11:00', ''),
(198, 58, '2023-06-26 17:45:00', '3.0 km', '00:19:00', ''),
(199, 59, '2023-06-26 19:00:00', '2.5 km', '00:16:00', ''),
(200, 60, '2023-06-26 20:15:00', '3.8 km', '00:24:00', ''),
(201, 61, '2023-06-27 09:00:00', '2.7 km', '00:17:00', ''),
(202, 62, '2023-06-27 10:15:00', '1.6 km', '00:10:00', ''),
(203, 63, '2023-06-27 11:30:00', '3.1 km', '00:19:00', ''),
(204, 64, '2023-06-27 12:45:00', '1.9 km', '00:12:00', ''),
(205, 65, '2023-06-27 14:00:00', '2.9 km', '00:19:00', ''),
(206, 66, '2023-06-27 15:15:00', '2.2 km', '00:15:00', ''),
(207, 67, '2023-06-27 16:30:00', '1.8 km', '00:12:00', ''),
(208, 68, '2023-06-27 17:45:00', '3.1 km', '00:19:00', ''),
(209, 69, '2023-06-27 19:00:00', '1.6 km', '00:10:00', ''),
(210, 70, '2023-06-27 20:15:00', '3.8 km', '00:24:00', ''),
(211, 71, '2023-06-28 09:00:00', '2.5 km', '00:16:00', ''),
(212, 72, '2023-06-28 10:15:00', '1.6 km', '00:10:00', ''),
(213, 73, '2023-06-28 11:30:00', '3.0 km', '00:18:00', ''),
(214, 74, '2023-06-28 12:45:00', '1.5 km', '00:10:00', ''),
(215, 75, '2023-06-28 14:00:00', '3.2 km', '00:20:00', ''),
(216, 76, '2023-06-28 15:15:00', '2.3 km', '00:15:00', ''),
(217, 77, '2023-06-28 16:30:00', '1.7 km', '00:11:00', ''),
(218, 78, '2023-06-28 17:45:00', '3.3 km', '00:21:00', ''),
(219, 79, '2023-06-28 19:00:00', '1.6 km', '00:10:00', ''),
(220, 80, '2023-06-28 20:15:00', '3.5 km', '00:22:00', '');

--
-- Triggers `runner_orders`
--
DELIMITER $$
CREATE TRIGGER `after_insert_on_runner_orders` AFTER INSERT ON `runner_orders` FOR EACH ROW BEGIN
	IF NEW.cancellation = 'NaN' OR NEW.cancellation is NULL OR NEW.cancellation LIKE 'Cancellation%' THEN
		INSERT INTO audit_table VALUES(NEW.order_id, NEW.runner_id, CURRENT_TIME, CURRENT_DATE);
    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_on_runners_orders` AFTER UPDATE ON `runner_orders` FOR EACH ROW BEGIN
	IF NEW.cancellation = 'NaN' OR NEW.cancellation is NULL OR NEW.cancellation LIKE 'Cancellation%' THEN
		INSERT INTO audit_table VALUES(NEW.order_id, NEW.runner_id, CURRENT_TIME, CURRENT_DATE);
    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `birth_date` varchar(255) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_table`
--
ALTER TABLE `audit_table`
  ADD KEY `fk_audit_table_order_id` (`order_id`),
  ADD KEY `fk_audit_table_runner_id` (`runner_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD KEY `fk_order_id_customer` (`order_id`),
  ADD KEY `fk_pizza_id_customer` (`pizza_id`);

--
-- Indexes for table `pizza_names`
--
ALTER TABLE `pizza_names`
  ADD PRIMARY KEY (`pizza_id`);

--
-- Indexes for table `pizza_recipes`
--
ALTER TABLE `pizza_recipes`
  ADD PRIMARY KEY (`pizza_id`),
  ADD KEY `pizza_id` (`pizza_id`);

--
-- Indexes for table `pizza_toppings`
--
ALTER TABLE `pizza_toppings`
  ADD PRIMARY KEY (`topping_id`);

--
-- Indexes for table `runners`
--
ALTER TABLE `runners`
  ADD PRIMARY KEY (`runner_id`);

--
-- Indexes for table `runner_orders`
--
ALTER TABLE `runner_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_runner_id` (`runner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `pizza_names`
--
ALTER TABLE `pizza_names`
  MODIFY `pizza_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `pizza_toppings`
--
ALTER TABLE `pizza_toppings`
  MODIFY `topping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=753;

--
-- AUTO_INCREMENT for table `runners`
--
ALTER TABLE `runners`
  MODIFY `runner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `runner_orders`
--
ALTER TABLE `runner_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_table`
--
ALTER TABLE `audit_table`
  ADD CONSTRAINT `fk_audit_table_order_id` FOREIGN KEY (`order_id`) REFERENCES `runner_orders` (`order_id`),
  ADD CONSTRAINT `fk_audit_table_runner_id` FOREIGN KEY (`runner_id`) REFERENCES `runners` (`runner_id`);

--
-- Constraints for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD CONSTRAINT `fk_order_id_customer` FOREIGN KEY (`order_id`) REFERENCES `runner_orders` (`order_id`),
  ADD CONSTRAINT `fk_pizza_id_customer` FOREIGN KEY (`pizza_id`) REFERENCES `pizza_names` (`pizza_id`);

--
-- Constraints for table `pizza_recipes`
--
ALTER TABLE `pizza_recipes`
  ADD CONSTRAINT `fk_pizza_id` FOREIGN KEY (`pizza_id`) REFERENCES `pizza_names` (`pizza_id`);

--
-- Constraints for table `runner_orders`
--
ALTER TABLE `runner_orders`
  ADD CONSTRAINT `fk_runner_id` FOREIGN KEY (`runner_id`) REFERENCES `runners` (`runner_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
