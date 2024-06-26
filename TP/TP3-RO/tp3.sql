CREATE TYPE TSEANCE AS
    OBJECT(
        ID_SEANCE NUMBER,
        DATES DATE,
        HEURED VARCHAR2(5),
        HEUREF VARCHAR2(5),
        PRIX NUMBER
    );
/

CREATE TYPE EnsSeance AS
    TABLE OF TSEANCE;
/

CREATE TYPE TCINEMA AS
    OBJECT (
        ID_CINEMA NUMBER,
        NOM_CINEMA VARCHAR2(50),
        CAPACITY NUMBER
    );
/

CREATE TYPE TLISTGENRE AS
    VARRAY(3) OF VARCHAR2(20);
/

CREATE TYPE TFILM AS
    OBJECT (
        ID_FILM NUMBER,
        TITRE VARCHAR2(50),
        ANNEE NUMBER,
        GENRE TLISTGENRE
    );
/

CREATE TYPE TPROJECTION AS
    OBJECT (
        NUM NUMBER,
        ID_CINEMA REF TCINEMA,
        ID_FILM REF TFILM,
        SEANCES EnsSeance
    );
/

CREATE TABLE CINEMAS OF TCINEMA;

/

CREATE TABLE FILMS OF TFILM;

/

CREATE TABLE PROJECTIONS OF TPROJECTION
NESTED TABLE SEANCES STORE AS SEANCES_TAB;

/
--2--
INSERT INTO CINEMAS VALUES (TCINEMA(1, 'Cosmos', 240));
INSERT INTO CINEMAS VALUES (TCINEMA(2, 'Riadh elfeth', 260));

INSERT INTO FILMS VALUES (TFILM(1,'Spider-Man: No Way Home',2021,TLISTGENRE('Action', 'Aventure', 'Fantaisie')));
INSERT INTO FILMS VALUES (TFILM(2,'Dune',2021,TLISTGENRE('Action', 'Aventure', 'Drame')));
--3--

INSERT INTO PROJECTIONS VALUES (
    1,
    (SELECT REF(C) FROM Cinemas C WHERE C.ID_CINEMA = 1),
    (SELECT REF(F) FROM Films F WHERE F.ID_FILM = 1 ),
    NULL
);

--4--
UPDATE PROJECTIONS SET 
    SEANCES = EnsSeance(
        TSeance(
            1,
            SYSDATE,
            '20:00',
            '21:30',
            1000
        )
    ) WHERE Num = 1;

--5--
UPDATE TABLE(SELECT SEANCES FROM PROJECTIONS P WHERE P.NUM = 1) S
SET PRIX=1200 WHERE S.ID_SEANCE = 1;

--6--
SELECT f.TITRE FROM FILMS f , TABLE(GENRE) g
WHERE UPPER(g.COLUMN_value) LIKE '%ACTION%'
GROUP BY f.TITRE;

--7--

SELECT P.ID_FILM.TITRE, MAX(S.Prix)
FROM 
    PROJECTIONS P,
    TABLE(P.SEANCES) S
GROUP BY P.ID_FILM.TITRE
HAVING MAX(S.Prix) = (
    SELECT MAX(S.Prix)
    FROM 
        PROJECTIONS P,
        TABLE(P.SEANCES) S
);

SELECT
    p.id_film.titre,
    s.prix
FROM
    projections       p,
    TABLE ( seances ) s
WHERE
    s.prix = (
        SELECT
            MAX(s1.prix)
        FROM
            TABLE ( p.seances ) s1
    );


INSERT INTO PROJECTIONS VALUES (
    3,
    (SELECT REF(C) FROM Cinemas C WHERE C.ID_CINEMA = 1),
    (SELECT REF(F) FROM Films F WHERE F.ID_FILM = 1 ),
    EnsSeance(
        TSeance(
            1,
            SYSDATE,
            '20:00',
            '21:30',
            1200
        ),
        TSeance(
            2,
            SYSDATE,
            '22:00',
            '23:30',
            1000
        )
    )
);