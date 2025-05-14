-- 🌍 Création de la base
CREATE DATABASE IF NOT EXISTS rpg CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rpg;

-- 👤 Table des joueurs
DROP TABLE IF EXISTS Joueur;

CREATE TABLE Joueur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    niveau INT DEFAULT 1,
    experience INT DEFAULT 0,
    montant_or INT DEFAULT 0
);

-- 🧝‍♀️ Table des personnages
DROP TABLE IF EXISTS Personnage;

CREATE TABLE Personnage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    classe VARCHAR(30) NOT NULL,
    vie INT DEFAULT 100,
    mana INT DEFAULT 100,
    force INT DEFAULT 10,
    intelligence INT DEFAULT 10,
    agilite INT DEFAULT 10,
    joueur_id INT,
    FOREIGN KEY (joueur_id) REFERENCES Joueur(id)
);

-- 🧰 Table des objets
DROP TABLE IF EXISTS Objet;

CREATE TABLE Objet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    type VARCHAR(30),
    effet TEXT,
    puissance INT DEFAULT 0,
    defense INT DEFAULT 0,
    valeur INT DEFAULT 0
);

-- 🎒 Inventaire : quels objets un personnage possède
DROP TABLE IF EXISTS Inventaire;

CREATE TABLE Inventaire (
    personnage_id INT,
    objet_id INT,
    quantite INT DEFAULT 1,
    PRIMARY KEY (personnage_id, objet_id),
    FOREIGN KEY (personnage_id) REFERENCES Personnage(id),
    FOREIGN KEY (objet_id) REFERENCES Objet(id)
);

-- 👹 Table des monstres
DROP TABLE IF EXISTS Monstre;

CREATE TABLE Monstre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    attaque INT,
    defense INT,
    vie INT
);

-- 🎁 Table des drops : ce qu’un monstre peut donner
DROP TABLE IF EXISTS DropObjet;

CREATE TABLE DropObjet (
    monstre_id INT,
    objet_id INT,
    quantite INT DEFAULT 1,
    probabilite INT, -- pourcentage 0–100
    FOREIGN KEY (monstre_id) REFERENCES Monstre(id),
    FOREIGN KEY (objet_id) REFERENCES Objet(id)
);

-- 🗣️ PNJ : personnages non-joueurs
DROP TABLE IF EXISTS PNJ;

CREATE TABLE PNJ (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    dialogue TEXT
);

-- 🏆 Table des quêtes
DROP TABLE IF EXISTS Quete;

CREATE TABLE Quete (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    difficulte INT,
    experience INT,
    recompense_or INT
);

-- 🔗 Lien : quel PNJ donne quelle quête
DROP TABLE IF EXISTS PNJ_Quete;

CREATE TABLE PNJ_Quete (
    pnj_id INT,
    quete_id INT,
    PRIMARY KEY (pnj_id, quete_id),
    FOREIGN KEY (pnj_id) REFERENCES PNJ(id),
    FOREIGN KEY (quete_id) REFERENCES Quete(id)
);

-- 📘 Quêtes acceptées ou terminées par les personnages
DROP TABLE IF EXISTS Personnage_Quete;

CREATE TABLE Personnage_Quete (
    personnage_id INT,
    quete_id INT,
    statut VARCHAR(20), -- "acceptee", "terminee"
    PRIMARY KEY (personnage_id, quete_id),
    FOREIGN KEY (personnage_id) REFERENCES Personnage(id),
    FOREIGN KEY (quete_id) REFERENCES Quete(id)
);
