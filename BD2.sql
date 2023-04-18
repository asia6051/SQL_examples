create table BD2_ZBIORCZA_TEMP
(
    nr_zawodow			number(2)
   ,nr_zawodnika		number(4)
   ,imie				varchar2(15)                
   ,nazwisko			varchar2(30)	not null
   ,plec				varchar2(1)		not null
   ,rok_urodzenia		number(4)                   
   ,nr_klubu			number(3)		not null
   ,klub				varchar2(40)	not null
   ,kategoria			varchar2(6)		
   ,pkt_generalna		number(2)                  
   ,pkt_kategorie		number(2)                   
   ,constraint PK_ZBIORCZA_TEMP primary key (nr_zawodow, nr_zawodnika)
);

alter table BD2_ZBIORCZA_TEMP
	add constraint CH_PKT_GENERALNA_TEMP check (pkt_generalna between 1 and 50);
	
alter table BD2_ZBIORCZA_TEMP
	add constraint CH_PKT_KATEGORIE_TEMP check (pkt_kategorie between 1 and 50);	
	
alter table BD2_ZBIORCZA_TEMP
	add constraint CH_PLEC_TEMP check (plec in ('M', 'K'));

--drop table bd2_zbiorcza_temp;

alter table bd2_zbiorcza_temp
    drop CONSTRAINT CH_PLEC_temp;

alter table bd2_zbiorcza_temp
modify plec varchar2(10);

update bd2_zbiorcza_temp
    set plec='Kobieta'
where plec='K';

update bd2_zbiorcza_temp
    set plec='Mezczyzna'
where plec='M';

alter table bd2_zbiorcza_temp
    rename column plec
    TO plec_nazwa;

alter table bd2_zbiorcza_temp
    add CONSTRAINT ch_plec_temp check (plec_nazwa in ('Mezczyzna', 'Kobieta'));
    
alter table bd2_zbiorcza_temp
drop CONSTRAINT ch_pkt_kategorie_temp;

alter table bd2_zbiorcza_temp
add constraint ch_pkt_kategorie_temp check (pkt_kategorie BETWEEN 0 and 50);

update bd2_zbiorcza_temp
    set pkt_kategorie='0'
where pkt_kategorie is null;

alter table bd2_zbiorcza_temp
modify pkt_kategorie number(2) not null;

SELECT imie, nazwisko,rok_urodzenia,nr_klubu from bd2_zbiorcza_temp
where rok_urodzenia>1975 and plec_nazwa='Mezczyzna' and nr_klubu between 3 and 10
order by nr_klubu desc, rok_urodzenia desc;

select imie, nazwisko, plec_nazwa,kategoria
from bd2_zbiorcza_temp
where (nazwisko LIKE '%ski' or nazwisko like '%ska')
and kategoria in ('I','II','K-II','K-V')
order by plec_nazwa, nazwisko
;

SELECT imie, nazwisko,klub, pkt_generalna, kategoria
FROM bd2_zbiorcza_temp
WHERE klub='KB Gymnasion Warszawa'
AND pkt_generalna is null
ORDER BY kategoria, nazwisko
;

SELECT distinct nazwisko ||' '|| imie as Godnosc, kategoria,klub
FROM bd2_zbiorcza_temp
WHERE pkt_kategorie=0
AND kategoria in ('II','III','V')
ORDER BY kategoria, klub, Godnosc
;