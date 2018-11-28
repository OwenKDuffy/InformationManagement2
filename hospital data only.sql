-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 28, 2018 at 05:34 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

--
-- Dumping data for table `bed`
--

INSERT INTO `bed` (`Number`, `Location`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(201, 2);

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DeptNo`, `Department_Name`, `Dept_Head`) VALUES
(0, 'Administration', '7768304g'),
(1, 'Medicine', '7764512f'),
(2, 'Surgery', '1234567r'),
(3, 'Emergency', '4562112r'),
(4, 'Radiology', '7756392u'),
(5, 'Facilities', '5671234h');

--
-- Dumping data for table `operation`
--

INSERT INTO `operation` (`ID`, `Type`, `Room`, `Patient_Case`) VALUES
(1, 'Appendectomy', 456, 4561),
(2, 'X-Ray', 123, 2312),
(3, 'Examination', 12, 4552),
(4, 'X-Ray', 123, 4552),
(5, 'MRI', 124, 4552);

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PPSN`, `First_Name`, `Surname`, `Street`, `Town`, `County`, `Ethnicity`, `Height`, `Weight`, `Sex`, `Blood_Group`) VALUES
('1234567r', 'Mohammed', 'AlAfra', 'Pearse ST', 'Dublin', 'Dublin', 'Arabic', 174, 77, 'M', 'O-'),
('4512354t', 'Mary', 'McKenna', 'Sea Road', 'Arklow', 'Wicklow', 'Irish', 125, 49, 'F', 'A-'),
('5562137p', 'Jorge', 'Rivas', 'The Meadows', 'Shankill', 'Dublin', 'Spanish', 184, 79, 'M', 'O+'),
('67849364', 'John', 'Smith', 'Main Street', 'Bray', 'Wicklow', 'Irish', 167, 56, 'M', 'A+'),
('8854621r', 'Alex', 'O\'Dwyer', 'Grove Road', 'Dundalk', 'Louth', 'Irish', 184, 84, 'M', 'AB+');

--
-- Dumping data for table `performs`
--

INSERT INTO `performs` (`Operation`, `Staff`) VALUES
(1, '1234567r'),
(2, '7756392u'),
(3, '7764512f'),
(4, '7756392u'),
(5, '7756392u');

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`Number`, `Type`, `Location`) VALUES
(12, 'Examination Clin', 1),
(123, 'X-Ray', 4),
(124, 'MRI', 4),
(456, 'Operating Theatr', 2),
(457, 'Operating Theatr', 2);

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`PPSN`, `First_Name`, `Second_Name`, `Role`, `Dept`, `Supervisor`) VALUES
('1234567r', 'Mohammed', 'AlAfra', 'Surgeon', 2, NULL),
('4562112r', 'Mary', 'O\'Shea', 'Doctor', 3, NULL),
('5671234h', 'Roy', 'Higgins', 'Groundsman', 5, NULL),
('7756392u', 'John', 'King', 'Technician', 4, '7764512f'),
('7764512f', 'William', 'Burke', 'Doctor', 1, NULL),
('7768304g', 'Lucinda', 'Dwyer', 'CEO', 0, NULL);

--
-- Dumping data for table `stay`
--

INSERT INTO `stay` (`ID`, `Date`, `Details`, `Bed_No`, `Priority`, `Patient`, `Doctor`) VALUES
(2312, '2018-11-28', 'Patient Arrived to A&E with Broken Arm', NULL, 4, '8854621r', '4562112r'),
(2456, '2018-10-21', 'Patient referred by GP with Jaundice', 1, 2, '4512354t', '7764512f'),
(4552, '2018-11-26', 'Patient referred by GP', 3, 3, '67849364', '7764512f'),
(4561, '2018-11-28', 'Patient has urgent case of Appendicitis', 201, 1, '5562137p', '1234567r'),
(7895, '2018-11-28', 'Patient Arrived to A&E after RTI', NULL, 1, '1234567r', '4562112r');

-- --------------------------------------------------------

--
-- Structure for view `patient_admin_details`
--
DROP TABLE IF EXISTS `patient_admin_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_admin_details`  AS  select `patient`.`First_Name` AS `First_Name`,`patient`.`Surname` AS `Surname`,`patient`.`Street` AS `Street`,`patient`.`Town` AS `Town`,`patient`.`County` AS `County` from `patient` ;

-- --------------------------------------------------------

--
-- Structure for view `patient_doctor`
--
DROP TABLE IF EXISTS `patient_doctor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_doctor`  AS  (select `patient`.`First_Name` AS `patientFirstName`,`patient`.`Surname` AS `patientSurname`,`staff`.`First_Name` AS `doctorFirstName`,`staff`.`Second_Name` AS `doctorSurname` from ((`patient` join `stay` on((`patient`.`PPSN` = `stay`.`Patient`))) join `staff` on((`stay`.`Doctor` = `staff`.`PPSN`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `patient_med_details`
--
DROP TABLE IF EXISTS `patient_med_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_med_details`  AS  select `patient`.`First_Name` AS `First_Name`,`patient`.`Surname` AS `Surname`,`patient`.`Ethnicity` AS `Ethnicity`,`patient`.`Sex` AS `Sex`,`patient`.`Height` AS `Height`,`patient`.`Weight` AS `Weight`,`patient`.`Blood_Group` AS `Blood_Group` from `patient` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
