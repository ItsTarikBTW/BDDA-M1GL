BEGIN
    FOR cur_rec IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || cur_rec.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- Création de la table Film
CREATE TABLE Film (
    ID_Film NUMBER PRIMARY KEY,
    Titre VARCHAR2(255),
    Durée NUMBER,
    Genre VARCHAR2(100),
    Année NUMBER,
    Budget_Réalisation NUMBER,
    Prix_Moyen NUMBER,
    Box_Office NUMBER,
    Date_Rentabilité DATE
);

-- Création de la table Cinema
CREATE TABLE Cinema (
    ID_CINEMA NUMBER PRIMARY KEY,
    Nom VARCHAR2(255),
    Capacité NUMBER,
    Équipement VARCHAR2(255),
    Recette NUMBER
);

-- Création de la table Seance
CREATE TABLE Seance (
    ID_Seance NUMBER PRIMARY KEY,
    ID_Film NUMBER,
    ID_CINEMA NUMBER,
    DateS DATE,
    Heure_Début TIMESTAMP,
    Heure_Fin TIMESTAMP,
    Prix NUMBER,
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film),
    FOREIGN KEY (ID_CINEMA) REFERENCES Cinema(ID_CINEMA)
);

-- Création de la table Billeterie
CREATE TABLE Billeterie (
    ID_Billet NUMBER PRIMARY KEY,
    ID_Seance NUMBER,
    Numéro_Place NUMBER,
    FOREIGN KEY (ID_Seance) REFERENCES Seance(ID_Seance)
);

-- Création de la table Journalisation
CREATE TABLE Journalisation (
    ID_Operation NUMBER PRIMARY KEY,
    ID_Seance NUMBER,
    Opération VARCHAR2(100),
    UserO VARCHAR2(100),
    Date_Operation DATE,
    FOREIGN KEY (ID_Seance) REFERENCES Seance(ID_Seance)
);

-- Création de la table Statistiques
CREATE TABLE Statistiques (
    mois NUMBER,
    année NUMBER,
    ID_CINEMA NUMBER,
    Taux_Occupation NUMBER,
    FOREIGN KEY (ID_CINEMA) REFERENCES Cinema(ID_CINEMA)
);

-- Jeu de données pour la table Cinema
INSERT INTO Cinema VALUES (1, 'Cinéma Cosmos', 240, 'Son Surround, Écran panoramique', NULL);
 INSERT INTO Cinema VALUES (2, 'Cinéma Riadh El Feth', 260, 'Son Dolby, Écran 3D', NULL);
 INSERT INTO Cinema VALUES (3, 'Cinéma Ibn Zeydoun', 220, 'Son Dolby, Écran 3D', NULL);
 INSERT INTO Cinema VALUES (4, 'Cinéma El Mouggar', 190, 'Son Surround, Écran panoramique', NULL);
 INSERT INTO Cinema VALUES (5, 'Cinéma Ibn Badis', 180, 'Son Dolby, Écran 3D', NULL);

