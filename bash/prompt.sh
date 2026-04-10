#!/bin/bash

# Mein eigenes Framework zur dynamischen Generierung meiner PS1
# vollständig in Bash

# ################################################
#	GLOBALE VARIABLEN
# ###############################################

HAS_GIT=0
HAS_TASKS=0
RESET="\033[0m"

# ################################################
#	FARBEN (256 FARBEN MODUS)				
# ###############################################

BLACK=0
MAGENTA=5
WHITE=7
CYAN=14
BLUE=69
PURPLE=92
GREY=240

# ################################################
#	HILFSFUNKTIONEN				
# ###############################################

fg() {
	printf "\033[38;5;%sm" "$1"
}

bg() {
	printf "\033[48;5;%sm" "$1"
}

render_segment() {
	local fg_color=$1
	local bg_color=$2
	local text=$3
	
	printf "%s%s%s" \
	"$(fg "$fg_color")" \
	"$(bg "$bg_color")" \
	"$text"

	CURRENT_BG=$bg
}

render_seperator() {
	local sym=$1
	CURRENT_BG=$2
	printf "\033[38;5;%sm$sym" "$CURRENT_BG"
}

reset_module() {
	MODULE_FG=""
	MODULE_BG=""
	MODULE_TEXT=""
	MODULE_SEPERATOR_F=""
	MODULE_SEPERATOR_B=""
}

# ################################################
#	MODUL INTRO
#	INFO: Hier wird der Anfang des Prompts
#	bis zum ersten Seperator definiert.
# ###############################################

module_start() {

	local SYM="\033[38;5;46m"
	MODULE_FG=$WHITE
	MODULE_BG=$BLUE
	MODULE_TEXT=" ${user_name} ${SYM} \033[38;5;7mHackdroid "
	MODULE_SEPERATOR_F="┌──"
	MODULE_SEPERATOR_B=""

}

# ################################################ 
#	MODUL TASKWARRIOR
#	INFO: Dieses Modul wird angezeigt sobald
#	Taskwarrior Tasks enthält.
# ###############################################

module_taskwarrior() {

	TASK_COUNT=$(task +PENDING count 2>/dev/null)
	
	if [[ $TASK_COUNT -gt 0 ]]; then
		HAS_TASKS=1
	fi

	MODULE_FG=$WHITE
	MODULE_BG=57
	MODULE_TEXT="  $TASK_COUNT"
	MODULE_SEPERATOR_F=""
	MODULE_SEPERATOR_B=""
}

# ################################################ 
#	MODUL PFADINFO
#	INFO: Hier wird der aktuelle Pfad durch
#	Icons ersetzt, oder als verkürzter Pfad
#	angegeben.
# ###############################################

# Bestimmte Ordner durch Icons ersetzen.
dir_path() {
    case "$PWD" in
        "$HOME") echo "" ;;			# Home
        "$HOME/dotfiles"*) echo "" ;;		# Dotfiles
        "$HOME/storage"*) echo "󱊟" ;;		# Storage
	"$HOME/Dokumente"*) echo "󰈙" ;;		# Dokumente
        *) echo "~${PWD#$HOME}" ;;		# Default
    esac
}

module_path() {
	MODULE_FG=$WHITE
	MODULE_BG=$PURPLE
	MODULE_TEXT=" $(dir_path) "
	MODULE_SEPERATOR_F=""
	MODULE_SEPERATOR_B=""
}

# ################################################
#	MODUL GIT
#	INFO: Zeigt aktuellen Branch sowie seinen
#	Status mittels Icons.
# ###############################################

module_git() {
	
	git rev-parse --is-inside-work-tree &>/dev/null || return

	branch=$(git branch --show-current 2>/dev/null)
	status=""

	# Änderungen vorhanden?
	if ! git diff --quiet 2>/dev/null; then
		status+="󱇧"
	fi

	# Staged changes?
	if ! git diff --cached --quiet 2>/dev/null; then
		status+="󱓎"
	fi

	# Ahead / behind
	ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
	behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

	[ "$ahead" -gt 0 ] 2>/dev/null && status+=""
	[ "$behind" -gt 0 ] 2>/dev/null && status+=""
	
	HAS_GIT=1
	MODULE_FG=$WHITE
	MODULE_BG=$MAGENTA
	MODULE_TEXT="  ${branch} ${status} "
	MODULE_SEPERATOR_F=""
	MODULE_SEPERATOR_B=""
}

# ################################################
#	MODUL ENDE
#	INFO: Hier wird der Abschluss des Prompts
#	definiert. Der Teil wir in der zweiten
#	Zeile angezeigt.
# ###############################################

module_end() {
	MODULE_FG="$BLUE"
	MODULE_BG="$BLACK"
	MODULE_TEXT="└─ "
}

# ################################################
#	PROMPT ZUSAMMENBAUEN
#	INFO: Hier wird der ganz Klumpatsch,
#	welcher definiert wurde, zusammengesetzt
#	und final in die PS1 geschrieben.
# ###############################################

build_prompt() {
	
	# Reset Status
	HAS_GIT=0
	HAS_TASKS=0
	module_git
	module_taskwarrior
	reset_module
	CURRENT_BG=""	
	local PROMPT=""
	
	# Startmodul
	module_start
	if [[ -n $MODULE_SEPERATOR_F ]]; then
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_F" "$MODULE_BG")"
	fi
	if [[ -n $MODULE_TEXT ]]; then
		PROMPT+="$(render_segment "$MODULE_FG" "$MODULE_BG" "$MODULE_TEXT")"
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_B" "$MODULE_BG")"
	fi
	reset_module

	# Taskwarrior
	module_taskwarrior
	if [[ $HAS_TASKS -eq 1 ]]; then
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_F" "$MODULE_BG")"
		PROMPT+="$(render_segment "$MODULE_FG" "$MODULE_BG" "$MODULE_TEXT")"
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_B" "$MODULE_BG")"
	fi
	reset_module

	# Pfadmodul
	module_path
	
	if [[ -n $MODULE_SEPERATOR_F ]]; then
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_F" "$MODULE_BG")"
	fi

	if [[ -n $MODULE_TEXT ]]; then
		PROMPT+="$(render_segment "$MODULE_FG" "$MODULE_BG" "$MODULE_TEXT")"
		
	fi
	if [[ $HAS_GIT -eq 0 ]]; then
		MODULE_SEPERATOR_B=""
		PROMPT+="$RESET"
	fi

	PROMPT+="$(render_seperator "$MODULE_SEPERATOR_B" "$MODULE_BG")"
	reset_module

	# Gitmodul
	module_git	
	if [[ -n $MODULE_SEPERATOR_F ]]; then
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_F" "$MODULE_BG")"
	fi
	if [[ -n $MODULE_TEXT ]]; then
		PROMPT+="$(render_segment "$MODULE_FG" "$MODULE_BG" "$MODULE_TEXT")"
		PROMPT+="$RESET"
		PROMPT+="$(render_seperator "$MODULE_SEPERATOR_B" "$MODULE_BG")"
	fi
	reset_module

	PROMPT+="\n"

	# Endmodul für die zweite Zeile
	module_end
	PROMPT+="$(render_segment "$MODULE_FG" "$MODULE_BG" "$MODULE_TEXT")"
	reset_module
	
	PROMPT+="$RESET"
	
	PS1="$PROMPT"

	
}

# ################################################
#	TRIGGER	
#	INFO: Dies ist das Ereignis an dem der
#	Prompt neu erstellt und gerendert wird.
# ###############################################

PROMPT_COMMAND=build_prompt

# ######### ENDE DES SKRIPTES ##########
