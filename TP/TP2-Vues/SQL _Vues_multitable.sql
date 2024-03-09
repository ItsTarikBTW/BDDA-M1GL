CREATE TABLE "PERSONNE" 
   (	"NUMP" NUMBER NOT NULL ENABLE, 
	"NOMP" VARCHAR2(20), 
	 CONSTRAINT "PERSONNE_PK" PRIMARY KEY ("NUMP"));
//-----------------------------------
 CREATE TABLE "VOITURE" 
   (	"NUMV" NUMBER NOT NULL ENABLE, 
	"MARQUE" VARCHAR2(20), 
	"NUMPP" NUMBER, /*champ de la clé foreign key*/
	 CONSTRAINT "VOITURE_PK" PRIMARY KEY ("NUMV"));
//-----------------------------------
create or replace view  complexeview as
select p.nump, p.nomp,v.marque from personne p, voiture v
where v.numpp = p.nump;

//-----------------------------------
insert into complexeview (nump,nomp) values (8,'malik');
//-----------------------------------
create view ComplexPreservedKey as
select v.numv, p.nomp from personne p, voiture v
where v.numpp = p.nump;

//-----------------------------------

SELECT COLUMN_NAME, INSERTABLE,
UPDATABLE, DELETABLE
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = UPPER('complexeview');
//-----------------------------------

SELECT COLUMN_NAME, INSERTABLE,
UPDATABLE, DELETABLE
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = UPPER('complexeview');

//-----------------------------------
create or replace trigger MAJView
INSTEAD of INSERT on complexeview 
for each row
begin
 insert into personne values (:new.nump, :new.nomp);
 insert into voiture values (:new.nump, :new.marque, null);
end;