#!/bin/bash

# Framework zur dynamischen Generierung meiner PS1

# ################################################
#	Globale Variablen
# ###############################################

HAS_GIT=0

# ################################################
#	Farben (256 Farben Modus)				
# ###############################################

BLACK=0
MAGENTA=5
WHITE=7
CYAN=14
BLUE=69
PURPLE=92
GREY=240

RESET="\033[0m"

# ################################################
#	Hilfsfunktionen				
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
#	Modul Intro	
# ###############################################

module_start() {

	local SYM=""
	MODULE_FG=$WHITE
	MODULE_BG=$BLUE
	MODULE_TEXT=" ${user_name} ${SYM} Hackdroid "
	MODULE_SEPERATOR_F="┌──"
	MODULE_SEPERATOR_B=""

}


# ################################################ 
#	Modul Pfadinfo		
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
#	Modul Git		
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
#	Modul Ende		
# ###############################################

module_end() {
	MODULE_FG="$BLUE"
	MODULE_BG="$BLACK"
	MODULE_TEXT="└─ "
}
# ################################################
#	Prompt zusammenbauen		
# ###############################################

build_prompt() {
	
	# Reset Status
	HAS_GIT=0
	module_git
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
#	Trigger			
# ###############################################

PROMPT_COMMAND=build_prompt
