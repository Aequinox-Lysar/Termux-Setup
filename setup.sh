#!/bin/bash

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

# Datei zum Unterdrücken der "Welcome" Nachricht beim Start
touch ~/.hushlogin

echo "Lade Termux Einstellungen..."
termux-reload-settings

echo "Setup abgeschlossen."
