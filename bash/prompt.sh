#!/bin/bash

# Funktion zum dynamischen generieren des git status für den Prompt.
# In der PS1 mit $(git_prompt) einbauen.

git_prompt() {
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
	
	printf "\033[35m\033[0;45m  ${branch} ${status} \033[0m\033[35m\033[0m"
}

# Bestimmte Ordner durch Icons ersetzen.
dir_icon() {
    case "$PWD" in
        "$HOME") echo "" ;;                          # Home
        "$HOME/dotfiles"*) echo "" ;;                # Dotfiles
        "$HOME/projects"*) echo "󰲋" ;;               # Projekte
        "$HOME/storage"*) echo "󰉋" ;;                # Storage
        *) echo "~${PWD#$HOME}" ;;                 # Default
    esac
}

update_prompt() {

	sym=""
	cr_sym="36"
	cr_bar="34"
	cr_name="37"
	cr_end="37"
	cr_dir="36"

	PS1='\[\033[0;${cr_bar}m\]┌──(\[\033[1;${cr_name}m\]${user_name} \[\033[0;${cr_sym}m\]${sym} \[\033[1;${cr_name}m\]Hackdroid\[\033[0;${cr_bar}m\])-[\[\033[0;${cr_dir}m\] $(dir_icon) \[\033[0;${cr_bar}m\]] $(git_prompt)
\[\033[0;${cr_bar}m\]└─\[\033[1;${cr_end}m\]\$\[\033[0m\] '
}

PROMPT_COMMAND=update_prompt
