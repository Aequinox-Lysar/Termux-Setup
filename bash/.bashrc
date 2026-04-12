#### Global Variables ####

# User name
user_name="daniel"

# Default Editor
editor="nvim"

#### Environment variables ####

# `grep default` higlight color
export GREP_COLOR="1;32"

# Colored man
export MANPAGER="less -R --use-color -Dd+g -Du+b"

# EDITOR
export EDITOR=$editor
export SUDO_EDITOR=$editor
export VISUAL="nvim"

# USER
export USER=$user_name

# PATH
export ETC="/data/data/com.termux/files/usr/etc"

### History settings ####

# append to the history file, don't overwrite it
shopt -s histappend

# load results of history substitution into the readline editing buffer
shopt -s histverify

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in badh(1)
HISTSIZE=1000
HISTFILESIZE=2000


#### Autocompletion ####

# cycle through all matches with 'TAB' key
bind 'TAB:menu-complete'

# necessary for programmable completion
shopt -s extglob

# cd when entering just a path
shopt -s autocd

#### Prompt #####
shopt -s extglob

# cd when entering just a path
shopt -s autocd


#### Mein  Prompt ####

# Nur für interaktive Shell
[[ $- != *i* ]] && return

# Eigenen Prompt einbinden
[ -f ~/.config/bash/prompt.sh ] && source ~/.config/bash/prompt.sh


#### Aliases #####

# enable color support of ls, grep, and ip, also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls -A --color=auto'
	alias grep='grep --color=auto'
	alias diff='diff --color=auto'
	alias ip='ip -color'
fi

# go back to the previous directory when entering '--'
--(){
  cd -
}

# common commands
alias ll='ls -lFh'
alias la='ls -alFh --group-directories-first'
alias free='free -mt'
alias cputemp='sensors | grep Core'
alias fastfetch='fastfetch --logo "arch"'

# Single Fastfetch on Startup
#if [ -z "$FASTFETCH_SHOWN" ] && [ -z "$TMUX" ]; then
#	fastfetch
#	export FASTFETCH_SHOWN=1
#fi

# Autostart für  TMUX
if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
	if [ -t 0 ]; then
		if tmux has-session -t default 2>/dev/null; then
			tmux attach-session -t default
		else
			tmux new-session -s default
		fi
	fi
fi
