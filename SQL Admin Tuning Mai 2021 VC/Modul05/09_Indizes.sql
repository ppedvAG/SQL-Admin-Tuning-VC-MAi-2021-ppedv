/*
Welche INdizes gibts

Clustered  gruppierte 
gut bei between größer kleiner auch bei =  
nur 1 mal pro Tabelle
gut bei Bereichsabfragen
=Tabelle in pyhsdik sortierter Form
bei Vergabe von IX zuerst den gr festlegen

NON CLUSTERED  nicht gruppierte
----------------------------
! eindeutiger
! gefilterter IX Achtung weniger Ebenen
! zusammengesetzte IX
! IX mit eingeschlossenen Spalten
! part. IX jeder fall wird abgedeckt.. funktioniert dann eff wie gefiltert
! abdeckender (ideale IX)
realer hypoth IX  (Tool)
ind Sicht
------------------------------
Columnstore IX 


SCAN ist ein A bis Z 
SEEK herauspicken
*/


set statistics io, time on


alter table ku2 add ID int identity

--ohne jegl IX: TABLE SCAN
select id from ku2 where ID = 100 --58346    CPU-Zeit = 1203 ms, verstrichene Zeit = 211 ms.
--NIX_ID
select id from ku2 where ID = 100 --3		 CPU-Zeit = 0 ms, verstrichene Zeit = 0 ms.


--NIX_ID passt noch, aber Lookup im HEAP
select id, freight from ku2 where ID = 100 --4 		 CPU-Zeit = 0 ms, verstrichene Zeit = 0 ms.


select id, freight from ku2 where ID < 12000 -- je mehr desto schlimmer bis TABLE SCAN.. ab 1 % 

--das ganze ohne Lookup.. geht nur wenn Info im IX sein

--NIX_ID_FR --eindeutiger nicht gruppierter zusammengesetzer IX 
select id, freight from ku2 where ID = 100
select id, freight from ku2 where ID < 100
select id, freight from ku2 where ID < 12000
select id, freight from ku2 where ID < 20000000

--das Dumme ist nun: ein zusamm. IX kann nur 16 Spalten haben und Schlüselwert muss unter 900 byte 
--zusamm IX ist nur gut wenn es mehr where Spalten gibt.. man braucht die Spalten nur zum Finden

select *  from ku2 where ID = 100

--es gibt eine besserer Variante

select ID, freight, CompanyName from ku2 where Country= 'USA' 

--IX mit eingeschlossenen Spalten. besser weil Baum nicht belastet wird
--und weil man ca 1000 Spalten einschliessen kann


select ID, freight, CompanyName from ku2 where Country= 'USA' and City = 'London'

--NIX_CY_CI_inkl_IS_FR_CN


select companyname, sum(unitprice*quantity) from ku2 k2
where k2.Freight = 110
group by companyname


--2 IX: NIX_CY_inkl_ID_FR_LN   NIX_CI_inkl_ID_FR_LN
--kein Vorschlag bei oder
select ID, freight, Lastname from ku2 where Country ='USA' OR City = 'London'

--in dem Fall: NIX-- Klammern setzen!!
select ID, freight, Lastname from ku2 
	where 
		Country ='USA' OR (Freight = 0.02 and Lastname like 'B%')


select ID, freight, Lastname from ku2 
	where 
		(Country ='USA' OR Freight = 0.02) and Lastname like 'B%'


--IX filtern, denn dann wird er Index kleiner
--weniger Ebenen

select ID, freight, Lastname from ku2 where Country = 'USA'

--Alternative_ der Weiltweite ungefilterte

select ID, freight, Lastname from ku2 where Country='Germany'


select country, COUNT(*) from dbo.ku2
group by country


create view viewdemo with schemabinding --es ist kein * mehr erlaubt, Tabellen exakt benennen
as
select country, COUNT_BIG(*) as Anzahl from dbo.ku2
group by country


select * from viewdemo

select country, COUNT(*) from dbo.ku2
group by country


--extrem eingeschr. Sicht muss schemgebunden, count_BIG., nnnnnnnnn weitere


CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20210507-150931] ON [dbo].[viewdemo]
(
	[country] ASC





select * into k3 from ku2 
select * into k4 from ku2 


--CPU-Zeit = 187 ms, verstrichene Zeit = 201 ms. 2330
--, CPU-Zeit = 157 ms, verstrichene Zeit = 150 ms.
select companyname, SUM(unitprice*quantity) from k3
where country like 'U%'
group by companyname

--statt 420MB  4MB.. stimmt ..dann aber nur durch KOmpression
select companyname, SUM(unitprice*quantity) from k4
where country like 'G%'
group by companyname


select companyname, SUM(unitprice*quantity) from k4
where City like 'G%'
group by companyname

--nach ArchichKompr 20% weniger

--und das wandert in den RAM


--INDIZES müssen gewartet werden

--IX können reorg nur die Ebene mit den Zeigern wird komprimiert und in Form gebracht
--oder rebuild  auch baum und Zeigerebene wird komprimiert in Form gebracht

--Rebuild  > 30% Frag
--Reorg    > 10% Frag

--täglich

--fehl Indizes und überflüssige



Seite 1 --114    Seite 114--2

a					a
a
a
a						a
						a
						a
						a






select * from sys.dm_db_index_usage_stats
a
a
a





