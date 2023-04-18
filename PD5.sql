--1--
create or replace view bd3_liczba_zawodnikow as
    select plec,
    count(*) as Liczba_osob
        from bd3_zawodnicy
    group by plec
;

select * from bd3_liczba_zawodnikow
where plec='K'
;

--2--
create or replace view bd3_ewidencja as
    select nazwisko ||' '|| imie as Nazwisko,
    nazwa_klubu as Klub,
    nazwa_kategorii as Kategoria,
    rezultat_sek ||':'|| rezultat_min as Wynik,
    nazwa_zawodow as Zawody,
    data_zawodow
        from bd3_zawodnicy z
            join bd3_kluby kl on kl.nr_klubu=z.nr_klubu
            join bd3_kategorie ka on ka.nr_kategorii=z.nr_kategorii
            join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
            join bd3_zawody z2 on z2.nr_zawodow=w.nr_zawodow
;
select * from bd3_ewidencja;

select * from bd3_ewidencja
where upper(nazwisko) like upper('&cos%')
order by data_zawodow desc;


--4--
insert into bd3_zawody values (
    seq_zawody.nextval,'&nazwa',sysdate,'&podtytul'
);

