-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql
-- Généré le : sam. 19 juil. 2025 à 19:33
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
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(18) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `n_credit` int UNSIGNED NOT NULL DEFAULT '20',
  `idphoto` longblob,
  `role` enum('Passager','Conducteur','Les deux','Employé','Admin') NOT NULL DEFAULT 'Passager',
  `pref_smoke` enum('Fumeur','Non-fumeur') DEFAULT NULL,
  `pref_pet` enum('Acceptés','Non-acceptés') DEFAULT NULL,
  `pref_libre` text,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
-- Index pour les tables déchargées
--

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
-- Index pour la table `flux`
--
ALTER TABLE `flux`
  ADD PRIMARY KEY (`flux_id`),
  ADD KEY `conf_id` (`conf_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `satisfaction`
--
ALTER TABLE `satisfaction`
  ADD PRIMARY KEY (`satisfaction_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `covoit_id` (`covoit_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `mail` (`mail`);

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
-- AUTO_INCREMENT pour la table `flux`
--
ALTER TABLE `flux`
  MODIFY `flux_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `satisfaction`
--
ALTER TABLE `satisfaction`
  MODIFY `satisfaction_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
