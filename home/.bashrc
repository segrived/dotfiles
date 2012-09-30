#!/bin/bash

[[ $- != *i* ]] && return

ulimit -S -c 0
set -o notify
shopt -s cdspell dirspell
shopt -s checkhash checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s cdable_vars
shopt -s extglob
shopt -s failglob
shopt -s globstar
shopt -s nocaseglob
 
DEFAULT_EDITOR='vim';
export VISUAL=$DEFAULT_EDITOR
export EDITOR=$DEFAULT_EDITOR
export FCEDIT=$DEFAULT_EDITOR

export GREP_OPTIONS='--color=auto'

# Цвета для man-страниц
export PAGER='less'
export LESS_TERMCAP_mb=$'\033[01;36m'
export LESS_TERMCAP_md=$'\033[01;32m'
export LESS_TERMCAP_me=$'\033[0m'
export LESS_TERMCAP_mu=$'\033[01;37m'
export LESS_TERMCAP_se=$'\033[0m'
export LESS_TERMCAP_so=$'\033[01;44;33m'
export LESS_TERMCAP_ue=$'\033[0m'
export LESS_TERMCAP_us=$'\033[01;36m'

export BROWSER='firefox -new-tab'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'

HISTCONTROL=erasedups
HISTSIZE=200

complete -cf killall
complete -cf man
complete -cf pgrep
complete -cf sudo

if [ "x$TERM" = "xxterm" ]; then
    export TERM="xterm-256color"
fi;

PS1='\[\033[01;32m\]\u\[\033[01;33m\] \w \$\[\033[00m\] '

SUDO_COMMANDS=(pacman yaourt systemctl journalctl netcfg suspend poweroff reboot)
for command in ${SUDO_COMMANDS[@]}; do
    eval "alias $command='sudo $command'";
done

alias ls='ls --color=auto'
alias du='du -h'
alias df='df -h'
alias tree='tree -Chs'
alias vi='vim'
alias vim='vim -p'
alias gvim='gvim -p'
alias mkdir='mkdir -p'
alias cls='clear'
alias ..='cd ..'

alias schmod='sudo chmod'
alias schown='sudo chown'

alias sysupgrade='yaourt -Syyua'
alias pkginstall='yaourt -Sy $@'
alias pkgremove='yaourt -Rs $1'
alias pkgsearch='yaourt -Ss $1'
alias pkgcount='pacman -Q | wc -l'
alias pkgfiles='pacman -Ql $1'

alias dec='printf "%d\n" $1'
alias hex='printf "0x%08x\n" $1'

function mkcd() { mkdir "$1"; cd "$1"; }
function have() { type "$1" &> /dev/null; }

# ---------- FUNCTIONS ---------- #
function ghclone() {
    local dest_dir
    [[ -z $3 ]] && dest_dir=$2 || dest_dir=$3
    git clone git://github.com/$1/$2.git $dest_dir
}

function env-update() {
    source ~/.bashrc
    xrdb -retain ~/.Xresources
    openbox --reconfigure
}

function swap() {
    local tmpfile=tmp.$$
    mv "$1" $tmpfile
    mv "$2" "$1"
    mv $tmpfile "$2"
}

function ask() {
    echo -n "$@" '[y/N] ' ;
    read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

# Дата при запуске терминала
echo -e "\e[01;36m$(date)\e[00m"
