-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 17, 2024 at 11:05 AM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21794086_aldi`
--

-- --------------------------------------------------------

--
-- Table structure for table `news_catalog`
--

CREATE TABLE `news_catalog` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `desc` text NOT NULL,
  `img` varchar(100) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `news_catalog`
--

INSERT INTO `news_catalog` (`id`, `title`, `desc`, `img`, `date`) VALUES
(1, 'Kompos', 'Sampah organik', 'archive/018580600-1653098543-628729271f854-kartun-doraemon.jpg', '2024-02-15'),
(2, 'contoh', 'contoh post', 'archive/baru.jpg', '2024-02-15'),
(3, 'contoh', 'contoh post', 'archive/titanic.jpg', '2024-02-15'),
(4, 'contoh', 'contoh post', 'archive/titanic.jpg', '2024-02-15'),
(5, 'contohhh', 'contoh posth', 'archive/titanic.jpg', '2024-02-15'),
(6, 'contohhh', 'contoh posth', 'archive/titanic.jpg', '2024-02-15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `news_catalog`
--
ALTER TABLE `news_catalog`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `news_catalog`
--
ALTER TABLE `news_catalog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
