/*
Sicht hat keine Daten
Sicht ist nur ein Name f�r eine Abfrage

Sicht wird wie Tabelle behandelt
SEL INS UP DEL  Rechte

select * from (select * from tabelle) v

Eine Sicht ist gleich schnell wie eine adhoc Abfrage. Kann man sehr gut im Plan erkennen.

Tipp: eine Sicht immer mit with schemabindung schreiben lassen. Kann nur richtig sein;-)
Kein * mehr zB


------------------------------------------------

Proc ist wie ein Batch unter windows
bei der ersten Ausf�hrung wird dem den ersten Parametern der Plan festgelegt und immer wieder verwendet.
Der Code wird genauso interpretiert wird ein adhoc Abfrage. Allerdings muss der Plan nicht neu erdacht bzw erstellt werden.
--> Analyse und Kompilierzeit entf�llt also.
Prozedur ist also schneller. 

Problem der Prozedur: Der Plan ist ma�geschneidert f�r den ersten Aufruf. Ist aber auch noch so, wenn man einen anderern Wert 
�bergibt. Statt weniger , pl�tzlich viele Eregbniszeilen... Dann w�re der Plan absolut suboptimal....


Funktionen
stehen immer auf der Giftliste, da sie zB teilweise nicht parallelisiert werden k�nnen und so gut wie immer zu einem Scan f�hren
erst ab SQL 2017/2019 wird der Code besser interpretiert. Aber nur bei einfachen Abfragen und Skalarwertfunktionen.

Nur wenige F() sind optimal...

Mal nebenbei: Der Ausf�rhungsplan des SQL Servers ist hier oft nicht weiterf�hrend, da er durchaus manche Dinge nicht zeigt.
Vor allem der tats Ausf�hrungsplan... 




*/

create proc gpdemoxyz @par int
as
--IN UP DE SEL
select * from orders where orderid = @par
Update
del
sel



exec gpdemoxyz 10232