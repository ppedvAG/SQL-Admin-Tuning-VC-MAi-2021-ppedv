/*

Profiler:
in Datei aufzeichnen
Dateirollover entfernen. MaximalGröße erhöhen....
Enddatum und Zeit angeben
Vorlage: Standard

Ereignisse:
sp:Stamentcompleted
TSQL: Batchstarting
TSQL BatchCompleted

Filter: zb nur die DB Northwind
--Filter können nur gesetzt werden, wenn auch die SPalten sichtbar ist

Representativen Querschnitt mitprotokollieren
--Vorsicht . kann seh viel werden...


DatabaseTuningAdvisor
Settings...:
Auslastung in tempdb
Ressource für Auslastung: Profilerdatei oder auch Abfragespeicher
Settings: alle pyhsiscihen Entwurfsstrukturen aktivieren..

keine vorhanden beibelassen. Auch ein Löschen kann ein Vorteil sein..


Perfmon:
Gleichzeitig mit Profiler aufzeichnen, da sich die Ergebnisse übereinander legen lassen
Geht aber nur , wenn der Profiler ein Aufzeichnung geladen hat..
Ablaufverfolgung öffnen von Datei zb 
... und dann DateiLeistungsdaten importieren..
Vorlage verwenden.. ;-)






*/