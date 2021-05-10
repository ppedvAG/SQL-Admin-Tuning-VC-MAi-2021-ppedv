/*
Instanz komplett eig Installation (Prozesse, DB, RAM, CPU)

Vorteil: Isolierung, Sicherheit
aus Tuning heraus nie ein Vorteil

Dienstkonto

NT Service\ .. Kennwörter werden regel. vom Windows geändert
..aber : kein Netzwerkzugriff (lokale KOnto) ..Backup

normaler User geht aber auch...

dem SQL Dienstkonto kann man ein Volumewartungstask Recht geben


Windows Sicherheitsrichtlinie
Durchführen von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausführen können, 
zum Beispiel eine Remotedefragmentierung.
Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht können Datenträger
durchsuchen und Dateien in den Speicher erweitern, der andere Daten enthält.
Wenn die erweiterten Dateien geöffnet werden, kann der Benutzer möglicherweise die so erlangten Daten lesen und ändern.

Standardwert: Administratoren

Recht , dasss SQL eig Dateien vergrößern darf ohne auszunullen
------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
------------------------------------------------------------

wer es aktiviert, der macht nichts falsch. Ein guter Admin.. dem ist es egal



Dateipfade der DB

DB besteht aus mind. idR 2 Dateien: .mdf (master data file) Daten   .ldf (Tlog)

1. jeder I U D wird immer zuerst in das TLOG und in den RAM  .. parallel
Man kann nicht schneller schreiben als das TLOG schreiben kann

2. CHECKPOINT (schreibt nur die commited Daten weg)
3. jetzt werden die Daten in das mdf geschrieben


Trenne Daten von Logfile physikalisch  (eigtl pro DB)

TEMPDB

je mehr User und je mehr Software desto höher der Gebrauch der Tempdb

was macht die eigtl:  
#tab ##tab ..
Zeilenversionierung Kopie der Datensätze mit Versionsnr
Auslagerungen von Abfragen, die eine schlechte RAM Einschätzig hatte
IX Wartung


Datendateien= Anzahl der Kerne, aber max 8

Tempdb sollte eig HDDs (getrennt für Log und Daten) haben

Im Hintergrund ab SQL 2016
--Traceflag 1117.. alle Datendateien immer gleich groß
--Traceflag 1118 ..UNIFORM Extent in jedem Block nur ein Tabelle -- verhindern von Latches (int Sprrren, nur ein Thread kann auf einen Block zugreifen)

MAXDOP
Wieviel CPUs werden für eine Abfrage verwendet
Vorschlag 8

Empfehlung für MAX Speicher des SQL Server (Daten).. errechnet
Default ist 2,1 PB


Filestreaming Feature  stat Dateien in mdf nun per \\Freigabe

XML als Datentyp

*/
