--1--
select nazwisko|| ' ' || imie as Zawodnik, 
--plec as Plec, 
nazwa_klubu as Klub, 
nazwa_kategorii as Kategoria,
wy.nr_zawodow as NrZawodow,
rezultat_min as Wynik,
rezultat_sek as Czas
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where plec='M'
and (nr_zawodow=1) and (rezultat_min between 44 and 48)

union

select nazwisko|| ' ' || imie as Zawodnik, 
--plec as Plec, 
nazwa_klubu as Klub, 
nazwa_kategorii as Kategoria,
wy.nr_zawodow as NrZawodow,
rezultat_min as Wynik,
rezultat_sek as Czas
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where plec='M'
and (nr_zawodow=3) and (rezultat_min between 44 and 48)

order by 4, 6
;

--2--
select nazwisko || ' ' || imie as Zawodniczka,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria
--z.nr_klubu, 
--data_urodzenia,
--punkty_globalne
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where plec='K'
and z.nr_klubu between 5 and 40
and extract(year from data_urodzenia) > 1975 and extract(year from data_urodzenia) <1984
and punkty_globalne is null
;

--3--
select nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria
--wy.nr_zawodow as NrZawodow,
--lokata_w_biegu as Lokata
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where wy.nr_zawodow=3 and plec='M'
order by lokata_w_biegu
;

--4--
select nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria,
nazwisko,
--z.nr_zawodnika,
extract(year from data_urodzenia) as Rok
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where plec='M' and z.nr_kategorii=4

union

select nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria,
nazwisko,
--z.nr_zawodnika,
extract(year from data_urodzenia) as Rok
    from bd3_zawodnicy z
    join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
    join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
    join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where plec='K' and extract(year from data_urodzenia) between 1970 and 1985
and nazwisko like 'K%ska'

order by 5, 4
;

--5--
select distinct nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria,
nazwisko as Nazwisko,
extract(year from data_urodzenia) as Rok
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
        join bd3_wyniki wy on z.nr_zawodnika=wy.nr_zawodnika
where (plec='M' and z.nr_kategorii=4)
or (plec='K' and extract(year from data_urodzenia) between 1970 and 1985
    and nazwisko like 'K%ska')
order by extract(year from data_urodzenia), nazwisko
;

--6--
create table bd3_dane_klubow (
    nr_klubu NUMBER(3,0) primary key,
    adres VARCHAR2(100) NOT NULL,
    rok_zalozenia number(4,0) NOT NULL,
    nazwisko_prezesa VARCHAR2(30) NOT NULL
);
 
alter table bd3_dane_klubow
    add constraint fk_bd3_kluby_bd3_dane_klubow foreign key (nr_klubu)
        references bd3_kluby (nr_klubu)
;

--drop table bd3_dane_klubow CASCADE constraints;

insert into bd3_dane_klubow values
(1,'Sosnowa 5, 01-250 Warszawa',1960,'Marciniak');

insert into bd3_dane_klubow values
(2,'Kwiatowa 23, 26-600 Radom',1963,'Nawalka');

insert into bd3_dane_klubow values
(3,'Malinowa 5, 01-360 Warszawa',1976,'Duda');

insert into bd3_dane_klubow values
(5,'Zeromskiego 67, 23-789 Krakow',1980,'Maj');

select nazwa_klubu as Klub,
adres as Adres,
nazwisko_prezesa as Prezes
    from bd3_kluby kl
        join bd3_dane_klubow da on kl.nr_klubu=da.nr_klubu
order by kl.nr_klubu
;

--7--
create table bd3_zdarzenia (
    id_zdarzenia number(5,0) primary key,
    nr_zawodnika number (4,0) NOT NULL,
    rok number(4,0) NOT NULL,
    zdarzenie varchar2(100) NOT NULL
);

alter table bd3_zdarzenia
    add constraint fk_bd3_zawodnicy_bd3_zdarzenia foreign key (nr_zawodnika)
        references bd3_zawodnicy (nr_zawodnika);
        
insert into bd3_zdarzenia values
(1, 263, 1987, 'Zmiania klubu');

insert into bd3_zdarzenia values
(2, 263, 1978, 'Pobicie rekordu krajowego');

insert into bd3_zdarzenia values
(3, 265, 1977, 'Zmiania klubu');

select nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria,
rok as Rok,
zdarzenie as Zdarzenie
    from bd3_zawodnicy z
        join bd3_kluby kl on kl.nr_klubu=z.nr_klubu
        join bd3_kategorie ka on ka.nr_kategorii=z.nr_kategorii
        join bd3_zdarzenia zd on zd.nr_zawodnika=z.nr_zawodnika
;

--8--
insert into bd3_kluby values
(0,'Niezrzeszeni');

update bd3_zawodnicy
set nr_klubu=0
where nr_klubu is null;

alter table bd3_zawodnicy
modify nr_klubu number(4,0) not null;