-- Jeu de données pour la table Film
INSERT INTO Film VALUES (1, 'Spider-Man: No Way Home', 148, 'Action, Aventure, Fantaisie', 2021, 200000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(2, 'Dune', 155, 'Action, Aventure, Drame', 2021, 165000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(3, 'Black Widow', 134, 'Action, Aventure, Sci-Fi', 2021, 200000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(4, 'Avatar: The Way of Water', 175, 'Action, Aventure, Fantaisie', 2022, 250000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(5, 'Matrix 4', 148, 'Action, Sci-Fi', 2021, 190000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(6, 'Jurassic World: Dominion', 151, 'Action, Aventure, Sci-Fi', 2022, 180000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(7, 'Mission: Impossible 7', 147, 'Action, Aventure, Thriller', 2022, 180000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(8, 'The Batman', 176, 'Action, Crime, Drame', 2022, 200000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(9, 'Top Gun: Maverick', 140, 'Action, Drama', 2022, 152000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(10, 'Untitled Spider-Man: Into the Spider-Verse Sequel', 117, 'Animation, Action, Adventure', 2022, 200000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(11, 'Avatar 3', 165, 'Action, Adventure, Fantasy', 2023, 250000000, NULL, NULL, NULL);
INSERT INTO Film VALUES(12, 'Indiana Jones 5', 128, 'Action, Adventure', 2023, 150000000, NULL, NULL, NULL);




-- Jeu de données pour la table Seance
INSERT INTO Seance VALUES (1, 1, 1, TO_DATE('2024-02-15', 'YYYY-MM-DD'), TIMESTAMP '2024-02-15 18:00:00', TIMESTAMP '2024-02-15 20:28:00', 1200);
INSERT INTO Seance VALUES(2, 1, 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'), TIMESTAMP '2024-02-15 17:30:00', TIMESTAMP '2024-02-15 20:22:00', 1000);
INSERT INTO Seance VALUES(3, 1, 2, TO_DATE('2024-02-17', 'YYYY-MM-DD'), TIMESTAMP '2024-02-17 13:00:00', TIMESTAMP '2024-02-17 14:59:00', 800);
INSERT INTO Seance VALUES(4, 2, 3, TO_DATE('2024-03-05', 'YYYY-MM-DD'), TIMESTAMP '2024-03-05 18:30:00', TIMESTAMP '2024-03-05 21:25:00', 1000);
INSERT INTO Seance VALUES(5, 3, 1, TO_DATE('2024-02-16', 'YYYY-MM-DD'), TIMESTAMP '2024-02-16 19:15:00', TIMESTAMP '2024-02-16 21:43:00', 1200);
INSERT INTO Seance VALUES(6, 4, 4, TO_DATE('2024-04-08', 'YYYY-MM-DD'), TIMESTAMP '2024-04-08 20:30:00', TIMESTAMP '2024-04-08 22:01:00', 1000);
INSERT INTO Seance VALUES(7, 4, 4, TO_DATE('2024-04-08', 'YYYY-MM-DD'), TIMESTAMP '2024-04-08 17:45:00', TIMESTAMP '2024-04-08 20:32:00', 900);

-- Jeu de données pour la table Billeterie
INSERT INTO Billeterie VALUES (1, 1, 10);
INSERT INTO Billeterie VALUES(2, 1, 11);
INSERT INTO Billeterie VALUES(3, 2, 5);
INSERT INTO Billeterie VALUES(4, 2, 6);
INSERT INTO Billeterie VALUES(5, 3, 7);
INSERT INTO Billeterie VALUES(6, 3, 8);
INSERT INTO Billeterie VALUES(7, 4, 10);

--Q.a-1:Gérer la clé primaire de ID_CINEMA automatiquement (Oracle utilise des séquences pour générer des clés primaires automatiquement)
CREATE SEQUENCE SEQ_CINEMA
MINVALUE 6
MAXVALUE 1000000
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRG_CINEMA
BEFORE INSERT ON Cinema
FOR EACH ROW
BEGIN
    SELECT SEQ_CINEMA.NEXTVAL INTO :NEW.ID_CINEMA FROM dual;
END;
/

--Q.a-2:À l'insertion d'un film, mettre automatiquement le genre à 'Non spécifié' s'il n'est pas fourni
CREATE or REPLACE TRIGGER TRG_FILM
BEFORE INSERT ON Film
FOR EACH ROW
BEGIN
    IF :NEW.Genre IS NULL THEN
        :NEW.Genre := 'Non spécifié';
    END IF;
END;
/
--Q.b.1:Mettre à jour le nombre de billets vendus de chaque séance par un déclencheur ligne et un autre global
ALTER TABLE SEANCE ADD Nbbillets NUMBER DEFAULT 0;
--Déclencheur ligne
CREATE OR REPLACE TRIGGER MAJ_NBBILLETS_LIGNE
AFTER INSERT OR DELETE OR UPDATE ON BILLETERIE
FOR EACH ROW
BEGIN
    IF DELETING AND :OLD.ID_Seance IS NOT NULL THEN
        UPDATE SEANCE SET Nbbillets = Nbbillets - 1 WHERE ID_Seance = :OLD.ID_Seance;
    ELSIF INSERTING AND :NEW.ID_Seance IS NOT NULL THEN
        UPDATE SEANCE SET Nbbillets = Nbbillets + 1 WHERE ID_Seance = :NEW.ID_Seance;
    ELSIF UPDATING AND :NEW.ID_Seance IS NOT NULL THEN
        UPDATE SEANCE SET Nbbillets = Nbbillets + 1 WHERE ID_Seance = :NEW.ID_Seance;
        UPDATE SEANCE SET Nbbillets = Nbbillets - 1 WHERE ID_Seance = :OLD.ID_Seance;
    END IF;
END;
/
--DEACTIVATE TRIGGER MAJ_NBBILLETS_LIGNE;
ALTER TRIGGER MAJ_NBBILLETS_LIGNE DISABLE;

--Déclencheur global
CREATE OR REPLACE TRIGGER MAJ_NBBILLETS_GLOBAL
AFTER INSERT OR DELETE OR UPDATE ON BILLETERIE
BEGIN
    UPDATE SEANCE s SET Nbbillets = ( SELECT COUNT(*) FROM BILLETERIE b
    WHERE b.ID_Seance = s.ID_Seance);
END;
/
--Q.b.2:Calculer automatiquement la valeur de champ box-office d'un film avec un déclencheur ligne
-- TODO:fix this trigger
CREATE OR REPLACE TRIGGER Box_Office
BEFORE UPDATE ON SEANCE
FOR EACH ROW 
DECLARE newBoxOffice NUMBER;
BEGIN
    SELECT SUM(Prix*Nbbillets) INTO newBoxOffice FROM SEANCE 
    WHERE ID_Film = :NEW.ID_Film AND ID_Seance != :OLD.ID_Seance;

    UPDATE FILM SET BOX_OFFICE = :NEW.Prix*:NEW.Nbbillets + newBoxOffice
    WHERE ID_Film = :NEW.ID_Film;
END;
/