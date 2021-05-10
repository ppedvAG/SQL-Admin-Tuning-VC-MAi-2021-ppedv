create database KursDBX


/*
Viele Fehler

Wie gro� ist die DB nun ?

mdf   8 MB
ldf   8 MB

fr�her: mdf 5MB ldf 2 MB  

Um wieviel MB w�chst eine ldf bzw mdf Datei?
64MB pro 

fr�her: 1MB mdf     10% ldf


Probleme: wen man klein beginnt...immer wieder verg��ern


Wir sollten das tun:
Anfangsgr��e festlegen: auf das, was in 3 Jahren kommen wird... in 3 J = 100GB
	--im Backup nur das, was an Daten drin steckt
	--Logfile: ca 25% der Daten.. besser so: beim Sichern des Logfiles sollte es ca 70% voll sein
	-- und es sollte nie wachsen

    --Beim wachsen Fragementierung 

	--Wachstumsrate sollte in h�heren MB Zahlen sein... 1 GB

*/
create table t1 (id int identity, spx char(4100))--..ca 4 kb
--34  14  15 16

insert into t1
select 'XY'
GO 30000

--Wie gro� m�sste t1 sein?
--
select 30000*4-- 120 MB

--T1 hat 240 MB statt erwartet 120 MB
--ich konnte pro Sek 7 mal vergr��ern um 1 MB zu etwa 6 ms
--besser wenn schnellere HDD oder HDD mehr entlastet wird.. oder noch besser: wenn vergr. gar nicht geschehen muss


create table t2 (id int identity, spx char(4100))--..ca 4 kb
--34  14  15 16

select * into t4 from t2  --2 Sek bei Massenoperation



Kompabilit�tsgrad.. auf h�chsten Wert setzn..


--Wiederherstellungsmodel
/*
Einfach
I U D BULK (rudiment�r).. bei Commit dann wird diese TX autom gel�scht
TLog nicht sicherbar
--schneller
--wenig sicherer

Massenprotoklliert
wie Einfach.. aber es wird nach Commit nichts gel�scht
Backup des Log ist Pflicht, weil es sonst immer weiter w�chst.. Auch eine V und D Sicherung �ndert nichts am Logfile
--Kompromiss


Vollst�nd Model
wie Massenprotkolliert, aber auch BULK ausf�hrlich, auch IX Stats
auf Sek restore
--langsamer
--sicherer


Hochverf�gbarkeit zwingt meist zu BULK oder FULL


500MB es reicht jeden Tag eine oder 2 Sicherung--> Einfach

kann man jederzeit �ndern im Betrieb





*/

insert into t2
select 'XY'
GO 30000










*/