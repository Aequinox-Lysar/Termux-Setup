#!/bin/bash

setup_dotfiles() {
	echo "Updating Termux..."
	pkg update -y
	pkg upgrade -y

	echo "Benötigte Pakete werden installiert..."
	xargs pkg install -y < packages.txt

	echo "Erstelle Symlinks..."
	ln -s ~/dotfiles/bash/.bashrc ~/.bashrc
	ln -s ~/dotfiles/nvim ~/.config/nvim
	ln -s ~/dotfiles/tmux ~/.config/tmux
	ln -s ~/dotfiles/.termux ~/.termux
	ln -s ~/dotfiles/tasks/.taskrc ~/.taskrc

	# Datei zum Unterdrücken der "Welcome" Nachricht beim Start
	touch ~/.hushlogin

	echo "Lade Termux Einstellungen..."
	termux-reload-settings

	echo "Setup abgeschlossen."
}

generate_package_list() {
	echo "Die Liste der aktuell installierten Pakete wird erstellt..."
	pkg list-installed | tail -n +2 | cut -d/ -f1 | sort > ~/dotfiles/packages.txt
	echo "Paketliste erstellt: ~/dotfiles/packages.txt"
	echo "Die Liste enthält aktuell $(wc -l < ~/dotfiles/packages.txt) Pakete."
}

system_update(){
	apt update -y
	apt upgrade -y
}
	
# Simples Menü um Funktionen auszuwählen.
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
