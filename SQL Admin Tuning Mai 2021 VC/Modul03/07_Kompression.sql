select * into ku2 from kux

--Ist ein HEAP Sauhaufen..
set statistics io, time on
select * from ku2 where city = 'Berlin' ---SCAN 44178 Seiten... von HDD in RAM

--1 MIO DS in RAM auch bei 6000 Zeilen Ergebnis

--Datentypen optimieren-- weniger Seiten datetime -> date
--aber ohne Anwendung zu ändern

--Kompression: Seiten vs Zeilen

--Zeilenkompression: char(50) hat immer 50 Zeichen
--wirft Leermenge raus

--Seitenkompression: zuerst Zeilenkompr. dann Algortihmus für Kompr

--Was aber passiert bei der Kompression

--Unkomprimiert
--Tab 30000 Seiten --- CPU 500ms  Dauer 600ms
--IO 30000
--RAM: 30000 Seiten im RAM (240+)
--CLIENT bekommt 240MB

--komprimiert
-- TAB Seiten
--IO 100
--RAM weniger
--CPU:mehr
--Dauer: gugg ma mal
--CLIENT: 240MB


--216 --232  607
--455 cpu 46
set statistics io, time on

select * from Kursdbx.dbo.t1
--44 Seiten im RAM
--idR wird die CPU steigen
-- Kompressionsfaktor: 40-60%

--Kompr. lohnt sich wenn wir rel gut komprimieren können
--die Dauer wird kaum geringer, aber der RAM wird weniger ausgelastet
--gut bei: Archivtabellen
--bezhalt wird mit CPU.. bei Knappheit dann eher nicht komprimieren
--ab SQL 2016 SP1 in jeder Version





