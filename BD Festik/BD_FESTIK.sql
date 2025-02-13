-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 13 fév. 2025 à 11:15
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `festik`
--
CREATE DATABASE IF NOT EXISTS `festik` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `festik`;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `ID_C` int(11) NOT NULL AUTO_INCREMENT,
  `PRENOM_C` varchar(255) NOT NULL,
  `NOM_C` varchar(255) NOT NULL,
  `MAIL_C` varchar(255) NOT NULL,
  `TEL_C` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_C`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `evenement`
--

CREATE TABLE IF NOT EXISTS `evenement` (
  `ID_EVE` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE_EVE` varchar(255) NOT NULL,
  `NOM_EVE` varchar(255) NOT NULL,
  `DATE_DEBUT` date NOT NULL,
  `DATE_FIN` date NOT NULL,
  `LIEU_EVE` varchar(255) NOT NULL,
  `JAUGE` int(11) NOT NULL,
  `ID_STRUCT` int(11) NOT NULL,
  PRIMARY KEY (`ID_EVE`),
  KEY `EVENEMENT_STRUCT_FK` (`ID_STRUCT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `festik`
--

CREATE TABLE IF NOT EXISTS `festik` (
  `ID_EMPLOYE` int(11) NOT NULL AUTO_INCREMENT,
  `PRENOM` varchar(255) NOT NULL,
  `NOM` varchar(255) NOT NULL,
  `POSTE` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_EMPLOYE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `interaction`
--

CREATE TABLE IF NOT EXISTS `interaction` (
  `ID_C` int(11) NOT NULL,
  `ID_EMPLOYE` int(11) NOT NULL,
  `ID_EVE` int(11) NOT NULL,
  `DATE_C` date NOT NULL,
  `DATE_PROCHAIN_C` date DEFAULT NULL,
  `STATUT_C` varchar(255) NOT NULL COMMENT 'PRIORITE=1-5',
  `COMMENTAIRES_INTERACTION` text NOT NULL,
  `MODE_COMMUNICATION` varchar(255) NOT NULL,
  `STATUT_INTERACTION` varchar(255) NOT NULL COMMENT 'Nouveau. en contact, abandon, prospect, opportunit? ouverte, en negociation, client ou ancien clien',
  `DATE_CHANGEMENT_STATUT` datetime NOT NULL COMMENT 'La date qui permet de voir la date du changement du statut. Par defaut est la date du jour o? il y a la modification.',
  PRIMARY KEY (`ID_C`,`ID_EMPLOYE`,`ID_EVE`),
  KEY `INTERACTION_FESTIK0_FK` (`ID_EMPLOYE`),
  KEY `INTERACTION_EVE1_FK` (`ID_EVE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `represente`
--

CREATE TABLE IF NOT EXISTS `represente` (
  `ID_STRUCT` int(11) NOT NULL,
  `ID_C` int(11) NOT NULL,
  `ROLE_C` varchar(255) NOT NULL COMMENT 'Au moment de rajouter un r?le, il faut poser un affichage les contacts avec les m?mes r?les et proposer que ses m?mes contacts soit supprim?s ou gard?s (avertissement)',
  PRIMARY KEY (`ID_STRUCT`,`ID_C`),
  KEY `REPRESENTE_C0_FK` (`ID_C`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE IF NOT EXISTS `secteur` (
  `SECTEUR` varchar(255) NOT NULL,
  PRIMARY KEY (`SECTEUR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `specialisee`
--

CREATE TABLE IF NOT EXISTS `specialisee` (
  `SECTEUR` varchar(255) NOT NULL,
  `ID_STRUCT` int(11) NOT NULL,
  PRIMARY KEY (`SECTEUR`,`ID_STRUCT`),
  KEY `SPECIALISEE_STRUCT0_FK` (`ID_STRUCT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `structure`
--

CREATE TABLE IF NOT EXISTS `structure` (
  `ID_STRUCT` int(11) NOT NULL AUTO_INCREMENT,
  `NOM_STRUCT` varchar(255) NOT NULL,
  `TYPE_STRUCT` varchar(255) NOT NULL COMMENT 'PUBLIQUE OU PRIVEE',
  `MAIL_STRUCT` varchar(255) NOT NULL,
  `TEL_STRUCT` varchar(255) NOT NULL,
  `VILLE` varchar(255) NOT NULL,
  `ADRESSE` varchar(255) NOT NULL,
  `CODE_POSTALE` varchar(255) NOT NULL,
  `TAILLE_STRUCT` int(11) NOT NULL,
  `CHIFFRE_AFFAIRE_ANNUEL` int(11) NOT NULL,
  `SIRET` varchar(255) DEFAULT NULL,
  `VALEURS` varchar(255) NOT NULL COMMENT 'OUI OU NON',
  `MODE_COMMUNICATION` varchar(255) NOT NULL COMMENT 'T?l?phone, SMS, Mail, T?l?phone + SMS, T?l?phone + Mail, Mail + SMS, N''importe.',
  `COMMENTAIRES` text NOT NULL,
  PRIMARY KEY (`ID_STRUCT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `EVENEMENT_STRUCT_FK` FOREIGN KEY (`ID_STRUCT`) REFERENCES `structure` (`ID_STRUCT`);

--
-- Contraintes pour la table `interaction`
--
ALTER TABLE `interaction`
  ADD CONSTRAINT `INTERACTIONC_FK` FOREIGN KEY (`IDC`) REFERENCES `contact` (`ID_C`),
  ADD CONSTRAINT `INTERACTION_EVE1_FK` FOREIGN KEY (`ID_EVE`) REFERENCES `evenement` (`ID_EVE`),
  ADD CONSTRAINT `INTERACTION_FESTIK0_FK` FOREIGN KEY (`ID_EMPLOYE`) REFERENCES `festik` (`ID_EMPLOYE`);

--
-- Contraintes pour la table `represente`
--
ALTER TABLE `represente`
  ADD CONSTRAINT `REPRESENTE_C0_FK` FOREIGN KEY (`ID_C`) REFERENCES `contact` (`ID_C`),
  ADD CONSTRAINT `REPRESENTE_STRUCT_FK` FOREIGN KEY (`ID_STRUCT`) REFERENCES `structure` (`ID_STRUCT`);

--
-- Contraintes pour la table `specialisee`
--
ALTER TABLE `specialisee`
  ADD CONSTRAINT `SPECIALISEE_SECTEUR_FK` FOREIGN KEY (`SECTEUR`) REFERENCES `secteur` (`SECTEUR`),
  ADD CONSTRAINT `SPECIALISEE_STRUCT0_FK` FOREIGN KEY (`ID_STRUCT`) REFERENCES `structure` (`ID_STRUCT`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
