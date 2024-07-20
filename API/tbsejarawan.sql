-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2024 at 02:02 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbuts1`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbsejarawan`
--

CREATE TABLE `tbsejarawan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `asal` varchar(255) NOT NULL,
  `jk` varchar(255) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbsejarawan`
--

INSERT INTO `tbsejarawan` (`id`, `nama`, `tgl_lahir`, `asal`, `jk`, `deskripsi`, `foto`) VALUES
(1, 'Abdul Syukur', '1967-06-20', 'Tangerang', 'Laki-Laki', 'H. Abdul Syukur[1] (lahir 20 Juni 1967) adalah seorang politikus Indonesia dari Partai Demokrat. Ia menjabat Anggota DPRD Provinsi Banten periode 2009–2014. Sebelumnya ia menjabat sebagai Anggota DPRD Kota Tangerang 2 periode yakni 1999–2004 dan 2004–2009', 'Abdul Syukur.png'),
(2, 'Ahmad Soebardjo', '1896-03-23', 'Karawang', 'Laki-Laki', 'Semasa masih menjadi mahasiswa, Soebardjo aktif dalam memperjuangkan kemerdekaan Indonesia melalui beberapa organisasi seperti Jong Java dan Persatuan Mahasiswa Indonesia di Belanda. Pada bulan Februari 1927, ia pun menjadi wakil Indonesia bersama dengan ', 'Achmad Soebardjo.jpg'),
(3, 'Ki Hajar Dewantara', '1889-05-02', 'Yogyakarta', 'Laki-Laki', 'Selain ulet sebagai seorang wartawan muda, dia juga aktif dalam organisasi sosial dan politik. Sejak berdirinya Boedi Oetomo (BO) tahun 1908, dia aktif di seksi propaganda untuk menyosialisasikan dan menggugah kesadaran masyarakat Indonesia (terutama Jawa', 'Ki Hajar Dewantara.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbsejarawan`
--
ALTER TABLE `tbsejarawan`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbsejarawan`
--
ALTER TABLE `tbsejarawan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
