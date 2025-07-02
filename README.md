## Build-Umgebung für RaspberryMatic

Mit [RaspberryMatic](https://raspberrymatic.de/de/start/) ist es möglich eine HomeMatic CCU auf einem RaspberryPi oder anderen Kleinstrechnern zu betreiben. Für das Bauen von RaspberryMatic werden etliche Werkzeuge auf dem Entwicklungsrechner vorausgesetzt. Hier wird nun ein fertiges Docker-Image zur Verfügung gestellt, das alle nötigen Werkzeuge enthält und direkt die RaspberryMatic-Quellen übersetzen und ein fertiges SD-Karten-Image bauen kann. Es wird natürlich eine lauffähige [Docker Umgebung](https://www.docker.com/community/) benötigt.

Erfahrungen mit Docker und der Linux-Konsole sollten vorhanden sein.

---
### Installation des Images

Das Docker-Image kann mit folgendem Befehl aus dem öffentlichen Docker-Repository installiert werden: 

    docker pull mdzio/rm-build-env

---
### Starten des Containers

Es muss ein Volume erstellt und eingehängt werden (s.a. Option `-v`). Auf dem Volume wird später RaspberryMatic mit allen Zwischendateien gebaut. Mindestens 25 GByte freier Festplattenplatz und 4 GB Arbeitsspeicher sollten für das Bauen eines einzigen Build-Zieles (z.B. raspmatic_rpi2) zur Verfügung stehen. 

Eine Konsole innerhalb des Containers kann dann wie folgt geöffnet werden:

    docker run -it --rm -v rmbuild:/rmbuild mdzio/rm-build-env

Bedeutung der Optionen:

|Option|Bedeutung|
|---|---|
|-it|Container interaktiv und mit Konsole starten.|
|--rm|Beim Beenden wird der Container verworfen. (Die Dateien im Volume bleiben erhalten!)|
|-v|Volume einhängen.|

---
### RaspberryMatic bauen

Hinweis: Die folgenden Befehle müssen auf einer Konsole innerhalb des Docker-Containers ausgeführt werden.

Die aktuellen Quellen vom RaspberryMatic GitHub-Repository herunterladen:

    git clone https://github.com/jens-maus/RaspberryMatic
    cd RaspberryMatic

Eine Liste der unterstützten Build-Ziele wird mit folgendem Befehl ausgegeben:

    make help

Das Image für ein Raspberry Pi 2 wird beispielsweise mit folgendem Befehlen gebaut:

    make raspmatic_rpi2

**TODO**

Je nach Rechnerleistung bewegt sich die Build-Dauer zwischen einer und mehreren Stunden. Eine SSD hilft viel. Das fertige Image ist dann im Container unter `/rmbuild/RaspberryMatic/build-raspmatic_rpi3/images/sdcard.img` zu finden.

Das SD-Karten-Image kann auf den lokalen Rechner kopiert werden, wenn zusätzlich ein lokales Verzeichnis eingehängt wird. Im folgenden Beispiel wird der Container kurz gestartet um `cp` auszuführen, das die Datei nach `/home/Mathias` (im Container) bzw. `/c/Users/Mathias` (auf dem lokalen Rechner) kopiert:

    docker run -it --rm -v rmbuild:/rmbuild -v /c/Users/Mathias:/home/Mathias mdzio/rm-build-env cp /rmbuild/RaspberryMatic/build-raspmatic_rpi3/images/sdcard.img /home/Mathias

---
### Erstellen des Docker-Images

Die Quellen zum Erstellen des Docker-Images sind auf [GitHub](https://github.com/mdzio/rm-build-env) zu finden. In das Verzeichnis der Datei `Dockerfile` wechseln und dann folgenden Befehl ausführen: 

    docker build -t rm-build-env .

