BEGIN
    FOR CUR_REC IN (
        SELECT
            TABLE_NAME
        FROM
            USER_TABLES
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE '
                          || CUR_REC.TABLE_NAME
                          || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- Création de la table Film
CREATE OR REPLACE TABLE FILM (
    ID_FILM NUMBER PRIMARY KEY,
    TITRE VARCHAR2(255),
    DURÉE NUMBER,
    GENRE VARCHAR2(100),
    ANNÉE NUMBER,
    BUDGET_RÉALISATION NUMBER,
    PRIX_MOYEN NUMBER,
    BOX_OFFICE NUMBER DEFAULT 0,
    DATE_RENTABILITÉ DATE
);

-- Création de la table Cinema
CREATE OR REPLACE TABLE CINEMA (
    ID_CINEMA NUMBER PRIMARY KEY,
    NOM VARCHAR2(255),
    CAPACITÉ NUMBER,
    ÉQUIPEMENT VARCHAR2(255),
    RECETTE NUMBER
);

-- Création de la table Seance
CREATE OR REPLACE TABLE SEANCE (
    ID_SEANCE NUMBER PRIMARY KEY,
    ID_FILM NUMBER,
    ID_CINEMA NUMBER,
    DATES DATE,
    HEURE_DÉBUT TIMESTAMP,
    HEURE_FIN TIMESTAMP,
    PRIX NUMBER,
    FOREIGN KEY (ID_FILM) REFERENCES FILM(ID_FILM),
    FOREIGN KEY (ID_CINEMA) REFERENCES CINEMA(ID_CINEMA)
);

-- Création de la table Billeterie
CREATE OR REPLACE TABLE BILLETERIE (
    ID_BILLET NUMBER PRIMARY KEY,
    ID_SEANCE NUMBER,
    NUMÉRO_PLACE NUMBER,
    FOREIGN KEY (ID_SEANCE) REFERENCES SEANCE(ID_SEANCE)
);

-- Création de la table Journalisation
CREATE OR REPLACE TABLE JOURNALISATION (
    ID_OPERATION NUMBER PRIMARY KEY,
    ID_SEANCE NUMBER,
    OPÉRATION VARCHAR2(100),
    USERO VARCHAR2(100),
    DATE_OPERATION DATE,
    FOREIGN KEY (ID_SEANCE) REFERENCES SEANCE(ID_SEANCE)
);

-- Création de la table Statistiques
CREATE OR REPLACE TABLE STATISTIQUES (
    MOIS NUMBER,
    ANNÉE NUMBER,
    ID_CINEMA NUMBER,
    TAUX_OCCUPATION NUMBER,
    FOREIGN KEY (ID_CINEMA) REFERENCES CINEMA(ID_CINEMA)
);

-- Jeu de données pour la table Cinema
INSERT INTO CINEMA VALUES (
    1,
    'Cinéma Cosmos',
    240,
    'Son Surround, Écran panoramique',
    NULL
);

INSERT INTO CINEMA VALUES (
    2,
    'Cinéma Riadh El Feth',
    260,
    'Son Dolby, Écran 3D',
    NULL
);

INSERT INTO CINEMA VALUES (
    3,
    'Cinéma Ibn Zeydoun',
    220,
    'Son Dolby, Écran 3D',
    NULL
);

INSERT INTO CINEMA VALUES (
    4,
    'Cinéma El Mouggar',
    190,
    'Son Surround, Écran panoramique',
    NULL
);

INSERT INTO CINEMA VALUES (
    5,
    'Cinéma Ibn Badis',
    180,
    'Son Dolby, Écran 3D',
    NULL
);

-- Jeu de données pour la table Film
INSERT INTO FILM VALUES (
    1,
    'Spider-Man: No Way Home',
    148,
    'Action, Aventure, Fantaisie',
    2021,
    200000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    2,
    'Dune',
    155,
    'Action, Aventure, Drame',
    2021,
    165000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    3,
    'Black Widow',
    134,
    'Action, Aventure, Sci-Fi',
    2021,
    200000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    4,
    'Avatar: The Way of Water',
    175,
    'Action, Aventure, Fantaisie',
    2022,
    250000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    5,
    'Matrix 4',
    148,
    'Action, Sci-Fi',
    2021,
    190000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    6,
    'Jurassic World: Dominion',
    151,
    'Action, Aventure, Sci-Fi',
    2022,
    180000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    7,
    'Mission: Impossible 7',
    147,
    'Action, Aventure, Thriller',
    2022,
    180000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    8,
    'The Batman',
    176,
    'Action, Crime, Drame',
    2022,
    200000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    9,
    'Top Gun: Maverick',
    140,
    'Action, Drama',
    2022,
    152000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    10,
    'Untitled Spider-Man: Into the Spider-Verse Sequel',
    117,
    'Animation, Action, Adventure',
    2022,
    200000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    11,
    'Avatar 3',
    165,
    'Action, Adventure, Fantasy',
    2023,
    250000000,
    NULL,
    0,
    NULL
);

INSERT INTO FILM VALUES(
    12,
    'Indiana Jones 5',
    128,
    'Action, Adventure',
    2023,
    150000000,
    NULL,
    0,
    NULL
);

-- Jeu de données pour la table Seance
INSERT INTO SEANCE VALUES (
    1,
    1,
    1,
    TO_DATE('2024-02-15', 'YYYY-MM-DD'),
    TIMESTAMP '2024-02-15 18:00:00',
    TIMESTAMP '2024-02-15 20:28:00',
    1200
);

INSERT INTO SEANCE VALUES(
    2,
    1,
    2,
    TO_DATE('2024-02-15', 'YYYY-MM-DD'),
    TIMESTAMP '2024-02-15 17:30:00',
    TIMESTAMP '2024-02-15 20:22:00',
    1000
);

INSERT INTO SEANCE VALUES(
    3,
    1,
    2,
    TO_DATE('2024-02-17', 'YYYY-MM-DD'),
    TIMESTAMP '2024-02-17 13:00:00',
    TIMESTAMP '2024-02-17 14:59:00',
    800
);

INSERT INTO SEANCE VALUES(
    4,
    2,
    3,
    TO_DATE('2024-03-05', 'YYYY-MM-DD'),
    TIMESTAMP '2024-03-05 18:30:00',
    TIMESTAMP '2024-03-05 21:25:00',
    1000
);

INSERT INTO SEANCE VALUES(
    5,
    3,
    1,
    TO_DATE('2024-02-16', 'YYYY-MM-DD'),
    TIMESTAMP '2024-02-16 19:15:00',
    TIMESTAMP '2024-02-16 21:43:00',
    1200
);

INSERT INTO SEANCE VALUES(
    6,
    4,
    4,
    TO_DATE('2024-04-08', 'YYYY-MM-DD'),
    TIMESTAMP '2024-04-08 20:30:00',
    TIMESTAMP '2024-04-08 22:01:00',
    1000
);

INSERT INTO SEANCE VALUES(
    7,
    4,
    4,
    TO_DATE('2024-04-08', 'YYYY-MM-DD'),
    TIMESTAMP '2024-04-08 17:45:00',
    TIMESTAMP '2024-04-08 20:32:00',
    900
);

-- Jeu de données pour la table Billeterie
INSERT INTO BILLETERIE VALUES (
    1,
    1,
    10
);

INSERT INTO BILLETERIE VALUES(
    2,
    1,
    11
);

INSERT INTO BILLETERIE VALUES(
    3,
    2,
    5
);

INSERT INTO BILLETERIE VALUES(
    4,
    2,
    6
);

INSERT INTO BILLETERIE VALUES(
    5,
    3,
    7
);

INSERT INTO BILLETERIE VALUES(
    6,
    3,
    8
);

INSERT INTO BILLETERIE VALUES(
    7,
    4,
    10
);

--Q.a-1:Gérer la clé primaire de ID_CINEMA automatiquement (Oracle utilise des séquences pour générer des clés primaires automatiquement)
CREATE SEQUENCE SEQ_CINEMA
MINVALUE 6
MAXVALUE 1000000
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRG_CINEMA BEFORE
    INSERT ON CINEMA FOR EACH ROW
BEGIN
    SELECT
        SEQ_CINEMA.NEXTVAL INTO :NEW.ID_CINEMA
    FROM
        DUAL;
END;
/

--Q.a-2:À l'insertion d'un film, mettre automatiquement le genre à 'Non spécifié' s'il n'est pas fourni
CREATE OR REPLACE TRIGGER TRG_FILM BEFORE
    INSERT ON FILM FOR EACH ROW
BEGIN
    IF :NEW.GENRE IS NULL THEN
        :NEW.GENRE := 'Non spécifié';
    END IF;
END;
/

--Q.b.3:Mettre à jour le nombre de billets vendus de chaque séance par un déclencheur ligne et un autre global
ALTER TABLE SEANCE ADD NBBILLETS NUMBER DEFAULT 0;

--Déclencheur ligne
CREATE OR REPLACE TRIGGER MAJ_NBBILLETS_LIGNE AFTER
    INSERT OR DELETE OR UPDATE ON BILLETERIE FOR EACH ROW
BEGIN
    IF DELETING AND :OLD.ID_SEANCE IS NOT NULL THEN
        UPDATE SEANCE
        SET
            NBBILLETS = NBBILLETS - 1
        WHERE
            ID_SEANCE = :OLD.ID_SEANCE;
    ELSIF INSERTING AND :NEW.ID_SEANCE IS NOT NULL THEN
        UPDATE SEANCE
        SET
            NBBILLETS = NBBILLETS + 1
        WHERE
            ID_SEANCE = :NEW.ID_SEANCE;
    ELSIF UPDATING AND :NEW.ID_SEANCE IS NOT NULL THEN
        UPDATE SEANCE
        SET
            NBBILLETS = NBBILLETS + 1
        WHERE
            ID_SEANCE = :NEW.ID_SEANCE;
        UPDATE SEANCE
        SET
            NBBILLETS = NBBILLETS - 1
        WHERE
            ID_SEANCE = :OLD.ID_SEANCE;
    END IF;
END;
/

--DEACTIVATE TRIGGER MAJ_NBBILLETS_LIGNE;
ALTER TRIGGER MAJ_NBBILLETS_LIGNE DISABLE;

--Déclencheur global
CREATE OR REPLACE TRIGGER MAJ_NBBILLETS_GLOBAL AFTER
    INSERT OR DELETE OR UPDATE ON BILLETERIE
BEGIN
    UPDATE SEANCE S
    SET
        NBBILLETS = (
            SELECT
                COUNT(*)
            FROM
                BILLETERIE B
            WHERE
                B.ID_SEANCE = S.ID_SEANCE
        );
END;
/

--Q.b.4:Calculer automatiquement la valeur de champ box-office d'un film avec un déclencheur ligne
CREATE OR REPLACE TRIGGER BOX_OFFICE AFTER
    INSERT OR UPDATE ON SEANCE FOR EACH ROW
BEGIN
    IF UPDATING THEN
        UPDATE FILM
        SET
            BOX_OFFICE = BOX_OFFICE + :NEW.PRIX*:NEW.NBBILLETS - :OLD.PRIX*:OLD.NBBILLETS
        WHERE
            ID_FILM = :NEW.ID_FILM;
    ELSE
        UPDATE FILM
        SET
            BOX_OFFICE = BOX_OFFICE + :NEW.PRIX*:NEW.NBBILLETS
        WHERE
            ID_FILM = :NEW.ID_FILM;
    END IF;
END;
/

--BOX OFFICE GLOBAL
CREATE OR REPLACE TRIGGER BOX_OFFICE_GLOBAL
AFTER INSERT OR UPDATE ON SEANCE
BEGIN
    UPDATE FILM f SET BOX_OFFICE = (SELECT SUM(PRIX*NBBILLETS) FROM SEANCE s WHERE s.ID_FILM = f.ID_FILM );
END;



--c.5
CREATE OR REPLACE TRIGGER RST_3SeancesParJour
BEFORE INSERT ON SEANCE
FOR EACH ROW
DECLARE
    CountSeances NUMBER;
BEGIN
    SELECT COUNT(*) INTO CountSeances
    FROM SEANCE
    WHERE ID_CINEMA = :NEW.ID_CINEMA AND DateS = SYSDATE();
    IF CountSeances >= 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossible dajouter plus de 3 séances par jour');
    END IF;
END;

--c.6
CREATE OR REPLACE TRIGGER RST_SalCap
BEFORE INSERT ON SEANCE
FOR EACH ROW
DECLARE
    CapacitéCinema NUMBER;
    NSeance NUMBER;
BEGIN
    SELECT COUNT(*) INTO NSeance
    FROM SEANCE
    WHERE ID_CINEMA = :NEW.ID_CINEMA;
    SELECT Capacité INTO CapacitéCinema
    FROM CINEMA
    WHERE ID_CINEMA = :NEW.ID_CINEMA;

    IF CapacitéCinema = NSeance THEN
        RAISE_APPLICATION_ERROR(-20002, 'Impossible dajouter une séance, la capacité du cinéma est atteinte');
    END IF;
END;

--d.7--
CREATE OR REPLACE SEQUENCE SEQ_JOURNALISATION
MINVALUE 6
MAXVALUE 1000000
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Audit_Seance
AFTER INSERT OR DELETE OR UPDATE ON BILLETERIE
FOR EACH ROW
DECLARE OP JOURNALISATION.Opération%TYPE;SID SEANCE.ID_SEANCE%TYPE;
BEGIN
    IF INSERTING THEN
        OP := 'INSERT';
        SID := :NEW.ID_Seance
    ELSIF UPDATING THEN
        OP := 'UPDATE';
        SID := :NEW.ID_Seance
    ELSE
        OP := 'DELETE';
        SID := :OLD.ID_Seance
    END IF;
    INSERT INTO JOURNALISATION VALUES ( SEQ_JOURNALISATION.NEXTVAL, SID, OP, USER, SYSDATE);
END;

--d.8--
CREATE OR REPLACE TRIGGER Taux_Occupation
AFTER INSERT ON BILLETERIE
BEGIN
    IF EXTRACT(DAY FROM SYSDATE) = EXTRACT(DAY FROM LAST_DAY(SYSDATE)) THEN
        INSERT INTO STATISTIQUES 
        SELECT
            EXTRACT(MONTH FROM SYSDATE),
            EXTRACT(YEAR FROM SYSDATE),
            C.ID_CINEMA,
            (SUM(S.NBBILLETS)/C.CAPACITÉ)*100
        FROM
            CINEMA C,
            SEANCE S
        WHERE
            C.ID_CINEMA = S.ID_CINEMA
            AND EXTRACT(MONTH FROM S.DATES) = EXTRACT(MONTH FROM SYSDATE)
            AND EXTRACT(YEAR FROM S.DATES) = EXTRACT(YEAR FROM SYSDATE)
        GROUP BY
            C.ID_CINEMA;
    END IF;
END;

--Views --

--1&2--
CREATE OR REPLACE VIEW Action(Titre,Genre)
AS SELECT TITRE,GENRE FROM FILM WHERE UPPER(GENRE) LIKE '%ACTION%'
WITH READ ONLY;

--3--
CREATE OR REPLACE VIEW  BilletsFilm (film,billets)
AS SELECT Titre, SUM(NBBILLETS) FROM SEANCE S, FILM F WHERE S.ID_FILM = F.ID_FILM 
GROUP BY Titre
WITH READ ONLY;

--4--
--a--
SELECT Titre, NBT
FROM (
  SELECT Titre, SUM(NBBILLETS) AS NBT
  FROM SEANCE S, FILM F
  WHERE S.ID_FILM = F.ID_FILM
  GROUP BY Titre
  ORDER BY SUM(NBBILLETS) DESC
)
WHERE ROWNUM <= 1;
--b--
SELECT *
FROM BilletsFilm
WHERE ROWNUM <= 1;

--5--
CREATE OR REPLACE VIEW SeanceFilm (Seance, dates, TitreFilm, IDFilm, Cinema, IDCinema)
AS SELECT S.ID_SEANCE, DATES, F.TITRE, F.ID_FILM, C.NOM, C.ID_CINEMA FROM SEANCE S, FILM F, CINEMA C
WHERE S.ID_FILM = F.ID_FILM AND S.ID_CINEMA = C.ID_CINEMA;

SELECT COLUMN_NAME, INSERTABLE, 
UPDATABLE, DELETABLE 
FROM USER_UPDATABLE_COLUMNS 
WHERE TABLE_NAME = UPPER('SeanceFilm');

--6--

CREATE OR REPLACE VIEW StatCine (mois, année, NomC, ID_cine, Capa, Taux)
AS SELECT S.MOIS, S.ANNÉE, C.NOM, C.ID_CINEMA, C.CAPACITÉ, S.TAUX_OCCUPATION FROM STATISTIQUES S, CINEMA C
WHERE S.ID_CINEMA = C.ID_CINEMA;

CREATE OR REPLACE TRIGGER MAJ_CAP
AS 