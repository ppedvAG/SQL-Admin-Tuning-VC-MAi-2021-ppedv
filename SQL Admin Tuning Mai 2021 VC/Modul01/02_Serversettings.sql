/*
HDD

IST: c:\Program Files.... NULL Gedanken wg HDD
WENN: D:\SQLDB
	  D:\SQLDB ..bei einer HDD 

WENN  D:\SQLDB
	  E:\LOG ..wenn 2 HDDs dann ok.. ansonsten kein Mehrwert

Wenn man die Pfade ändert.. Neustart... Fehler!!!

Nach Neustart sind alle Messwerte weg, und wir wissen nicht mehr warum etwas langsam war..



RAM
8GB

MIN : 0
MAX : 2,1 PB.  kann sich holen was er will--> und gibts nicht mehr her

es sollte eine MAX Grenze angegeben werden, damit das OS weiter sauber arbeiten

aber das OS braucht auch was...

Faustregel: mind 4
---         10%  (1 TB)  100GB.. neee... bei viel nix gud
--         1-4GB= 1GB  4 bis 16GB pro 4 GB 1 GB  danach alle 16GB 1 GB
256GB=     1GB      12/4=3GB    240/16 + 15     ca 19GB   20

im Setup bei 12 GB 8800


Gesamt RAM minus OS


Min RAM: 0 (auch im Setup verbleibt die 0), jeder andere Wert muss erst erreicht werden, damit der fix gilt

aber bei Konkurrenz: 2te Instanz.. Idee einer bleibt bei 0 und der anderer Wichtigere bekommt min Wert
Tipp: Max Arbeitssatz im TaskManager

Interess: 8,7GB MAX Arbeitssatz und akt. 6,1GB  entweder Absicht oder RAM Mangel

dbcc freeproccache


TaskManager: 1 Socket 8 CPUS

Achtung VM
Hardwaretopologie nachbilden
Affit. kann man gut so lassen wie sie sind: Autom


MAXDOP
Anzahl der CPUs die für Abfragen max verwendet werden können
Normalerweise sind mehr CPU günstiger/schneller

Grundsätzlich koste eine Abfrage mit 1 CPU weniger CPU Kosten  , als mit mehr CPUs


Früher vor 2019:
CPU: 0 .. alle Cpu machen mit. und zwar immer alle
ja.. aber erst dann mehr , wenn Kosten über 5 liegen


Faustregel: bei NICHT OLTP 25, bei OLTP 50
Anzahl CPU sollte = Anzahl der Kerne, aber max 8
*/
--TEST

use northwind


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, 
                         Orders.ShipCountry, Employees.LastName, Employees.FirstName, Employees.BirthDate, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, 
                         Products.ProductName, Products.UnitsInStock
INTO KUX
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into KUX
select * from KUX



select top 3 * from kux


select companyname , sum(unitprice*quantity) from kux 
group by companyname

--PLAN:
--rechts die Quellen.. nach links die Verarbeitung
--doppelpfeile.. mehr CPUS

set statistics io, time on -- CPU Dauer in ms und Gesamte Dauer in ms, IO = Anzahl der Seiten

set statistics io, time off-- oder Session beenden

--44178 Seiten gelesen
--CPU-Zeit = 1515 ms, verstrichene Zeit = 241 ms.

--bei Kostenschwellwert von 50 kein Parallismus...oder den MAXDOP auf 1 setzen.. dann auc nur 1 CPU
--, CPU-Zeit = 594 ms, verstrichene Zeit = 601 ms.

--teuer für CPU, aber gut für Dauer..

--bei 4 CPUs hauch langsamer aber weniger CPU Last

--bei 6 CPUS nahezu dasselbe Ergebnis, aber 2 CPU Kerne sind absolut frei

--Viele CPUS kosten deutlich mehr CPU Last wg Orga
--weniger CPUs evtl weniger Aufwand aber gleiche Dauer
--und nicht alle CPUS müssen etwas erledigen , sondern sind frei

--Die Einstellungen auf dem Server gelten für jede DB

--erst seit SQL 2019 kommt der MAXDOP im Setup vor... liess sich aber 
--bereits früher in allen Versionen bis SQL 2005 einstellen











*/


select * from sys.dm_os_wait_stats