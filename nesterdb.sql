CREATE TABLE TECHNICIEN(
   IdTechnicien INT PRIMARY KEY,
   Nom VARCHAR(50),
   Prenom VARCHAR(50),
   Role VARCHAR(50) NOT NULL
);

CREATE TABLE LICENCE(
   NumLicence CHAR(8) PRIMARY KEY,
   DateAttribution DATE,
   Duree VARCHAR(20)
);

CREATE TABLE REDEMARRAGE(
   IdRedemarrage INT AUTO_INCREMENT PRIMARY KEY,
   DateHeure DATETIME,
   Motif VARCHAR(100)
);

CREATE TABLE CLIENT_PRESTATAIRE(
   IdPrestataire INT PRIMARY KEY,
   NomPrestataire VARCHAR(100),
   SIRET CHAR(14),
   AdresseSiege VARCHAR(80),
   ContactPrincipal VARCHAR(100)
);

CREATE TABLE FRANCHISE_NFL(
   IdFranchise INT PRIMARY KEY,
   NomFranchise VARCHAR(100),
   Ville VARCHAR(100)
);

CREATE TABLE SCRIPT(
   IdScript INT PRIMARY KEY,
   NomScript VARCHAR(100),
   VersionScript VARCHAR(20)
);

CREATE TABLE CLIENT_FINAL(
   IdClientFinal INT PRIMARY KEY,
   NomClient VARCHAR(100),
   AdresseSite VARCHAR(80),
   IdPrestataire INT NOT NULL,
   FOREIGN KEY(IdPrestataire) REFERENCES CLIENT_PRESTATAIRE(IdPrestataire)
);

CREATE TABLE INCIDENT(
   IdIncident INT AUTO_INCREMENT PRIMARY KEY,
   DateHeure DATETIME,
   Description VARCHAR(250),
   IdTechnicien INT NOT NULL,
   FOREIGN KEY(IdTechnicien) REFERENCES TECHNICIEN(IdTechnicien)
);

CREATE TABLE Instance (
   NumSerie VARCHAR(50) PRIMARY KEY,
   Nom VARCHAR(100),
   IP_LAN VARCHAR(15),
   IP_VPN VARCHAR(15),
   Etat ENUM('connectée', 'déconnectée', 'indéfini'),
   DateDesactivation DATETIME,
   Version_OS VARCHAR(50),
   Version_Harvester VARCHAR(50),
   MaterielNFLIT BOOLEAN,
   ARecuperer BOOLEAN,
   IdFranchise INT,
   IdScript INT NOT NULL,
   IdIncident INT NOT NULL,
   IdClientFinal INT,
   IdRedemarrage INT NOT NULL,
   NumLicence CHAR(8) NOT NULL UNIQUE,
   FOREIGN KEY (IdFranchise) REFERENCES FRANCHISE_NFL(IdFranchise),
   FOREIGN KEY (IdScript) REFERENCES SCRIPT(IdScript),
   FOREIGN KEY (IdIncident) REFERENCES INCIDENT(IdIncident),
   FOREIGN KEY (IdClientFinal) REFERENCES CLIENT_FINAL(IdClientFinal),
   FOREIGN KEY (IdRedemarrage) REFERENCES REDEMARRAGE(IdRedemarrage),
   FOREIGN KEY (NumLicence) REFERENCES LICENCE(NumLicence)
);

CREATE TABLE MATERIEL(
   IdMateriel INT PRIMARY KEY,
   TypeMateriel VARCHAR(30),
   CPU VARCHAR(50),
   RAM VARCHAR(20),
   TypeDisque VARCHAR(30),
   TailleDisque VARCHAR(20),
   EstRecupere BOOLEAN,
  
   NumSerie VARCHAR(50) NOT NULL UNIQUE,
   FOREIGN KEY (NumSerie) REFERENCES INSTANCE(NumSerie)
);

CREATE TABLE Deploiement(
   NumSerie VARCHAR(50),
   IdTechnicien INT,
   DateDeploiement DATETIME,
   PRIMARY KEY(NumSerie, IdTechnicien),
   FOREIGN KEY(NumSerie) REFERENCES Instance(NumSerie),
   FOREIGN KEY(IdTechnicien) REFERENCES TECHNICIEN(IdTechnicien)
);

