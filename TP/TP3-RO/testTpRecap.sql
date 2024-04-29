create type TCinema as object (
    id_cinema number,
    nom varchar2(64),
    capacite number
);
create type TListGender as varray(3) of varchar2(32);
create type TFilm as object (
    id_film number,
    titre varchar2(64),
    annee number,
    gander TListGender
);

create type TSeances as object(
    id_seance number,
    dateS date,
    hd number,
    hf number,
    prix number
);
create type EnsSeances as table of TSeances;
create type TProjection as object (
    num number,
    id_cinema ref TCinema,
    id_film ref TFilm,
    seances EnsSeances
);

create table cinemas of TCinema;
create table films of TFilm;
craete table projections of TProjection
nested table seances store as s;


----<insertion>----
insert into cinemas values (TCinema(
    3,imax,300
));
insert into cinemas values (TCinema(
    4,pathe,200
));
insert into films values (TFilm(
        3,'whiplash',2014,TListGender('drame','musical')
));
insert into films values (TFilm(
        4,'12 angry men',1957,TListGender('drame','crime')
));
insert into projections values(TProjection(
        4,
        (select ref(c) from cinemas c where c.id_cinema=3),
        (select ref(f) from films f where f.id_film=3),
        EnsSeances(TSeances(1,to_date('2020-12-12','yyyy-mm-dd'),14,16,1200))
));
select p.id_film.titre,max(s.prix) from projections p,table(p.seances) s
GROUP BY p.id_film.titre
having max(s.prix) = (
    select max(s.prix) from projections p,table(p.seances) s
)
