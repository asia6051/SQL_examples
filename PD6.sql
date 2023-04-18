--1--
select imie ||' '|| nazwisko as Zawodnik,
rezultat_min ||':'|| rezultat_sek as Rezultat
    from bd3_zawodnicy z
        join bd3_wyniki w on z.nr_zawodnika=z.nr_zawodnika
where nr_klubu = 
    (select nr_klubu
        from bd3_zawodnicy z
            join bd3_wyniki w on z.nr_zawodnika=w.nr_zawodnika
        where nr_zawodow=2 and lokata_w_biegu=1 and plec='M'
    )
;

select nr_klubu
        from bd3_zawodnicy z
            join bd3_wyniki w on z.nr_zawodnika=w.nr_zawodnika
        where nr_zawodow=2 and lokata_w_biegu=1 and plec='M';
        
--2--
select imie ||' '|| nazwisko as Zawodniczka
    from bd3_zawodnicy z
where plec='K' and nr_klubu in
    (select nr_klubu from
        (select kl.nr_klubu,
        count(*) as liczba_zawodnikow
            from bd3_zawodnicy z
                join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        group by kl.nr_klubu
        having count(*) > 5
        )
    )
;
select nr_klubu from
        (select kl.nr_klubu,
        count(*) as liczba_zawodnikow
            from bd3_zawodnicy z
                join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
        group by kl.nr_klubu
        having count(*) > 5
        )
;

--3--
-- z warszawy
select nr_klubu, nazwa_klubu
            from bd3_kluby
        where nazwa_klubu like '%Warszaw%'
;
--nie z warszawy
select nr_zawodnika,nazwa_klubu
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
    where kl.nr_klubu not in 
        (select nr_klubu
            from bd3_kluby
        where nazwa_klubu like '%Warszaw%'
        )
;

select imie ||' '|| nazwisko as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria
    from bd3_zawodnicy z
        join bd3_kluby kl on kl.nr_klubu=z.nr_klubu
        join bd3_kategorie ka on ka.nr_kategorii=z.nr_kategorii
where plec='K' 
and nr_zawodnika in 
    (select nr_zawodnika
    from bd3_zawodnicy z
        join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
    where kl.nr_klubu not in 
        (select nr_klubu
            from bd3_kluby
        where nazwa_klubu like '%Warszaw%'
        )
    )
and (extract(year from sysdate)-extract(year from data_urodzenia)) >
    (select avg(extract(year from sysdate)-extract(year from data_urodzenia))as Srednia
        from bd3_zawodnicy
        where plec='K'
    )
;

--4--
--pierwszy mezczyzna
select rownum, "Zawodnik", "Suma" 
from( select w.nr_zawodnika "Zawodnik",
        nvl(sum(punkty_globalne),0) "Suma"
        from bd3_zawodnicy z
            join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
        where plec='M'
        group by w.nr_zawodnika
        order by 2 desc
    )
where rownum=1
;
--pierwsza kobieta
select rownum, "Zawodnik", "Suma" 
from( select w.nr_zawodnika "Zawodnik",
        nvl(sum(punkty_globalne),0) "Suma"
        from bd3_zawodnicy z
            join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
        where plec='K'
        group by w.nr_zawodnika
        order by 2 desc
    )
where rownum=1
;
--calosc--
select nazwisko ||' '|| imie as Zawodnik,
nazwa_klubu as Klub,
nazwa_kategorii as Kategoria
from bd3_zawodnicy z
    join bd3_kluby kl on z.nr_klubu=kl.nr_klubu
    join bd3_kategorie ka on z.nr_kategorii=ka.nr_kategorii
where nr_zawodnika =
    (select "Zawodnik" 
        from( select w.nr_zawodnika "Zawodnik",
            nvl(sum(punkty_globalne),0) "Suma"
                from bd3_zawodnicy z
                    join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
            where plec='M'
            group by w.nr_zawodnika
            order by 2 desc
            )
    where rownum=1
    )
or nr_zawodnika =
    (select "Zawodnik" 
        from( select w.nr_zawodnika "Zawodnik",
            nvl(sum(punkty_globalne),0) "Suma"
                from bd3_zawodnicy z
                    join bd3_wyniki w on w.nr_zawodnika=z.nr_zawodnika
            where plec='K'
            group by w.nr_zawodnika
            order by 2 desc
            )
    where rownum=1
    )
;

