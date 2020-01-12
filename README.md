## Build-Umgebung für RaspberryMatic

Mit [RaspberryMatic](https://github.com/jens-maus/RaspberryMatic) ist es möglich eine HomeMatic CCU auf einem RaspberryPi zu betreiben. Für das Bauen von RaspberryMatic werden etliche Werkzeuge auf dem Entwicklungsrechner vorausgesetzt. Hier wird nun ein fertiges Docker-Image zur Verfügung gestellt, das alle nötigen Werkzeuge enthält und direkt die RaspberryMatic-Quellen übersetzen und ein fertiges SD-Karten-Image bauen kann. Es wird natürlich eine lauffähige [Docker Umgebung](https://www.docker.com/community-edition) benötigt.

Erfahrungen mit Docker und der Linux-Konsole sollten vorhanden sein.

---
### Installation des Images

Das Docker-Image kann mit folgendem Befehl aus dem öffentlichen Docker-Repository installiert werden: 

    docker pull mdzio/rm-build-env

---
### Starten des Containers

Es muss ein Volume erstellt und eingehängt werden (s.a. Option `-v`). Mindestens 25 GByte freier Platz sollten zur Verfügung stehen. Auf dem Volume wird später RaspberryMatic mit allen Zwischendateien gebaut.

Der Container kann dann wie folgt gestartet werden:

    docker run -it --rm -v rmbuild:/rmbuild mdzio/rm-build-env

Bedeutung der Optionen:

|Option|Bedeutung|
|---|---|
|-it|Interaktiv und mit Konsole|
|--rm|Änderungen am Container verwerfen (Im Volume bleiben sie erhalten!)|
|-v|Volume erstellen und einhängen|

---
### RaspberryMatic bauen

Folgende Zielplattformen können gebaut werden: `raspmatic_intelnuc`, `raspmatic_ova`, `raspmatic_rpi0`, `raspmatic_rpi3`, `raspmatic_rpi4` und `raspmatic_tinkerboard`. Mit `build-all` werden alle Zielplattformen gebaut.

Das Image für Raspberry Pi 2 und 3 wird beispielsweise innerhalb des Containers mit folgenden Kommandos gebaut:

    git clone https://github.com/jens-maus/RaspberryMatic
    cd RaspberryMatic
    make raspmatic_rpi3

Je nach Rechnerleistung bewegt sich die Build-Dauer zwischen einer und mehreren Stunden. Eine SSD hilft viel. Das fertige Image ist dann im Container unter `/rmbuild/RaspberryMatic/build-raspmatic_rpi3/images/sdcard.img` zu finden.

Das SD-Karten-Image kann auf den lokalen Rechner kopiert werden, wenn zusätzlich ein lokales Verzeichnis eingehängt wird. Im folgenden Beispiel wird der Container kurz gestartet um `cp` auszuführen, das die Datei nach `/home/Mathias` (im Container) bzw. `/c/Users/Mathias` (auf dem lokalen Rechner) kopiert:

    docker run -it --rm -v rmbuild:/rmbuild -v /c/Users/Mathias:/home/Mathias mdzio/rm-build-env cp /rmbuild/RaspberryMatic/build-raspmatic_rpi3/images/sdcard.img /home/Mathias

---
### Erstellen des Docker-Images

Die Quellen zum Erstellen des Docker-Images sind auf [GitHub](https://github.com/mdzio/rm-build-env) zu finden. In das Verzeichnisses der Datei `Dockerfile` wechseln und dann folgenden Befehl ausführen: 

    docker build -t rm-build-env .

---
### Tipps für Docker unter Windows

* *Docker Community Edition for Windows* setzt Windows 10 Professional voraus. Ansonsten muss die [Docker Toolbox for Windows](https://docs.docker.com/toolbox/toolbox_install_windows/) installiert werden.
* Unter Windows kann durch Setzen der Umgebungsvariable MACHINE_STORAGE_PATH **vor** Installation der *Docker Toolbox* ein anderes Laufwerk für die virtuelle Maschine gewählt werden.
* Lokale Laufwerke können über _Docker Desktop → Settings → Shared Drives_ eingebunden werden.