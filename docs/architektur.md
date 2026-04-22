# Wie ich MEIN SYSTEM gebaut habe und warum.

## Eigener Prompt Renderer (prompt.sh)

**Ziel:**
Einen eigenen voll dynamischen Prompt zu generieren welcher voll und ganz unter meiner Kontrolle steht.

**Technik:**
- Bash Skript
- ANSI Cursor Bewegung

**Dateien:**
- dotfiles/bash/prompt.sh

**Features:**
- Basismodul welches Username und Hostname mit einem Trennsymbol anzeigt.
- Taskwarriorintegration zeigt die Anzahl der Tasks an. Nur sichtbar wenn Tasks existieren.
- Pfadmodul zeigt den aktuellen Pfad an. Bestimmte Pfade können durch Symbole ersetzt werden.
- Gitmodul wird angezeigt sobald in ein Git-Ordner navigiert wird und zeigt den aktuellen Status mittels Symbolen an.
- Auf der rechten Seite wird ein Zusatzmodul angezeigt sobald ein Task gestartet wird. Dieses zeigt den aktiven Task an.

**Hinweis:**
Es ist nur ein aktiver Task vorgesehen und nur dieser wird im rechten Teil des Prompts angezeigt.

## Taskmanagement mit Taskwarrior
## Dokument Pipeline
## Skripte

[Zurück](../README.md)
