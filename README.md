# Reproduzierbares Termux Setup
Dieses Projekt soll zum einen mein Termux Setup sichern und einfach reproduzierbar machen.

## Wichtige Befehle
- Paketliste erstellen --> `pkg list-installed | tail -n +2 | cut -d/ -f1 | sort > ~/dotfiles/packages.txt`
