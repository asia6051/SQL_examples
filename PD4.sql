--1--
select substr(imie,1,1) ||'.'||upper(nazwisko) as Zawodnik,
round((sysdate-data_urodzenia)/365) as Wiek
    from bd3_zawodnicy
where nr_zawodnika between 30 and 60
or nr_zawodnika between 300 and 350
order by 2 desc
;

--2--
select count (*) 
    from  bd3_zawodnicy z
        join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
where nr_klubu between 10 and 20 
and plec='K'
and nr_zawodow=4
group by nr_zawodow
;

--3--
select nazwa_kategorii as Nazwa_Kategorii,
count (*) as Liczba_uczestnikow
    from bd3_zawodnicy z
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki w on z.nr_zawodnika=w.nr_zawodnika
where nr_zawodow=3
group by nazwa_kategorii
order by 2 desc
;

--4--
select nazwa_klubu as Klub,
sum (nvl(punkty_globalne,0)) as Suma_Punktow
    from bd3_zawodnicy z
        join bd3_wyniki w on z.nr_zawodnika=w.nr_zawodnika
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
where nr_zawodow=1 and plec='M'
group by nazwa_klubu, kl.nr_klubu
having sum(nvl(punkty_globalne,0)) > 0
order by 2 desc, kl.nr_klubu desc
;

--5--
select nazwa_klubu as Klub,
sum(nvl(punkty_globalne,0)) as Suma_punktow
    from bd3_zawodnicy z
        join bd3_wyniki w on z.nr_zawodnika=w.nr_zawodnika
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
where nr_zawodow=3 and plec='K'
group by nazwa_klubu, kl.nr_klubu
having sum(nvl(punkty_globalne,0))>50
order by 2 desc
;

--6--
select plec,
to_char(data_zawodow,'DD MONTH YYYY') as Data_zawodow,
nazwa_zawodow,
round(avg((sysdate-data_urodzenia)/365),1) as Sredni_wiek,
count (*) as Liczba_zawodnikow
    from bd3_wyniki w
        join bd3_zawody z2 on z2.nr_zawodow=w.nr_zawodow
        join bd3_zawodnicy z on z.nr_zawodnika=w.nr_zawodnika
group by nazwa_zawodow,plec,data_zawodow
order by data_zawodow, 1, 5 desc
;

--7--
create table bd3_stat_klubow (
    nazwa_klubu varchar2(40 BYTE) primary key,
    liczba_zawodnikow number(5,0) NOT NULL,
    srednia_wieku number(3,1) NOT NULL
);

drop table bd3_stat_klubow CASCADE constraints;

insert into bd3_stat_klubow
select nazwa_klubu as Klub,
count (*) as Licza_zawodnikow,
round(avg((sysdate-data_urodzenia)/365),1) as Srednia_wieku
    from bd3_zawodnicy z
        join bd3_kluby k on k.nr_klubu=z.nr_klubu
group by k.nr_klubu, nazwa_klubu
;

--8--
create table bd3_rejestr_zawodow
as (select to_char(data_zawodow,'YYYY-MM-DD') as Data_zawodow,
    count(*) as Liczba_zawodnikow
        from bd3_wyniki w
            join bd3_zawody z on z.nr_zawodow=w.nr_zawodow
    group by data_zawodow, w.nr_zawodow
    )
;

--9--
select count ( * ) as "Liczba zawodników"
from bd3_zawodnicy;

select nr_klubu as "Nr klubu", count ( * ) as "Liczba zawodników"
from bd3_zawodnicy
group by nr_klubu;

select count ( * ) as "Liczba zawodników"
from bd3_zawodnicy
group by nr_klubu;

select avg (count ( * )) as "Œrednia liczba zawodników"
from bd3_zawodnicy
group by nr_klubu;

select max (count ( * )) as "Maks liczba zawodników"
from bd3_zawodnicy
group by nr_klubu;