#!/bin/bash
case $(date +%u) in
	1) echo "Montag" ;;
	2) echo "Dienstag" ;;
	3) echo "Mittwoch" ;;
	4) echo "Donnerstag" ;;
	5) echo "Freitag" ;;
	6) echo "Samstag" ;;
	7) echo "Sonntag" ;;
esac
