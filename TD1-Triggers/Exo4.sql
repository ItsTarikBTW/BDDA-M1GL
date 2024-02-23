--1--
CREATE OR REPLACE TRIGGER MAJ_SoldeCpt
AFTER INSERT OR UPDATE ON OPERATION
FOR EACH ROW
BEGIN
    if :NEW.TypeOP = 'D' THEN
        UPDATE COMPTE 
        SET SoldeCpt = SoldeCpt + :NEW.MtOp 
        WHERE NumCpt = :new.NumCpt
    ELSE
        UPDATE COMPTE 
        SET SoldeCpt = SoldeCpt - :NEW.MtOp 
        WHERE NumCpt = :new.NumCpt
    END IF;
END;

--2--
CREATE OR REPLACE TRIGGER RST_SoldeCpt
AFTER INSERT ON OPERATION
FOR EACH ROW WHEN (NEW.TypeOP = 'R')
DECLARE
    SoldeCpt NUMBER;
BEGIN
    SELECT SoldeCpt INTO SoldeCpt FROM COMPTE 
    WHERE NumCpt = :new.NumCpt;
    IF SoldeCpt < :NEW.MtOp THEN
        RAISE_APPLICATION_ERROR(-20301, 'Solde insuffisant');
    END IF;
END;

--3--
CREATE OR REPLACE TRIGGER RST_MultiCompteCC
BEFORE INSERT OR UPDATE ON COMPTE
FOR EACH ROW WHEN (NEW.TypeCpt = 'CC')
DECLARE
    NbCompte NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO NbCompte FROM COMPTE 
    WHERE NumCpt = :new.NumCpt;
    IF NbCompte = 1 THEN
        RAISE_APPLICATION_ERROR(-20302, 'Un client ne peut avoir qu un seul compte courant');
    END IF;
END;

--4--
CREATE OR REPLACE TRIGGER MAJ_NbCptE
AFTER INSERT ON COMPTE
FOR EACH ROW WHEN (NEW.TypeCpt = 'CE')
DECLARE 
    NbCpt NUMBER;
BEGIN
        UPDATE CLIENT
        SET NbCptE = NbCptE + 1
        WHERE NumCli = :new.NumCli;
END;

--5--
CREATE OR REPLACE TRIGGER RST_2OpeJour
BEFORE INSERT ON OPERATION
FOR EACH ROW
DECLARE
    NbOpe NUMBER := 0;
    DateOp DATE;
BEGIN
    SELECT COUNT(*) INTO NbOpe FROM OPERATION 
    WHERE NumCpt = :NEW.NumCpt AND SYSDATE = :NEW.DateOp;
    IF NbOpe = 2 THEN
        RAISE_APPLICATION_ERROR(-20303, 'Deux opérations par jour maximum');
    END IF;
END;