#!/bin/bash

# Farbvariablen und Styling für bessere Ausgabe
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# Nachrichtenfunktion
msg_ok() {
	echo -e "${BOLD}${GREEN}[] $1${RESET}";
}  

setup_dotfiles() {
	echo "Updating Termux..."
	pkg update -y
	pkg upgrade -y

	echo "Benötigte Pakete werden installiert..."
	xargs pkg install -y < packages.txt

	echo "Erstelle Symlinks..."
	ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
	ln -s ~/dotfiles/bash ~/.config/bash
	ln -s ~/dotfiles/nvim ~/.config/nvim
	ln -s ~/dotfiles/tmux ~/.config/tmux
	ln -s ~/dotfiles/.termux ~/.termux
	ln -s ~/dotfiles/tasks/.taskrc ~/.taskrc

	# Datei zum Unterdrücken der "Welcome" Nachricht beim Start
	touch ~/.hushlogin

	echo "Lade Termux Einstellungen..."
	termux-reload-settings

	msg_ok "Setup erfolgreich abgeschlossen."
}

generate_package_list() {
	echo "Die Liste der aktuell installierten Pakete wird erstellt..."
	pkg list-installed | tail -n +2 | cut -d/ -f1 | sort > ~/dotfiles/packages.txt
	msg_ok "Paketliste erstellt: ~/dotfiles/packages.txt"
	msg_ok "Die Liste enthält aktuell $(wc -l < ~/dotfiles/packages.txt) Pakete."
}

system_update(){
	apt update -y
	apt upgrade -y
	msg_ok "Termux wurde erfolgreich aktualisiert."
}
	
# Simples Menü um Funktionen auszuwählen.
echo -e "${BOLD}${BLUE}================================${RESET}"
echo -e "${BOLD}${BLUE}         HACKDROID SETUP        ${RESET}"
echo -e "${BOLD}${BLUE}================================${RESET}\n"

echo "Was willst du tun?"
select option in "Setup Dotfiles + Pakete" "Paketliste erstellen" "Termux aktualisieren" "Beenden"; do
	case $REPLY in
		1) setup_dotfiles ;;
		2) generate_package_list ;;
		3) system_update ;;
		4) exit ;;
		*) echo "Ungültige Auswahl";;
	esac
done
