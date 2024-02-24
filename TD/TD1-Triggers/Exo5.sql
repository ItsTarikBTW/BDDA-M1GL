--1--
CREATE OR REPLACE TRIGGER MAJ_NbPersonnel
AFTER INSERT OR DELETE OR UPDATE ON EMP
BEGIN
    UPDATE SERVICE s SET NbPersonnel = (SELECT COUNT(*) FROM EMP e 
    WHERE e.SertNo = s.SertNo);
END;

--2--
CREATE OR REPLACE TRIGGER RST_MaxSal
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
DECLARE
    currentSal NUMBER;
BEGIN
    SELECT SUM(Sal) INTO currentSal FROM EMP;
    IF :NEW.Sal + currentSal > 1000000 THEN
        RAISE_APPLICATION_ERROR(-20301, 'La somme des salaires dépasse 1 000 000');
    END IF;
END;

--3--
CREATE OR REPLACE TRIGGER RST_UserMoh
AFTER UPDATE ON EMP.Sal
FOR EACH ROW WHEN (UPPER(USER) = 'MOHAMMED')
BEGIN
    IF :OLD.Sal*1.2 < :NEW.Sal AND :OLD.Sal*0.8 > :NEW.Sal THEN
        RAISE_APPLICATION_ERROR(-20302, 'La modification du salaire est trop importante');
    END IF;
END;

--4--
CREATE OR REPLACE TRIGGER RST_BudgetCheck
BEFORE INSERT ON SERVICE_PROJET
FOR EACH ROW WHEN 
DECLARE
    CoutTotal NUMBER;
    Budget NUMBER;
    NewCout NUMBER;
BEGIN
    SELECT SUM(P.coutP*SP.pourcentage) INTO CoutTotal FROM PROJET P , SERVICE_PROJET SP 
    WHERE P.Numprojet = SP.numprojet AND SP.SertNo = :NEW.SertNo;
    SELECT Budget INTO Budget FROM SERVICE WHERE SertNo = :NEW.SertNo;
    SELECT coutP INTO NewCout FROM PROJET WHERE Numprojet = :NEW.Numprojet;
    IF CoutTotal + pourcentage*NewCout > Budget THEN
        RAISE_APPLICATION_ERROR(-20303, 'Le cout total dépasse 100 000');
    END IF;
END;