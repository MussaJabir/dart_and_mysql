-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 12, 2024 at 07:41 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_one_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_details`
--

CREATE TABLE `academic_details` (
  `username` varchar(35) NOT NULL,
  `courseName` varchar(10) NOT NULL,
  `institutionName` varchar(30) NOT NULL,
  `yearofCompletion` int NOT NULL,
  `GPA` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `academic_details`
--

INSERT INTO `academic_details` (`username`, `courseName`, `institutionName`, `yearofCompletion`, `GPA`) VALUES
('cadabrah', 'btccn', 'iaa', 2028, '3.9'),
('dorMen', 'ICT', 'JRIIT', 2019, '5.0'),
('dutch', 'dit', 'jriit', 2025, '3.5');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `First_name` varchar(30) NOT NULL,
  `Last_name` varchar(30) NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `Username` varchar(35) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` enum('Admin','Registrar','Normal') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`First_name`, `Last_name`, `Gender`, `Username`, `Password`, `Role`) VALUES
('ibrahim', 'jabir', 'Male', 'cadabrah', '707633134', 'Normal'),
('Doreen', 'Meena', 'Female', 'dorMen', '409719617', 'Normal'),
('mussa', 'jabir', 'Male', 'dutch', '413184288', 'Normal');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_details`
--
ALTER TABLE `academic_details`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
