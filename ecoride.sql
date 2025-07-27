-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql
-- Généré le : sam. 26 juil. 2025 à 16:36
-- Version du serveur : 8.0.32
-- Version de PHP : 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecoride`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `confirmation`
--

CREATE TABLE `confirmation` (
  `conf_id` bigint UNSIGNED NOT NULL,
  `covoit_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `statut` enum('En cours','Annulation','Trajet fini') NOT NULL DEFAULT 'En cours',
  `n_conf` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `contact_id` bigint UNSIGNED NOT NULL,
  `nom` varchar(18) DEFAULT NULL,
  `mail` varchar(255) NOT NULL,
  `sujet` enum('Support technique','Problème lié à une réservation','Autre') NOT NULL,
  `message` text NOT NULL,
  `date_envoi` date NOT NULL,
  `statut` enum('Non-traité','En cours','Résolu') NOT NULL DEFAULT 'Non-traité'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `covoiturage`
--

CREATE TABLE `covoiturage` (
  `covoit_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `voiture_id` bigint UNSIGNED NOT NULL,
  `departure_address` varchar(120) NOT NULL,
  `add_dep_address` varchar(120) DEFAULT NULL,
  `postal_code_dep` varchar(6) NOT NULL,
  `city_dep` varchar(120) NOT NULL,
  `arrival_address` varchar(120) NOT NULL,
  `add_arr_address` varchar(120) DEFAULT NULL,
  `postal_code_arr` varchar(6) NOT NULL,
  `city_arr` varchar(120) NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `max_travel_time` time NOT NULL,
  `price` int NOT NULL,
  `n_tickets` tinyint UNSIGNED NOT NULL,
  `eco_travel` tinyint(1) NOT NULL DEFAULT '0',
  `trip_started` tinyint(1) NOT NULL DEFAULT '0',
  `trip_completed` tinyint(1) NOT NULL DEFAULT '0',
  `cancelled` tinyint(1) NOT NULL DEFAULT '0'
) ;

--
-- Déchargement des données de la table `covoiturage`
--

INSERT INTO `covoiturage` (`covoit_id`, `user_id`, `voiture_id`, `departure_address`, `add_dep_address`, `postal_code_dep`, `city_dep`, `arrival_address`, `add_arr_address`, `postal_code_arr`, `city_arr`, `departure_date`, `arrival_date`, `departure_time`, `arrival_time`, `max_travel_time`, `price`, `n_tickets`, `eco_travel`, `trip_started`, `trip_completed`, `cancelled`) VALUES
(1, 4, 4, '14 Boulevard Haussmann', NULL, '75002', 'PARIS', '8 Rue de Rome', NULL, '13005', 'MARSEILLE', '2025-08-04', '2025-08-04', '09:45:00', '18:15:00', '09:00:00', 62, 2, 0, 0, 0, 0),
(2, 4, 4, '9 Place Castellane', NULL, '13001', 'MARSEILLE', '36 Rue de Belleville', NULL, '75012', 'PARIS', '2025-08-19', '2025-08-19', '08:00:00', '16:30:00', '09:00:00', 37, 1, 0, 0, 0, 0),
(3, 7, 7, '22 Avenue Jean Jaurès', NULL, '75007', 'PARIS', '18 Quai du Port', NULL, '13003', 'MARSEILLE', '2025-08-09', '2025-08-09', '10:15:00', '18:45:00', '09:00:00', 46, 1, 1, 0, 0, 0),
(4, 8, 8, '9 Place Castellane', NULL, '13004', 'MARSEILLE', '36 Rue de Belleville', NULL, '75017', 'PARIS', '2025-08-05', '2025-08-05', '11:45:00', '20:15:00', '09:00:00', 39, 4, 0, 0, 0, 0),
(5, 7, 7, '22 Avenue Jean Jaurès', NULL, '75012', 'PARIS', '16 Boulevard Longchamp', NULL, '13014', 'MARSEILLE', '2025-08-21', '2025-08-21', '12:00:00', '20:30:00', '09:00:00', 36, 1, 0, 0, 0, 0),
(6, 7, 7, '16 Boulevard Longchamp', NULL, '13002', 'MARSEILLE', '36 Rue de Belleville', NULL, '75003', 'PARIS', '2025-08-13', '2025-08-13', '12:30:00', '21:00:00', '09:00:00', 52, 4, 0, 0, 0, 0),
(7, 6, 6, '12 La Canebière', NULL, '13012', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75020', 'PARIS', '2025-08-23', '2025-08-23', '11:30:00', '20:00:00', '09:00:00', 38, 3, 1, 0, 0, 0),
(8, 9, 9, '22 Rue Paradis', NULL, '13016', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75013', 'PARIS', '2025-08-16', '2025-08-16', '12:30:00', '21:00:00', '09:00:00', 64, 1, 0, 0, 0, 0),
(9, 6, 6, '10 Rue Lafayette', NULL, '75001', 'PARIS', '22 Rue Paradis', NULL, '13014', 'MARSEILLE', '2025-08-18', '2025-08-18', '11:45:00', '20:15:00', '09:00:00', 50, 2, 1, 0, 0, 0),
(10, 7, 7, '18 Quai du Port', NULL, '13003', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75015', 'PARIS', '2025-08-15', '2025-08-15', '11:00:00', '19:30:00', '09:00:00', 55, 2, 1, 0, 0, 0),
(11, 6, 6, '5 Rue Oberkampf', NULL, '75016', 'PARIS', '12 La Canebière', NULL, '13010', 'MARSEILLE', '2025-08-22', '2025-08-22', '13:15:00', '21:45:00', '09:00:00', 49, 4, 0, 0, 0, 0),
(12, 6, 6, '12 La Canebière', NULL, '13014', 'MARSEILLE', '10 Rue Lafayette', NULL, '75017', 'PARIS', '2025-08-12', '2025-08-12', '14:15:00', '22:45:00', '09:00:00', 59, 1, 0, 0, 0, 0),
(13, 2, 2, '22 Avenue Jean Jaurès', NULL, '75016', 'PARIS', '16 Boulevard Longchamp', NULL, '13006', 'MARSEILLE', '2025-08-10', '2025-08-10', '14:45:00', '23:15:00', '09:00:00', 41, 3, 0, 0, 0, 0),
(14, 9, 9, '10 Rue Lafayette', NULL, '75018', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-07', '2025-08-07', '06:45:00', '15:15:00', '09:00:00', 37, 2, 0, 0, 0, 0),
(15, 2, 2, '14 Boulevard Haussmann', NULL, '75016', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-08', '2025-08-08', '09:45:00', '18:15:00', '09:00:00', 44, 4, 0, 0, 0, 0),
(16, 3, 3, '36 Rue de Belleville', NULL, '75011', 'PARIS', '9 Place Castellane', NULL, '13015', 'MARSEILLE', '2025-08-09', '2025-08-09', '11:45:00', '20:15:00', '09:00:00', 52, 2, 1, 0, 0, 0),
(17, 5, 5, '8 Rue de Rome', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75001', 'PARIS', '2025-08-24', '2025-08-24', '14:15:00', '22:45:00', '09:00:00', 56, 1, 0, 0, 0, 0),
(18, 2, 2, '22 Avenue Jean Jaurès', NULL, '75010', 'PARIS', '16 Boulevard Longchamp', NULL, '13005', 'MARSEILLE', '2025-08-07', '2025-08-07', '10:30:00', '19:00:00', '09:00:00', 41, 4, 0, 0, 0, 0),
(19, 2, 2, '22 Avenue Jean Jaurès', NULL, '75011', 'PARIS', '16 Boulevard Longchamp', NULL, '13016', 'MARSEILLE', '2025-08-31', '2025-08-31', '09:15:00', '17:45:00', '09:00:00', 52, 4, 0, 0, 0, 0),
(20, 10, 10, '36 Rue de Belleville', NULL, '75010', 'PARIS', '9 Place Castellane', NULL, '13002', 'MARSEILLE', '2025-08-29', '2025-08-29', '11:30:00', '20:00:00', '09:00:00', 65, 1, 1, 0, 0, 0),
(21, 7, 7, '14 Boulevard Haussmann', NULL, '75017', 'PARIS', '22 Rue Paradis', NULL, '13012', 'MARSEILLE', '2025-08-08', '2025-08-08', '12:45:00', '21:15:00', '09:00:00', 37, 3, 0, 0, 0, 0),
(22, 10, 10, '22 Avenue Jean Jaurès', NULL, '75015', 'PARIS', '12 La Canebière', NULL, '13005', 'MARSEILLE', '2025-08-08', '2025-08-08', '09:00:00', '17:30:00', '09:00:00', 59, 1, 0, 0, 0, 0),
(23, 4, 4, '9 Place Castellane', NULL, '13007', 'MARSEILLE', '36 Rue de Belleville', NULL, '75005', 'PARIS', '2025-08-14', '2025-08-14', '07:30:00', '16:00:00', '09:00:00', 48, 3, 0, 0, 0, 0),
(24, 2, 2, '12 La Canebière', NULL, '13007', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75014', 'PARIS', '2025-08-02', '2025-08-02', '06:15:00', '14:45:00', '09:00:00', 46, 2, 0, 0, 0, 0),
(25, 7, 7, '16 Boulevard Longchamp', NULL, '13011', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75009', 'PARIS', '2025-08-20', '2025-08-20', '07:00:00', '15:30:00', '09:00:00', 40, 1, 0, 0, 0, 0),
(26, 3, 3, '16 Boulevard Longchamp', NULL, '13010', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75017', 'PARIS', '2025-08-05', '2025-08-05', '07:00:00', '15:30:00', '09:00:00', 44, 3, 0, 0, 0, 0),
(27, 10, 10, '50 Rue de Rivoli', NULL, '75012', 'PARIS', '22 Rue Paradis', NULL, '13013', 'MARSEILLE', '2025-08-20', '2025-08-20', '14:30:00', '23:00:00', '09:00:00', 54, 3, 0, 0, 0, 0),
(28, 4, 4, '22 Rue Paradis', NULL, '13016', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75018', 'PARIS', '2025-08-21', '2025-08-21', '06:30:00', '15:00:00', '09:00:00', 35, 4, 1, 0, 0, 0),
(29, 8, 8, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75008', 'PARIS', '2025-08-27', '2025-08-27', '06:30:00', '15:00:00', '09:00:00', 45, 3, 1, 0, 0, 0),
(30, 2, 2, '10 Rue Lafayette', NULL, '75001', 'PARIS', '16 Boulevard Longchamp', NULL, '13006', 'MARSEILLE', '2025-08-03', '2025-08-03', '08:45:00', '17:15:00', '09:00:00', 45, 3, 0, 0, 0, 0),
(31, 9, 9, '10 Rue Lafayette', NULL, '75015', 'PARIS', '22 Rue Paradis', NULL, '13015', 'MARSEILLE', '2025-08-21', '2025-08-21', '14:30:00', '23:00:00', '09:00:00', 35, 1, 0, 0, 0, 0),
(32, 10, 10, '22 Avenue Jean Jaurès', NULL, '75015', 'PARIS', '16 Boulevard Longchamp', NULL, '13008', 'MARSEILLE', '2025-08-30', '2025-08-30', '12:45:00', '21:15:00', '09:00:00', 62, 3, 1, 0, 0, 0),
(33, 9, 9, '18 Quai du Port', NULL, '13003', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75004', 'PARIS', '2025-08-02', '2025-08-02', '14:00:00', '22:30:00', '09:00:00', 53, 3, 1, 0, 0, 0),
(34, 7, 7, '18 Quai du Port', NULL, '13006', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75018', 'PARIS', '2025-08-19', '2025-08-19', '13:45:00', '22:15:00', '09:00:00', 55, 2, 1, 0, 0, 0),
(35, 4, 4, '50 Rue de Rivoli', NULL, '75002', 'PARIS', '12 La Canebière', NULL, '13013', 'MARSEILLE', '2025-08-26', '2025-08-26', '14:00:00', '22:30:00', '09:00:00', 65, 4, 1, 0, 0, 0),
(36, 2, 2, '22 Rue Paradis', NULL, '13005', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75001', 'PARIS', '2025-08-03', '2025-08-03', '12:00:00', '20:30:00', '09:00:00', 38, 3, 0, 0, 0, 0),
(37, 8, 8, '18 Quai du Port', NULL, '13015', 'MARSEILLE', '10 Rue Lafayette', NULL, '75001', 'PARIS', '2025-08-23', '2025-08-23', '12:30:00', '21:00:00', '09:00:00', 45, 1, 0, 0, 0, 0),
(38, 4, 4, '5 Rue Oberkampf', NULL, '75018', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-15', '2025-08-15', '13:00:00', '21:30:00', '09:00:00', 43, 2, 1, 0, 0, 0),
(39, 4, 4, '16 Boulevard Longchamp', NULL, '13003', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75014', 'PARIS', '2025-08-15', '2025-08-15', '14:45:00', '23:15:00', '09:00:00', 51, 4, 1, 0, 0, 0),
(40, 4, 4, '16 Boulevard Longchamp', NULL, '13011', 'MARSEILLE', '36 Rue de Belleville', NULL, '75004', 'PARIS', '2025-08-31', '2025-08-31', '12:00:00', '20:30:00', '09:00:00', 49, 3, 0, 0, 0, 0),
(41, 6, 6, '22 Avenue Jean Jaurès', NULL, '75013', 'PARIS', '22 Rue Paradis', NULL, '13002', 'MARSEILLE', '2025-08-10', '2025-08-10', '13:15:00', '21:45:00', '09:00:00', 52, 3, 0, 0, 0, 0),
(42, 7, 7, '16 Boulevard Longchamp', NULL, '13010', 'MARSEILLE', '10 Rue Lafayette', NULL, '75008', 'PARIS', '2025-08-12', '2025-08-12', '11:30:00', '20:00:00', '09:00:00', 41, 3, 1, 0, 0, 0),
(43, 3, 3, '5 Rue Oberkampf', NULL, '75006', 'PARIS', '12 La Canebière', NULL, '13009', 'MARSEILLE', '2025-08-17', '2025-08-17', '10:30:00', '19:00:00', '09:00:00', 44, 1, 1, 0, 0, 0),
(44, 2, 2, '5 Rue Oberkampf', NULL, '75017', 'PARIS', '8 Rue de Rome', NULL, '13002', 'MARSEILLE', '2025-08-16', '2025-08-16', '11:45:00', '20:15:00', '09:00:00', 35, 1, 0, 0, 0, 0),
(45, 4, 4, '14 Boulevard Haussmann', NULL, '75015', 'PARIS', '16 Boulevard Longchamp', NULL, '13010', 'MARSEILLE', '2025-08-06', '2025-08-06', '06:30:00', '15:00:00', '09:00:00', 41, 1, 0, 0, 0, 0),
(46, 8, 8, '16 Boulevard Longchamp', NULL, '13003', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75007', 'PARIS', '2025-08-23', '2025-08-23', '07:15:00', '15:45:00', '09:00:00', 51, 1, 0, 0, 0, 0),
(47, 8, 8, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75005', 'PARIS', '2025-08-23', '2025-08-23', '08:45:00', '17:15:00', '09:00:00', 51, 1, 1, 0, 0, 0),
(48, 4, 4, '14 Boulevard Haussmann', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13015', 'MARSEILLE', '2025-08-24', '2025-08-24', '14:00:00', '22:30:00', '09:00:00', 63, 3, 1, 0, 0, 0),
(49, 10, 10, '16 Boulevard Longchamp', NULL, '13015', 'MARSEILLE', '10 Rue Lafayette', NULL, '75014', 'PARIS', '2025-08-21', '2025-08-21', '13:30:00', '22:00:00', '09:00:00', 60, 3, 0, 0, 0, 0),
(50, 10, 10, '8 Rue de Rome', NULL, '13005', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75001', 'PARIS', '2025-08-13', '2025-08-13', '08:45:00', '17:15:00', '09:00:00', 55, 1, 1, 0, 0, 0),
(51, 3, 3, '22 Avenue Jean Jaurès', NULL, '75001', 'PARIS', '8 Rue de Rome', NULL, '13006', 'MARSEILLE', '2025-08-30', '2025-08-30', '08:00:00', '16:30:00', '09:00:00', 47, 4, 0, 0, 0, 0),
(52, 9, 9, '22 Rue Paradis', NULL, '13011', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75019', 'PARIS', '2025-08-05', '2025-08-05', '09:15:00', '17:45:00', '09:00:00', 54, 4, 0, 0, 0, 0),
(53, 4, 4, '9 Place Castellane', NULL, '13002', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75007', 'PARIS', '2025-08-22', '2025-08-22', '06:30:00', '15:00:00', '09:00:00', 52, 4, 0, 0, 0, 0),
(54, 2, 2, '9 Place Castellane', NULL, '13011', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75009', 'PARIS', '2025-08-06', '2025-08-06', '14:30:00', '23:00:00', '09:00:00', 48, 2, 0, 0, 0, 0),
(55, 7, 7, '12 La Canebière', NULL, '13007', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75020', 'PARIS', '2025-08-05', '2025-08-05', '08:30:00', '17:00:00', '09:00:00', 51, 3, 0, 0, 0, 0),
(56, 10, 10, '22 Rue Paradis', NULL, '13014', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75004', 'PARIS', '2025-08-07', '2025-08-07', '06:45:00', '15:15:00', '09:00:00', 64, 2, 1, 0, 0, 0),
(57, 7, 7, '50 Rue de Rivoli', NULL, '75007', 'PARIS', '18 Quai du Port', NULL, '13004', 'MARSEILLE', '2025-08-21', '2025-08-21', '08:00:00', '16:30:00', '09:00:00', 57, 1, 0, 0, 0, 0),
(58, 7, 7, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75012', 'PARIS', '2025-08-18', '2025-08-18', '06:45:00', '15:15:00', '09:00:00', 50, 4, 0, 0, 0, 0),
(59, 6, 6, '22 Avenue Jean Jaurès', NULL, '75002', 'PARIS', '22 Rue Paradis', NULL, '13009', 'MARSEILLE', '2025-08-28', '2025-08-28', '07:15:00', '15:45:00', '09:00:00', 44, 2, 0, 0, 0, 0),
(60, 9, 9, '9 Place Castellane', NULL, '13009', 'MARSEILLE', '36 Rue de Belleville', NULL, '75014', 'PARIS', '2025-08-09', '2025-08-09', '08:45:00', '17:15:00', '09:00:00', 62, 2, 0, 0, 0, 0),
(61, 3, 3, '9 Place Castellane', NULL, '13010', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75014', 'PARIS', '2025-08-13', '2025-08-13', '12:00:00', '20:30:00', '09:00:00', 46, 2, 1, 0, 0, 0),
(62, 3, 3, '14 Boulevard Haussmann', NULL, '75017', 'PARIS', '22 Rue Paradis', NULL, '13013', 'MARSEILLE', '2025-08-07', '2025-08-07', '09:00:00', '17:30:00', '09:00:00', 63, 3, 1, 0, 0, 0),
(63, 5, 5, '18 Quai du Port', NULL, '13009', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75009', 'PARIS', '2025-08-24', '2025-08-24', '09:00:00', '17:30:00', '09:00:00', 47, 2, 0, 0, 0, 0),
(64, 2, 2, '22 Avenue Jean Jaurès', NULL, '75004', 'PARIS', '9 Place Castellane', NULL, '13009', 'MARSEILLE', '2025-08-13', '2025-08-13', '07:30:00', '16:00:00', '09:00:00', 54, 2, 1, 0, 0, 0),
(65, 5, 5, '36 Rue de Belleville', NULL, '75005', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-05', '2025-08-05', '14:30:00', '23:00:00', '09:00:00', 53, 1, 0, 0, 0, 0),
(66, 10, 10, '10 Rue Lafayette', NULL, '75017', 'PARIS', '8 Rue de Rome', NULL, '13010', 'MARSEILLE', '2025-08-14', '2025-08-14', '08:30:00', '17:00:00', '09:00:00', 41, 2, 0, 0, 0, 0),
(67, 9, 9, '22 Avenue Jean Jaurès', NULL, '75008', 'PARIS', '16 Boulevard Longchamp', NULL, '13003', 'MARSEILLE', '2025-08-25', '2025-08-25', '06:30:00', '15:00:00', '09:00:00', 55, 2, 1, 0, 0, 0),
(68, 4, 4, '14 Boulevard Haussmann', NULL, '75003', 'PARIS', '8 Rue de Rome', NULL, '13003', 'MARSEILLE', '2025-08-18', '2025-08-18', '09:45:00', '18:15:00', '09:00:00', 57, 3, 1, 0, 0, 0),
(69, 4, 4, '12 La Canebière', NULL, '13013', 'MARSEILLE', '10 Rue Lafayette', NULL, '75008', 'PARIS', '2025-08-29', '2025-08-29', '09:45:00', '18:15:00', '09:00:00', 57, 2, 0, 0, 0, 0),
(70, 2, 2, '12 La Canebière', NULL, '13007', 'MARSEILLE', '10 Rue Lafayette', NULL, '75016', 'PARIS', '2025-08-15', '2025-08-15', '06:15:00', '14:45:00', '09:00:00', 54, 3, 0, 0, 0, 0),
(71, 2, 2, '14 Boulevard Haussmann', NULL, '75010', 'PARIS', '8 Rue de Rome', NULL, '13012', 'MARSEILLE', '2025-08-28', '2025-08-28', '14:15:00', '22:45:00', '09:00:00', 44, 2, 1, 0, 0, 0),
(72, 6, 6, '18 Quai du Port', NULL, '13002', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75004', 'PARIS', '2025-08-30', '2025-08-30', '14:30:00', '23:00:00', '09:00:00', 63, 3, 0, 0, 0, 0),
(73, 4, 4, '12 La Canebière', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75014', 'PARIS', '2025-08-17', '2025-08-17', '06:00:00', '14:30:00', '09:00:00', 60, 3, 0, 0, 0, 0),
(74, 10, 10, '14 Boulevard Haussmann', NULL, '75015', 'PARIS', '12 La Canebière', NULL, '13007', 'MARSEILLE', '2025-08-01', '2025-08-01', '08:30:00', '17:00:00', '09:00:00', 63, 1, 0, 0, 0, 0),
(75, 4, 4, '10 Rue Lafayette', NULL, '75002', 'PARIS', '12 La Canebière', NULL, '13007', 'MARSEILLE', '2025-08-10', '2025-08-10', '09:15:00', '17:45:00', '09:00:00', 62, 2, 1, 0, 0, 0),
(76, 8, 8, '9 Place Castellane', NULL, '13014', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75003', 'PARIS', '2025-08-04', '2025-08-04', '06:15:00', '14:45:00', '09:00:00', 50, 3, 0, 0, 0, 0),
(77, 7, 7, '22 Rue Paradis', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-19', '2025-08-19', '14:00:00', '22:30:00', '09:00:00', 64, 4, 1, 0, 0, 0),
(78, 5, 5, '22 Avenue Jean Jaurès', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13016', 'MARSEILLE', '2025-08-16', '2025-08-16', '12:00:00', '20:30:00', '09:00:00', 64, 3, 1, 0, 0, 0),
(79, 2, 2, '12 La Canebière', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75004', 'PARIS', '2025-08-14', '2025-08-14', '11:30:00', '20:00:00', '09:00:00', 40, 4, 0, 0, 0, 0),
(80, 9, 9, '22 Rue Paradis', NULL, '13007', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75019', 'PARIS', '2025-08-25', '2025-08-25', '10:30:00', '19:00:00', '09:00:00', 63, 4, 1, 0, 0, 0),
(81, 3, 3, '12 La Canebière', NULL, '13013', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75003', 'PARIS', '2025-08-22', '2025-08-22', '14:45:00', '23:15:00', '09:00:00', 37, 3, 0, 0, 0, 0),
(82, 3, 3, '10 Rue Lafayette', NULL, '75003', 'PARIS', '8 Rue de Rome', NULL, '13007', 'MARSEILLE', '2025-08-09', '2025-08-09', '09:45:00', '18:15:00', '09:00:00', 39, 3, 1, 0, 0, 0),
(83, 4, 4, '16 Boulevard Longchamp', NULL, '13015', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75009', 'PARIS', '2025-08-02', '2025-08-02', '08:45:00', '17:15:00', '09:00:00', 46, 2, 0, 0, 0, 0),
(84, 6, 6, '8 Rue de Rome', NULL, '13016', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75005', 'PARIS', '2025-08-19', '2025-08-19', '06:45:00', '15:15:00', '09:00:00', 36, 4, 0, 0, 0, 0),
(85, 4, 4, '22 Rue Paradis', NULL, '13008', 'MARSEILLE', '36 Rue de Belleville', NULL, '75008', 'PARIS', '2025-08-18', '2025-08-18', '09:30:00', '18:00:00', '09:00:00', 58, 2, 1, 0, 0, 0),
(86, 8, 8, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '22 Rue Paradis', NULL, '13011', 'MARSEILLE', '2025-08-23', '2025-08-23', '07:15:00', '15:45:00', '09:00:00', 64, 1, 1, 0, 0, 0),
(87, 6, 6, '50 Rue de Rivoli', NULL, '75018', 'PARIS', '12 La Canebière', NULL, '13006', 'MARSEILLE', '2025-08-30', '2025-08-30', '11:45:00', '20:15:00', '09:00:00', 59, 1, 0, 0, 0, 0),
(88, 4, 4, '10 Rue Lafayette', NULL, '75002', 'PARIS', '12 La Canebière', NULL, '13014', 'MARSEILLE', '2025-08-13', '2025-08-13', '06:45:00', '15:15:00', '09:00:00', 57, 3, 0, 0, 0, 0),
(89, 5, 5, '12 La Canebière', NULL, '13015', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75013', 'PARIS', '2025-08-22', '2025-08-22', '14:00:00', '22:30:00', '09:00:00', 42, 3, 1, 0, 0, 0),
(90, 9, 9, '9 Place Castellane', NULL, '13015', 'MARSEILLE', '10 Rue Lafayette', NULL, '75019', 'PARIS', '2025-08-16', '2025-08-16', '06:00:00', '14:30:00', '09:00:00', 64, 2, 0, 0, 0, 0),
(91, 2, 2, '22 Avenue Jean Jaurès', NULL, '75017', 'PARIS', '8 Rue de Rome', NULL, '13012', 'MARSEILLE', '2025-08-15', '2025-08-15', '11:00:00', '19:30:00', '09:00:00', 37, 1, 1, 0, 0, 0),
(92, 7, 7, '36 Rue de Belleville', NULL, '75006', 'PARIS', '8 Rue de Rome', NULL, '13005', 'MARSEILLE', '2025-08-05', '2025-08-05', '11:15:00', '19:45:00', '09:00:00', 52, 2, 1, 0, 0, 0),
(93, 5, 5, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '16 Boulevard Longchamp', NULL, '13012', 'MARSEILLE', '2025-08-23', '2025-08-23', '08:00:00', '16:30:00', '09:00:00', 43, 2, 1, 0, 0, 0),
(94, 10, 10, '14 Boulevard Haussmann', NULL, '75004', 'PARIS', '12 La Canebière', NULL, '13015', 'MARSEILLE', '2025-08-19', '2025-08-19', '13:00:00', '21:30:00', '09:00:00', 35, 1, 0, 0, 0, 0),
(95, 3, 3, '8 Rue de Rome', NULL, '13003', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75003', 'PARIS', '2025-08-08', '2025-08-08', '11:00:00', '19:30:00', '09:00:00', 64, 1, 1, 0, 0, 0),
(96, 5, 5, '36 Rue de Belleville', NULL, '75016', 'PARIS', '9 Place Castellane', NULL, '13003', 'MARSEILLE', '2025-08-01', '2025-08-01', '13:30:00', '22:00:00', '09:00:00', 58, 2, 0, 0, 0, 0),
(97, 2, 2, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75002', 'PARIS', '2025-08-02', '2025-08-02', '06:00:00', '14:30:00', '09:00:00', 47, 3, 0, 0, 0, 0),
(98, 7, 7, '36 Rue de Belleville', NULL, '75010', 'PARIS', '18 Quai du Port', NULL, '13016', 'MARSEILLE', '2025-08-09', '2025-08-09', '10:30:00', '19:00:00', '09:00:00', 61, 2, 0, 0, 0, 0),
(99, 3, 3, '5 Rue Oberkampf', NULL, '75016', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-14', '2025-08-14', '14:15:00', '22:45:00', '09:00:00', 53, 2, 0, 0, 0, 0),
(100, 10, 10, '9 Place Castellane', NULL, '13003', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75017', 'PARIS', '2025-08-28', '2025-08-28', '12:15:00', '20:45:00', '09:00:00', 56, 1, 0, 0, 0, 0),
(101, 1, 1, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-01', '2025-08-01', '08:00:00', '16:45:00', '09:30:00', 58, 3, 1, 0, 0, 0),
(102, 2, 2, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-01', '2025-08-01', '09:15:00', '18:00:00', '09:45:00', 45, 2, 0, 0, 0, 0),
(103, 3, 3, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '2025-08-02', '2025-08-02', '10:30:00', '19:00:00', '09:30:00', 55, 1, 1, 0, 0, 0),
(104, 4, 4, '18 Quai du Port', NULL, '13002', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-02', '2025-08-02', '11:00:00', '20:00:00', '10:00:00', 62, 4, 0, 0, 0, 0),
(105, 5, 5, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-03', '2025-08-03', '07:45:00', '16:15:00', '09:30:00', 68, 3, 1, 0, 0, 0),
(106, 6, 6, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-03', '2025-08-03', '06:30:00', '15:30:00', '10:00:00', 48, 2, 0, 0, 0, 0),
(107, 7, 7, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-04', '2025-08-04', '12:00:00', '21:00:00', '10:00:00', 51, 1, 0, 0, 0, 0),
(108, 8, 8, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-04', '2025-08-04', '13:15:00', '22:00:00', '09:45:00', 59, 3, 1, 0, 0, 0),
(109, 9, 9, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-05', '2025-08-05', '09:00:00', '17:30:00', '09:30:00', 42, 2, 1, 0, 0, 0),
(110, 10, 10, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-05', '2025-08-05', '08:30:00', '18:00:00', '10:30:00', 65, 4, 0, 0, 0, 0),
(111, 1, 1, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-06', '2025-08-06', '07:00:00', '16:00:00', '10:00:00', 53, 1, 0, 0, 0, 0),
(112, 2, 2, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-06', '2025-08-06', '14:00:00', '22:45:00', '09:45:00', 49, 3, 0, 0, 0, 0),
(113, 3, 3, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-07', '2025-08-07', '10:00:00', '18:30:00', '09:30:00', 61, 2, 1, 0, 0, 0),
(114, 4, 4, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-07', '2025-08-07', '08:15:00', '17:00:00', '09:45:00', 50, 4, 0, 0, 0, 0),
(115, 5, 5, '18 Quai du Port', NULL, '13002', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-08', '2025-08-08', '09:30:00', '19:00:00', '10:30:00', 66, 3, 1, 0, 0, 0),
(116, 6, 6, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '2025-08-08', '2025-08-08', '11:30:00', '20:15:00', '09:45:00', 47, 1, 0, 0, 0, 0),
(117, 7, 7, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-09', '2025-08-09', '13:00:00', '22:00:00', '10:00:00', 54, 2, 0, 0, 0, 0),
(118, 8, 8, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-09', '2025-08-09', '07:00:00', '15:30:00', '09:30:00', 63, 4, 1, 0, 0, 0),
(119, 9, 9, '12 La Canebière', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-10', '2025-08-10', '08:45:00', '17:45:00', '10:00:00', 44, 3, 1, 0, 0, 0),
(120, 10, 10, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-10', '2025-08-10', '09:45:00', '18:15:00', '09:30:00', 56, 1, 0, 0, 0, 0),
(121, 1, 1, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-11', '2025-08-11', '10:15:00', '19:30:00', '10:15:00', 60, 2, 0, 0, 0, 0),
(122, 3, 3, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-11', '2025-08-11', '11:45:00', '20:45:00', '10:00:00', 52, 3, 1, 0, 0, 0),
(123, 4, 4, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-12', '2025-08-12', '06:00:00', '15:00:00', '10:00:00', 69, 4, 0, 0, 0, 0),
(124, 5, 5, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-12', '2025-08-12', '07:30:00', '16:15:00', '09:45:00', 41, 1, 1, 0, 0, 0),
(125, 6, 6, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-13', '2025-08-13', '08:00:00', '17:30:00', '10:30:00', 57, 2, 0, 0, 0, 0),
(126, 7, 7, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-13', '2025-08-13', '09:00:00', '18:00:00', '10:00:00', 46, 3, 0, 0, 0, 0),
(127, 8, 8, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-14', '2025-08-14', '10:30:00', '19:15:00', '09:45:00', 64, 4, 1, 0, 0, 0),
(128, 9, 9, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-14', '2025-08-14', '12:15:00', '21:00:00', '09:45:00', 40, 1, 1, 0, 0, 0),
(129, 10, 10, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-15', '2025-08-15', '13:30:00', '22:30:00', '10:00:00', 58, 2, 0, 0, 0, 0),
(130, 2, 2, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-15', '2025-08-15', '14:00:00', '23:00:00', '10:00:00', 50, 3, 0, 0, 0, 0),
(131, 1, 1, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-16', '2025-08-16', '06:45:00', '15:30:00', '09:45:00', 67, 4, 0, 0, 0, 0),
(132, 3, 3, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-16', '2025-08-16', '07:15:00', '16:00:00', '09:45:00', 43, 1, 1, 0, 0, 0),
(133, 5, 5, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-17', '2025-08-17', '08:30:00', '17:45:00', '10:15:00', 53, 2, 1, 0, 0, 0),
(134, 7, 7, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-17', '2025-08-17', '09:45:00', '18:30:00', '09:45:00', 59, 3, 0, 0, 0, 0),
(135, 8, 8, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-18', '2025-08-18', '10:00:00', '19:00:00', '10:00:00', 42, 4, 1, 0, 0, 0),
(136, 10, 10, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-18', '2025-08-18', '11:15:00', '20:30:00', '10:15:00', 61, 1, 0, 0, 0, 0),
(137, 1, 1, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-19', '2025-08-19', '12:30:00', '21:15:00', '09:45:00', 48, 2, 0, 0, 0, 0),
(138, 2, 2, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-19', '2025-08-19', '13:45:00', '22:30:00', '09:45:00', 55, 3, 0, 0, 0, 0),
(139, 4, 4, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-20', '2025-08-20', '14:00:00', '23:00:00', '10:00:00', 65, 4, 0, 0, 0, 0),
(140, 6, 6, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-20', '2025-08-20', '06:15:00', '15:00:00', '09:45:00', 39, 1, 0, 0, 0, 0),
(141, 9, 9, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-21', '2025-08-21', '07:30:00', '16:30:00', '10:00:00', 51, 2, 1, 0, 0, 0),
(142, 1, 1, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-21', '2025-08-21', '08:45:00', '17:30:00', '09:45:00', 49, 3, 0, 0, 0, 0),
(143, 3, 3, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-22', '2025-08-22', '09:00:00', '18:15:00', '10:15:00', 63, 4, 1, 0, 0, 0),
(144, 5, 5, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-22', '2025-08-22', '10:30:00', '19:15:00', '09:45:00', 44, 1, 1, 0, 0, 0),
(145, 7, 7, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-23', '2025-08-23', '11:00:00', '20:00:00', '10:00:00', 56, 2, 0, 0, 0, 0),
(146, 8, 8, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-23', '2025-08-23', '12:45:00', '21:30:00', '09:45:00', 50, 3, 1, 0, 0, 0),
(147, 10, 10, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-24', '2025-08-24', '13:00:00', '22:15:00', '10:15:00', 62, 4, 0, 0, 0, 0),
(148, 1, 1, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-24', '2025-08-24', '14:15:00', '23:00:00', '09:45:00', 45, 1, 0, 0, 0, 0),
(149, 2, 2, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-25', '2025-08-25', '08:30:00', '17:15:00', '09:45:00', 54, 2, 0, 0, 0, 0),
(150, 4, 4, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-25', '2025-08-25', '09:30:00', '18:30:00', '10:00:00', 47, 3, 0, 0, 0, 0),
(151, 6, 6, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-26', '2025-08-26', '10:45:00', '19:30:00', '09:45:00', 66, 4, 0, 0, 0, 0),
(152, 8, 8, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-26', '2025-08-26', '11:00:00', '20:00:00', '10:00:00', 41, 1, 1, 0, 0, 0),
(153, 1, 1, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-27', '2025-08-27', '12:00:00', '21:00:00', '10:00:00', 52, 2, 0, 0, 0, 0),
(154, 3, 3, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-27', '2025-08-27', '13:30:00', '22:15:00', '09:45:00', 58, 3, 1, 0, 0, 0),
(155, 5, 5, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-28', '2025-08-28', '14:30:00', '23:00:00', '09:30:00', 61, 4, 1, 0, 0, 0),
(156, 7, 7, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-28', '2025-08-28', '08:00:00', '16:45:00', '09:45:00', 38, 1, 0, 0, 0, 0),
(157, 9, 9, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-29', '2025-08-29', '09:15:00', '18:00:00', '09:45:00', 57, 2, 1, 0, 0, 0),
(158, 10, 10, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-29', '2025-08-29', '10:00:00', '19:30:00', '10:30:00', 46, 3, 0, 0, 0, 0),
(159, 2, 2, '36 Rue de Belleville', NULL, '75020', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-30', '2025-08-30', '11:30:00', '20:15:00', '09:45:00', 64, 4, 0, 0, 0, 0),
(160, 4, 4, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-30', '2025-08-30', '12:30:00', '21:30:00', '10:00:00', 43, 1, 0, 0, 0, 0),
(161, 6, 6, '10 Rue Lafayette', NULL, '75009', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-31', '2025-08-31', '13:45:00', '22:30:00', '09:45:00', 59, 2, 0, 0, 0, 0),
(162, 8, 8, '12 La Canebière', NULL, '13001', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-31', '2025-08-31', '14:00:00', '23:00:00', '10:00:00', 51, 3, 1, 0, 0, 0),
(163, 1, 1, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-01', '2025-08-01', '07:30:00', '16:00:00', '09:30:00', 55, 2, 1, 0, 0, 0),
(164, 2, 2, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-01', '2025-08-01', '08:45:00', '18:15:00', '10:30:00', 47, 3, 0, 0, 0, 0),
(165, 3, 3, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-02', '2025-08-02', '09:00:00', '17:45:00', '09:45:00', 62, 1, 0, 0, 0, 0),
(166, 4, 4, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-02', '2025-08-02', '10:15:00', '19:45:00', '10:30:00', 58, 4, 1, 0, 0, 0),
(167, 5, 5, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-03', '2025-08-03', '11:30:00', '20:15:00', '09:45:00', 65, 3, 1, 0, 0, 0),
(168, 6, 6, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-03', '2025-08-03', '06:00:00', '15:00:00', '10:00:00', 49, 2, 0, 0, 0, 0),
(169, 7, 7, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-04', '2025-08-04', '07:45:00', '16:30:00', '09:45:00', 53, 1, 0, 0, 0, 0),
(170, 8, 8, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-04', '2025-08-04', '08:00:00', '17:00:00', '10:00:00', 60, 3, 1, 0, 0, 0),
(171, 9, 9, '10 Rue Lafayette', NULL, '75009', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-05', '2025-08-05', '09:30:00', '18:00:00', '09:30:00', 44, 2, 1, 0, 0, 0),
(172, 10, 10, '12 La Canebière', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-05', '2025-08-05', '10:00:00', '19:45:00', '10:45:00', 68, 4, 0, 0, 0, 0),
(173, 1, 1, '36 Rue de Belleville', NULL, '75020', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-06', '2025-08-06', '11:15:00', '20:00:00', '09:45:00', 51, 1, 0, 0, 0, 0),
(174, 2, 2, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-06', '2025-08-06', '12:30:00', '21:15:00', '09:45:00', 56, 3, 0, 0, 0, 0),
(175, 3, 3, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-07', '2025-08-07', '13:00:00', '22:00:00', '10:00:00', 63, 2, 1, 0, 0, 0),
(176, 4, 4, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-07', '2025-08-07', '06:45:00', '15:30:00', '09:45:00', 48, 4, 0, 0, 0, 0),
(177, 5, 5, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-08', '2025-08-08', '07:00:00', '16:30:00', '10:30:00', 67, 3, 1, 0, 0, 0),
(178, 6, 6, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-08', '2025-08-08', '08:15:00', '17:00:00', '09:45:00', 42, 1, 0, 0, 0, 0),
(179, 7, 7, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-09', '2025-08-09', '09:45:00', '18:45:00', '10:00:00', 54, 2, 0, 0, 0, 0),
(180, 8, 8, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-09', '2025-08-09', '10:30:00', '19:15:00', '09:45:00', 61, 4, 1, 0, 0, 0),
(181, 9, 9, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-10', '2025-08-10', '11:00:00', '20:00:00', '10:00:00', 46, 3, 1, 0, 0, 0),
(182, 10, 10, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-10', '2025-08-10', '12:15:00', '21:00:00', '09:45:00', 59, 1, 0, 0, 0, 0),
(183, 1, 1, '10 Rue Lafayette', NULL, '75009', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-11', '2025-08-11', '13:30:00', '22:15:00', '09:45:00', 50, 2, 0, 0, 0, 0),
(184, 2, 2, '12 La Canebière', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-11', '2025-08-11', '06:30:00', '15:15:00', '09:45:00', 52, 3, 1, 0, 0, 0),
(185, 3, 3, '36 Rue de Belleville', NULL, '75020', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-12', '2025-08-12', '07:15:00', '16:00:00', '09:45:00', 69, 4, 0, 0, 0, 0),
(186, 4, 4, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-12', '2025-08-12', '08:30:00', '17:30:00', '10:00:00', 40, 1, 1, 0, 0, 0),
(187, 5, 5, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-13', '2025-08-13', '09:45:00', '19:00:00', '10:15:00', 57, 2, 0, 0, 0, 0),
(188, 6, 6, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-13', '2025-08-13', '10:00:00', '19:00:00', '10:00:00', 47, 3, 0, 0, 0, 0),
(189, 7, 7, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-14', '2025-08-14', '11:15:00', '20:00:00', '09:45:00', 66, 4, 1, 0, 0, 0),
(190, 8, 8, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-14', '2025-08-14', '12:30:00', '21:30:00', '10:00:00', 41, 1, 1, 0, 0, 0),
(191, 9, 9, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-15', '2025-08-15', '13:45:00', '22:30:00', '09:45:00', 58, 2, 0, 0, 0, 0),
(192, 10, 10, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-15', '2025-08-15', '14:00:00', '23:00:00', '10:00:00', 53, 3, 0, 0, 0, 0),
(193, 1, 1, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-16', '2025-08-16', '06:00:00', '15:00:00', '10:00:00', 68, 4, 0, 0, 0, 0),
(194, 2, 2, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-16', '2025-08-16', '07:30:00', '16:15:00', '09:45:00', 39, 1, 1, 0, 0, 0),
(195, 3, 3, '10 Rue Lafayette', NULL, '75009', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-17', '2025-08-17', '08:45:00', '18:00:00', '10:15:00', 52, 2, 1, 0, 0, 0),
(196, 4, 4, '12 La Canebière', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-17', '2025-08-17', '09:00:00', '17:45:00', '09:45:00', 57, 3, 0, 0, 0, 0),
(197, 5, 5, '36 Rue de Belleville', NULL, '75020', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-18', '2025-08-18', '10:15:00', '19:15:00', '10:00:00', 43, 4, 1, 0, 0, 0),
(198, 6, 6, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-18', '2025-08-18', '11:30:00', '20:45:00', '10:15:00', 60, 1, 0, 0, 0, 0),
(199, 7, 7, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-19', '2025-08-19', '12:00:00', '20:45:00', '09:45:00', 47, 2, 0, 0, 0, 0),
(200, 8, 8, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-19', '2025-08-19', '13:15:00', '22:00:00', '09:45:00', 55, 3, 0, 0, 0, 0),
(201, 9, 9, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-20', '2025-08-20', '14:30:00', '23:00:00', '09:30:00', 64, 4, 0, 0, 0, 0),
(202, 10, 10, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-20', '2025-08-20', '06:45:00', '15:30:00', '09:45:00', 38, 1, 0, 0, 0, 0),
(203, 1, 1, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-21', '2025-08-21', '07:00:00', '16:00:00', '10:00:00', 50, 2, 1, 0, 0, 0),
(204, 2, 2, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-21', '2025-08-21', '08:15:00', '17:00:00', '09:45:00', 48, 3, 0, 0, 0, 0),
(205, 3, 3, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-22', '2025-08-22', '09:30:00', '18:30:00', '10:00:00', 65, 4, 1, 0, 0, 0),
(206, 4, 4, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-22', '2025-08-22', '10:45:00', '19:30:00', '09:45:00', 45, 1, 1, 0, 0, 0),
(207, 5, 5, '10 Rue Lafayette', NULL, '75009', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-23', '2025-08-23', '11:00:00', '20:00:00', '10:00:00', 56, 2, 0, 0, 0, 0),
(208, 6, 6, '12 La Canebière', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-23', '2025-08-23', '12:15:00', '21:00:00', '09:45:00', 51, 3, 1, 0, 0, 0),
(209, 7, 7, '36 Rue de Belleville', NULL, '75020', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-24', '2025-08-24', '13:30:00', '22:30:00', '10:00:00', 62, 4, 0, 0, 0, 0),
(210, 8, 8, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-24', '2025-08-24', '14:00:00', '23:00:00', '10:00:00', 46, 1, 0, 0, 0, 0),
(211, 9, 9, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-25', '2025-08-25', '08:30:00', '17:15:00', '09:45:00', 53, 2, 0, 0, 0, 0),
(212, 10, 10, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-25', '2025-08-25', '09:30:00', '18:30:00', '10:00:00', 48, 3, 0, 0, 0, 0),
(213, 1, 1, '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '9 Place Castellane', NULL, '13006', 'MARSEILLE', '2025-08-26', '2025-08-26', '10:45:00', '19:30:00', '09:45:00', 67, 4, 0, 0, 0, 0),
(214, 2, 2, '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '10 Rue Lafayette', NULL, '75009', 'PARIS', '2025-08-26', '2025-08-26', '11:00:00', '20:00:00', '10:00:00', 40, 1, 1, 0, 0, 0),
(215, 3, 3, '50 Rue de Rivoli', NULL, '75001', 'PARIS', '12 La Canebière', NULL, '13001', 'MARSEILLE', '2025-08-27', '2025-08-27', '12:00:00', '21:00:00', '10:00:00', 51, 2, 0, 0, 0, 0),
(216, 4, 4, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '36 Rue de Belleville', NULL, '75020', 'PARIS', '2025-08-27', '2025-08-27', '13:30:00', '22:15:00', '09:45:00', 57, 3, 1, 0, 0, 0),
(217, 5, 5, '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-28', '2025-08-28', '14:30:00', '23:00:00', '09:30:00', 60, 4, 1, 0, 0, 0),
(218, 6, 6, '9 Place Castellane', NULL, '13006', 'MARSEILLE', '5 Rue Oberkampf', NULL, '75011', 'PARIS', '2025-08-28', '2025-08-28', '08:00:00', '16:45:00', '09:45:00', 39, 1, 0, 0, 0, 0),
(219, 7, 7, '10 Rue Lafayette', NULL, '75009', 'PARIS', '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '2025-08-29', '2025-08-29', '09:15:00', '18:00:00', '09:45:00', 56, 2, 1, 0, 0, 0),
(220, 8, 8, '12 La Canebière', NULL, '13001', 'MARSEILLE', '22 Avenue Jean Jaurès', NULL, '75019', 'PARIS', '2025-08-29', '2025-08-29', '10:00:00', '19:30:00', '10:30:00', 45, 3, 0, 0, 0, 0),
(221, 9, 9, '36 Rue de Belleville', NULL, '75020', 'PARIS', '16 Boulevard Longchamp', NULL, '13001', 'MARSEILLE', '2025-08-30', '2025-08-30', '11:30:00', '20:15:00', '09:45:00', 63, 4, 0, 0, 0, 0),
(222, 10, 10, '22 Rue Paradis', NULL, '13006', 'MARSEILLE', '50 Rue de Rivoli', NULL, '75001', 'PARIS', '2025-08-30', '2025-08-30', '12:30:00', '21:30:00', '10:00:00', 42, 1, 0, 0, 0, 0),
(223, 1, 1, '5 Rue Oberkampf', NULL, '75011', 'PARIS', '18 Quai du Port', NULL, '13002', 'MARSEILLE', '2025-08-31', '2025-08-31', '13:45:00', '22:30:00', '09:45:00', 58, 2, 0, 0, 0, 0),
(224, 2, 2, '8 Rue de Rome', NULL, '13001', 'MARSEILLE', '14 Boulevard Haussmann', NULL, '75009', 'PARIS', '2025-08-31', '2025-08-31', '14:00:00', '23:00:00', '10:00:00', 50, 3, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `donnees`
--

CREATE TABLE `donnees` (
  `donne_id` bigint UNSIGNED NOT NULL,
  `date_stat` date NOT NULL,
  `n_covoit` int UNSIGNED NOT NULL DEFAULT '0',
  `n_credit` int UNSIGNED NOT NULL DEFAULT '0',
  `n_credit_tot` bigint UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `flux`
--

CREATE TABLE `flux` (
  `flux_id` bigint UNSIGNED NOT NULL,
  `conf_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `montant` int NOT NULL,
  `type` enum('reservation','bonus_inscription','remboursement','achat_credit') NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_07_19_174506_create_voitures_table', 1);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `satisfaction`
--

CREATE TABLE `satisfaction` (
  `satisfaction_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `covoit_id` bigint UNSIGNED NOT NULL,
  `feeling` tinyint(1) NOT NULL,
  `comment` text,
  `review` text,
  `note` tinyint UNSIGNED DEFAULT NULL,
  `date` date NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(18) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `n_credit` int UNSIGNED NOT NULL DEFAULT '20',
  `photo` longblob,
  `phototype` varchar(255) DEFAULT NULL,
  `role` enum('Passager','Conducteur','Les deux','Employé','Admin') NOT NULL DEFAULT 'Passager',
  `pref_smoke` enum('Fumeur','Non-fumeur') DEFAULT NULL,
  `pref_pet` enum('Acceptés','Non-acceptés') DEFAULT NULL,
  `pref_libre` text,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `n_credit`, `photo`, `phototype`, `role`, `pref_smoke`, `pref_pet`, `pref_libre`, `deleted_at`) VALUES
(1, 'Marie Dubois', 'marie.dubois@email.com', '$2y$12$example1', 50, NULL, NULL, 'Conducteur', 'Non-fumeur', 'Acceptés', NULL, NULL),
(2, 'Pierre Martin', 'pierre.martin@email.com', '$2y$12$example2', 45, NULL, NULL, 'Les deux', 'Non-fumeur', 'Non-acceptés', NULL, NULL),
(3, 'Sophie Leblanc', 'sophie.leblanc@email.com', '$2y$12$example3', 60, NULL, NULL, 'Conducteur', 'Fumeur', 'Acceptés', NULL, NULL),
(4, 'Antoine Roussel', 'antoine.roussel@email.com', '$2y$12$example4', 35, NULL, NULL, 'Conducteur', 'Non-fumeur', 'Acceptés', NULL, NULL),
(5, 'Claire Moreau', 'claire.moreau@email.com', '$2y$12$example5', 55, NULL, NULL, 'Les deux', 'Non-fumeur', 'Non-acceptés', NULL, NULL),
(6, 'Thomas Bernard', 'thomas.bernard@email.com', '$2y$12$example6', 40, NULL, NULL, 'Conducteur', 'Non-fumeur', 'Acceptés', NULL, NULL),
(7, 'Camille Petit', 'camille.petit@email.com', '$2y$12$example7', 48, NULL, NULL, 'Conducteur', 'Non-fumeur', 'Acceptés', NULL, NULL),
(8, 'Lucas Roux', 'lucas.roux@email.com', '$2y$12$example8', 42, NULL, NULL, 'Les deux', 'Fumeur', 'Non-acceptés', NULL, NULL),
(9, 'Emma Girard', 'emma.girard@email.com', '$2y$12$example9', 42, NULL, NULL, 'Les deux', 'Fumeur', 'Non-acceptés', NULL, NULL),
(10, 'Julien Leroy', 'julien.leroy@email.com', '$2y$12$example10', 42, NULL, NULL, 'Les deux', 'Fumeur', 'Non-acceptés', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `voiture`
--

CREATE TABLE `voiture` (
  `voiture_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `immat` varchar(10) NOT NULL,
  `date_first_immat` date NOT NULL,
  `brand` varchar(12) NOT NULL,
  `model` varchar(24) NOT NULL,
  `color` varchar(12) NOT NULL,
  `n_place` tinyint UNSIGNED NOT NULL,
  `energie` enum('Electrique','Hybride','Diesel/Gazole','Essence','GPL') NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

--
-- Déchargement des données de la table `voiture`
--

INSERT INTO `voiture` (`voiture_id`, `user_id`, `immat`, `date_first_immat`, `brand`, `model`, `color`, `n_place`, `energie`, `deleted_at`) VALUES
(1, 1, 'AB-123-CD', '2020-03-15', 'Renault', 'Clio', 'Blanc', 4, 'Essence', NULL),
(2, 2, 'EF-456-GH', '2019-07-22', 'Peugeot', '308', 'Noir', 5, 'Diesel/Gazole', NULL),
(3, 3, 'IJ-789-KL', '2021-01-10', 'Citroën', 'C3', 'Rouge', 4, 'Essence', NULL),
(4, 4, 'MN-012-OP', '2018-11-05', 'Volkswagen', 'Golf', 'Bleu', 5, 'Diesel/Gazole', NULL),
(5, 5, 'QR-345-ST', '2022-02-28', 'Tesla', 'Model 3', 'Blanc', 5, 'Electrique', NULL),
(6, 6, 'UV-678-WX', '2020-09-14', 'BMW', 'Serie 3', 'Gris', 5, 'Diesel/Gazole', NULL),
(7, 7, 'YZ-901-AB', '2019-12-03', 'Audi', 'A3', 'Noir', 4, 'Essence', NULL),
(8, 8, 'CD-234-EF', '2021-06-18', 'Toyota', 'Prius', 'Blanc', 5, 'Hybride', NULL),
(9, 9, 'GH-567-IJ', '2020-04-25', 'Nissan', 'Leaf', 'Bleu', 5, 'Electrique', NULL),
(10, 10, 'KL-890-MN', '2018-08-12', 'Ford', 'Focus', 'Rouge', 5, 'Essence', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `confirmation`
--
ALTER TABLE `confirmation`
  ADD PRIMARY KEY (`conf_id`),
  ADD KEY `covoit_id` (`covoit_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Index pour la table `covoiturage`
--
ALTER TABLE `covoiturage`
  ADD PRIMARY KEY (`covoit_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `voiture_id` (`voiture_id`);

--
-- Index pour la table `donnees`
--
ALTER TABLE `donnees`
  ADD PRIMARY KEY (`donne_id`),
  ADD UNIQUE KEY `date_stat` (`date_stat`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `flux`
--
ALTER TABLE `flux`
  ADD PRIMARY KEY (`flux_id`),
  ADD KEY `conf_id` (`conf_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `satisfaction`
--
ALTER TABLE `satisfaction`
  ADD PRIMARY KEY (`satisfaction_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `covoit_id` (`covoit_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `voiture`
--
ALTER TABLE `voiture`
  ADD PRIMARY KEY (`voiture_id`),
  ADD UNIQUE KEY `immat` (`immat`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `confirmation`
--
ALTER TABLE `confirmation`
  MODIFY `conf_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `contact_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `covoiturage`
--
ALTER TABLE `covoiturage`
  MODIFY `covoit_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `donnees`
--
ALTER TABLE `donnees`
  MODIFY `donne_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `flux`
--
ALTER TABLE `flux`
  MODIFY `flux_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `satisfaction`
--
ALTER TABLE `satisfaction`
  MODIFY `satisfaction_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `voiture`
--
ALTER TABLE `voiture`
  MODIFY `voiture_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `confirmation`
--
ALTER TABLE `confirmation`
  ADD CONSTRAINT `confirmation_ibfk_1` FOREIGN KEY (`covoit_id`) REFERENCES `covoiturage` (`covoit_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `confirmation_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `covoiturage`
--
ALTER TABLE `covoiturage`
  ADD CONSTRAINT `covoiturage_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `covoiturage_ibfk_2` FOREIGN KEY (`voiture_id`) REFERENCES `voiture` (`voiture_id`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `flux`
--
ALTER TABLE `flux`
  ADD CONSTRAINT `flux_ibfk_1` FOREIGN KEY (`conf_id`) REFERENCES `confirmation` (`conf_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `flux_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `satisfaction`
--
ALTER TABLE `satisfaction`
  ADD CONSTRAINT `satisfaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `satisfaction_ibfk_2` FOREIGN KEY (`covoit_id`) REFERENCES `covoiturage` (`covoit_id`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `voiture`
--
ALTER TABLE `voiture`
  ADD CONSTRAINT `voiture_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
