/*
Instanz komplett eig Installation (Prozesse, DB, RAM, CPU)

Vorteil: Isolierung, Sicherheit
aus Tuning heraus nie ein Vorteil

Dienstkonto

NT Service\ .. Kennw�rter werden regel. vom Windows ge�ndert
..aber : kein Netzwerkzugriff (lokale KOnto) ..Backup

normaler User geht aber auch...

dem SQL Dienstkonto kann man ein Volumewartungstask Recht geben


Windows Sicherheitsrichtlinie
Durchf�hren von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausf�hren k�nnen, 
zum Beispiel eine Remotedefragmentierung.
Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht k�nnen Datentr�ger
durchsuchen und Dateien in den Speicher erweitern, der andere Daten enth�lt.
Wenn die erweiterten Dateien ge�ffnet werden, kann der Benutzer m�glicherweise die so erlangten Daten lesen und �ndern.

Standardwert: Administratoren

Recht , dasss SQL eig Dateien vergr��ern darf ohne auszunullen
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

je mehr User und je mehr Software desto h�her der Gebrauch der Tempdb

was macht die eigtl:  
#tab ##tab ..
Zeilenversionierung Kopie der Datens�tze mit Versionsnr
Auslagerungen von Abfragen, die eine schlechte RAM Einsch�tzig hatte
IX Wartung


Datendateien= Anzahl der Kerne, aber max 8

Tempdb sollte eig HDDs (getrennt f�r Log und Daten) haben

Im Hintergrund ab SQL 2016
--Traceflag 1117.. alle Datendateien immer gleich gro�
--Traceflag 1118 ..UNIFORM Extent in jedem Block nur ein Tabelle -- verhindern von Latches (int Sprrren, nur ein Thread kann auf einen Block zugreifen)

MAXDOP
Wieviel CPUs werden f�r eine Abfrage verwendet
Vorschlag 8

Empfehlung f�r MAX Speicher des SQL Server (Daten).. errechnet
Default ist 2,1 PB


Filestreaming Feature  stat Dateien in mdf nun per \\Freigabe

XML als Datentyp

*/
