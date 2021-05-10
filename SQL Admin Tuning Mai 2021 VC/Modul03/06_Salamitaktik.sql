/*

identisch
Tab A  10000
Tab B  100000

Abfrage auf TAB A, die 10 zeilen zurückgibt
Abfrage auf TAB B, die 10 zeilen zurückgibt

nach 5 Sek A
gleich

*/


--Statt einer sehr großen Tabelle mit allen Umsätzena aus 20 jahren lieber viele kleine Tabellen
--pro Jahr
create table u2021(id int, jahr int, spx int)
create table u2020(id int, jahr int, spx int)
create table u2019(id int, jahr int, spx int)
create table u2018(id int, jahr int, spx int)

--Anwendung braucht Umsatzttabelle

--part Sicht
create view Umsatz
as
select * from u2021
UNION ALL --keine suche nach doppelten Zeilen
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018
GO

select * from umsatz --alle tabellen

select * from Umsatz where jahr = 2020 --immer noch alle

--nachdem: ALTER TABLE dbo.u2021 ADD CONSTRAINT	CK_u2021 CHECK (jahr=2021)
--und das bei allen Tabellen wiederholen

--gibts noch weitere Einschränkungen.. NULL NOT NULL


--Aber.. aufwendig: neue Tab.. Sicht ändern, Einschr
--INS UP DEL geht , aber nur wenn kein Identity
--der PK muss ID und Jahr umfassen
--für Archivdaten ist es ok..


--Aber es gibt was besseres:
-- Seit SQL 2016 SP1 sind viele DInge aus Ent in SS Express reingerutsch bzw Std


--Partitionierung
--Dateigruppe

create table t1(id int) ---auf mdf

create table t1 (id int) ON 'C:\Prgra.......ndf'

create table t1 (id int) ON HOT

--HOT = C:\...ndf

create table testhotdata (id int) ON HOT

--bei best Tabellen



--Part 

--zuerst Dgruppen: bis100  bis200 bis5000 rest

USE [master]
GO
ALTER DATABASE [KursDBX] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [KursDBX] ADD FILE ( NAME = N'Kbis100', FILENAME = N'D:\_SQLDB\Kbis100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [KursDBX] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [KursDBX] ADD FILE ( NAME = N'Kbis200', FILENAME = N'D:\_SQLDB\Kbis200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [KursDBX] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [KursDBX] ADD FILE ( NAME = N'Kbis5000', FILENAME = N'D:\_SQLDB\Kbis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [KursDBX] ADD FILEGROUP [Rest]
GO
ALTER DATABASE [KursDBX] ADD FILE ( NAME = N'Krest', FILENAME = N'D:\_SQLDB\Krest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [Rest]
GO



--Funktion zur Partitionierung

-----------------------------------------------------------------------
--                   100                        200                 --
--         1                         2                       3


create partition function fZahl(int)
as
RANGE LEFT FOR VALUES (100,200)


select $partition.fzahl(117) -- 2


create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                   1        2     3

create table ptab (id int identity, nummer int, spx char(4100)) ON schZahl(nummer)


declare @i as int = 1

while @i<=30000
	begin
		insert into ptab values (@i, 'XY')
		set @i=@i+1
	end


--lohnt sich das..
--PLAN STATS

set statistics io, time on

select * from ptab where id = 100 --30000  , CPU-Zeit = 47 ms, verstrichene Zeit = 41 ms.
--Table SCAN   SCAN ist immer ein A bis Z Durchlauf..  SEEK: das Herauspicken

--HEAP = Sauhaufen


select * from ptab where nummer = 117 --100  , CPU-Zeit = 0 ms, verstrichene Zeit = 0 ms.
--SEEK auf HEAP

--Manipulierbar

---100---------200---------------5000----------------------------
--1           2                3          4

--Tab Schema F()
--Tab  wird nie angefasst

alter partition scheme schZahl next used bis5000 --ist noch nicht aktiv

alter partition function fzahl() split range (5000)

select * from ptab where nummer = 1170

--Grenze entfernen..
----------x100----------------200-----5000--------------

--   F() 

alter partition function fzahl() merge range (100)

select * from ptab where nummer = 117--



/****** Object:  PartitionFunction [fZahl]    Script Date: 06.05.2021 16:42:16 ******/
CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO


CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [Rest])
GO


--- A bis M    N bis R   S bis Z  Familienname
create partition function fZahl(varchar(50))
as
RANGE LEFT FOR VALUES ('N','S')


-----------------M]-------------------------R]----------------------


--- nach Jahren 
create partition function fZahl(datetime)
as
RANGE LEFT FOR VALUES ('31.12.2019 23:59:59.999','1.1.2020')

--datetime ist ungenau  2 bis 3 ms ms Varianz








create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY]) --geht das ode rmacht das keinen Sinn



--T1  T2 T3 auf Primary

------------------------------------------
xxxxxT1xxT2xxxxxxxxxT3xxxxxxxxxxxxxxxx
-------------------------------------------

-------------PRIMARY---------------------------------
xxxxxxP1x P2xxxxxx   P3xxxxxxxxxxxxxxxxx   
----------------------------------------------

--Archivierung

create table archiv (id int not null, nummer int, spx char(4100)) on bis200 --muss dort sein, wo auch die zu versch Part ist

alter table ptab switch partition 1 to archiv

select * from archiv 

select * from ptab
--eigtl benennen wir die Partition nur in eine Tabelle um


--wenn wir 100MB/Sek verschieben können, wie lange würde das Archivieren dauern, wenn es 1000TB wären?
--nee.. 10 Sek... wenige ms












