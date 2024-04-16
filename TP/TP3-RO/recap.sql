create type TCinema as object (
    id_cinema number,
    nom varchar2(50),
    capacite number
);

create type TListGenre as varray(3) of varchar2(25);
create type TFilm as object (
    id_film number,
    titre varchar2(64),
    anneee number,
    genre TListGenre
);

create type TSeance as object (
    id_seance number,
    dateS date,
    heureD varchar2(5),
    heureF varchar2(5),
    prix number
);
create type EnsSeances as table of TSeance;

create type TProjection as object (
    num number,
    id_cinema ref TCinema,
    id_film ref TFilm,
    seances EnsSeances
);

create table Cinemas of TCinemas;
create table Films of TFilm;
create table Projections of TProjection
nested table seances store as seance_tab;
--2
insert into cinemas values (1,"cosmos",100);
insert into cinemas values(2,"Riadh elfeth",200);
insert into films values(1,"Spider man",2019,TListGenre("action","fantasy","superhero"));
insert into films values(2,"dune",2021,TListGenre("sci-fi","action","adventure"));
--3
insert into projections values(
    1,
    (select ref(c) from cinemas c where c.id_cinema=1),
    (select ref(f) from films f where f.id_film=1),
    null);
--4
update projrctions set seances = EnsSeances(
    TSeance(1,sysdate,"20:00","21:30",1000)
)
where num=1;
--5

update table(
    select p.seances
    from projections p
    where p.num=1) s set prix = 1200
where s.id_seance = 1;
--6
select f.titre from films f, table(f.genre) g
where UPPER(g.column_value) = 'ACTION';

--7
select p.id_film.titre , max(s.prix) from projections p, table(p.seances) s
group by p.id_film.titre 
having max(s.prix) = (
    select max(s.prix) from projections p, table(p.seances) s
);

----------------<<TD RO>>----------------

