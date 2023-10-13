# ***Archivar***

## 1. Programme


### 1.1 Setup
Vorraussetzung für die Installation ist eine Installation von [FireBIRD](https://firebirdsql.org/).
Das Setup installiert setzt die Datenbank auf, spielt notwendige Daten ein und setzt den notwenigen Service auf.

### 1.2 Archivar
Das eigentliche Client-Programm

#### 1.2.1 Plugins
Plugins sind eine einfach Möglichkeit, das Programm um weitere Möglichkeiten, zu erweitern, ohne jedoch das Hauptprogramm selbst
zu verändern.

##### 1.2.1.1 Dairy
Ein einfaches Plugin, das es ermöglicht, ein Tagebuch zu führen. Es ist auch möglich die einträge zu Verschlüsseln.

##### 1.2.1.2 IMAP
Für den benutzerspezifischen Zugriff auf ein Postfach per IMAP.

#### 1.2.1.3 Crriculum
Geplant: Verwlatung der Fortbildungen und Schulungen der Mitglieder eines Betriebsrates.

### 1.3 Archivar-Server
Der Applikations-Server, der die eigentliche Logik abbildet. GEspeichert werden die Daten größtenteils in einer FireBIRD-Datenbank.

### 1.4 Launcher
Der Launcher ist der "Installer" des Archivar-clients. ER dient zur Installation und auch zum Update des
Programmes.

### 1.5 Guard
Der Guard stellt sicher, das der Server immer funktionsbereit ist.

## 2. Benutzte Projekte

Es wurde die Enviroment-Variable GITHOME ("d:\git") benutzt um Zugriff auf die GIT-Projekte
zu erhalten.

### 2.1 Datenbank
1. [RDBMS FireBIRD](https://firebirdsql.org/)
2. [Tool FlameRobin](http://www.flamerobin.org/)

### 2.2 Github

1. [Archivar](https://github.com/Target42/Archivar.git)
2. [Drag and Drop for Delphi](https://github.com/landrix/The-Drag-and-Drop-Component-Suite-for-Delphi.git)
3. [Excel4Delphi](https://github.com/rareMaxim/Excel4Delphi.git)
4. [Delphi Web Script](https://github.com/EricGrange/DWScript.git)
5. [Grijjy Foundation](https://github.com/grijjy/GrijjyFoundation.git)
6. [Grijjy DelphiZeroMQ](https://github.com/grijjy/DelphiZeroMQ.git)
7. [Grijjy Cloud Logger](https://github.com/grijjy/GrijjyCloudLogger.git)

### 2.3 GetIt
1. GLibWMI
2. JEDICodeLibraryJCL
3. JEDIVisualComponentLibraryJVCL
4. MustangpeakListView
5. LockBox
6. DOSCommand
7. SynEdit




