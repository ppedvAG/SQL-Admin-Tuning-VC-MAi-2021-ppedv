/*

Normalisierung
Redundanz vermeiden...
Stammtabellen und Bewegeungstabellen
1NF atomar.. jede Zelle darf nur einen Wert besitzen
2NF PK 
3NF keinen gegens Bez zwischen den Spakten ausserhalb des PK  ---------8263 Burghausen    8000 München


RngSumme... alle Kunden (1 MIO) JOIN alle Bestellungen (2 Mio Best)  JOIN  Positionen (4 MIO)
.....        7 MIO
--wenn die RngSumm in Best wäre, dann deutlich günstiger

PK FK  Beziehungen

Redundanz

Datentypen

Otto

varchar(50)  ... 'Otto'    4
char(50)     ... 'otto                                    ' 50
nvarchar(50) ... 'otto'     4  *2  8 
nchar(50)    ... 'otto                                    ' 50 *2  100
text()      seit 2005 depricated

in der Db verwenden wir imer doppelte Mnege bei char Feldern; auch wenn wir das nicht brauchen
zb Land , KundenNr


Datum
smalldatetime sek
datetime ms
timestamp 
date
datetime2 ns
datetimeoffset

bei GebTag auch ms... ? 

man braucht immer mehr Platz als sein muss..


aber ist nicht egal....

DS müssen in sog Seiten
Seitenhaben immer ein Größe von 8192 bytes
1DS kann dabei max 8060 Zeichen belegen
1 Seite kann max 8072 Zeichen belegen lassen, der Rest ist Verwaltungsaufwand
1 DS muss idR reinpassen

1 Seite sollte so voll wie möglich sein
weil SQL Server liest Seiten von der HDD 1:1 in RAM

8 Seiten am Stück werden Block genannt. SQL Server liest lieben gerne Blockweise

Tuning bedeutet: Rduzierung von Seiten und Blöcken!!!!!


Warum ist die Tabelle t1 aus der KU 240MB und nicht 120MB?
Weil 1 DS ca 4100 bytes besitzt, daher pass pro Seite nur einer rein
--pro DS 1 Seite -- 30000 240 MB

dbcc showcontig('t1')

-- Gescannte Seiten.............................: 30000
--- Mittlere Seitendichte (voll).....................: 50.79%


*/

create table t5 ( id int, sp1 char(4100), sp2 char(4100))  --geht

set statistics io , time on
select * from t1 where id = 100
--Wie bringt man das weg,wenn es schon da ist





























*/