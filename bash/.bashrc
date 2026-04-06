#### Global Variables ####

# User name
user_name="neo"

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

#### Prompt ###########################

sym="㉿"      # symbol of prompt
bar_cr="34"   # color of bars
name_cr="37"  # color of user & host
end_cr="37"   # color of prompt end
dir_cr="36"   # color of current directory

PS1='\[\033[0;${bar_cr}m\]┌──(\[\033[1;${name_cr}m\]${user_name} ${sym} Hackdroid\[\033[0;${bar_cr}m\])-[\[\033[0;${dir_cr}m\]\w\[\033[0;${bar_cr}m\]]
\[\033[0;${bar_cr}m\]└─\[\033[1;${end_cr}m\]\$\[\033[0m\] '

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

# Fastfetch in startup
fastfetch
