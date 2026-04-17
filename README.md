# Reproduzierbares Termux Setup

Dieses Projekt soll zum einen mein Termux Setup sichern und einfach reproduzierbar machen.
Meine Setup.sh übernimmt Setup und Pflege des Systems während des Betriebs.
Das Script erwartet den dotfiles Ordner unter Home.

## Features

>[!done] Dynamischer Prompt in Bash
>
> - Module:
>   - User- und Hostname
>   - Taskwarrior zeigt die Anzahl der offenen Tasks.
>   - Aktiver Task wird auf der rechten Seite des Prompts angezeigt.
>   - Pfadmodul inkl. Iconersetzung für festgelegte Pfade.
>   - Gitmodul welches erscheint sobald man in einen Gitprojektordner navigiert.

- Tmux Statusleiste an Prompt angepasst.
- Tmux Autostart beim öffnen von Termux.
- Setup Skript zur komfortablen Pflege und Setup bei Neugeräten.

# Versionen

v0.1 - erstes stabil funktionierendes System
v0.2 - Pandoc und Latexengine funktionieren
v0.3 - Protokoll Workflow steht
v0.4 - Setup komfortabel reproduzierbar
v0.5 - Eigene dynamische Promptengine läuft ohne Fehler
v0.6 - System geht als Daily Driver in die Alltagsnutzung
