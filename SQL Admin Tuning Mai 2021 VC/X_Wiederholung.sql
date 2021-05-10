/*

1. Setup

VM Hardware muss ident. Layout haben wie HOST

BWIN...  in einer Sek 100000... für einen Tabelle 1000 HDD... Part. 
AMAZON 2015 in BRD 12 MIO TX




RAM
Max RAM vorgeben: Gesamt RAM - OS= ???? Empfehlung default 0 bis 2,1PB

3 INST  10 GB
bei jedem Setup der 3 Inst wird ca 7700 MB vorgeschlagen
Inter. sich nicht für andere Instanzen oder Software


HDD
Pfade (Log und Daten trennen)
mehr Logfiles machen keinen Sinn, da immer nur eines reingeschrieben wird
Volumewartungstask: Ausnullen müssen bei Vergr.

tempdb
Anzahl Kerne = Anzahl der Datendateien der tempdb aber max 8 
Log und Daten trennen
T1117 Dateien immer gleich gross .. aber das klappt nur, wenn das autom geht...
T1118 Uniform Extent jede Tabelle bekommt eig Block


CPU
MAXDOP
seit SQL 2019: Max 8 CPUs od Anzahl der Kerne...sonst default: 0 (alle) 600ms vs 1500ms
MAXDOP 6  (auf Server + pro DB + Abfrage)
Kostenschwellwert (nur auf Server):  1 oder alle aus MAXDOP

taucht im Plan ein Parellism Gather und Repartition Stream auf, sollte es mit weniger CPU besser laufen




*/