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
export GREP_COLOR="1;31"

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

export LS_COLORS='no=00;37:fi=00;37:di=01;36:ln=04;36:pi=33:so=01;35:do=01;35:bd=33;01:cd=33;01:or=31;01:su=37:sg=30:tw=30:ow=34:st=37:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.btm=01;31:*.sh=01;31:*.run=01;31:*.tar=33:*.tgz=33:*.arj=33:*.taz=33:*.lzh=33:*.zip=33:*.z=33:*.Z=33:*.gz=33:*.bz2=33:*.deb=33:*.rpm=33:*.jar=33:*.rar=33:*.jpg=32:*.jpeg=32:*.gif=32:*.bmp=32:*.pbm=32:*.pgm=32:*.ppm=32:*.tga=32:*.xbm=32:*.xpm=32:*.tif=32:*.tiff=32:*.png=32:*.mov=34:*.mpg=34:*.mpeg=34:*.avi=34:*.fli=34:*.flv=34:*.3gp=34:*.mp4=34:*.divx=34:*.gl=32:*.dl=32:*.xcf=32:*.xwd=32:*.flac=35:*.mp3=35:*.mpc=35:*.ogg=35:*.wav=35:*.m3u=35:';

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

alias gha='git log --graph --date=relative --all --topo-order --pretty=format:'\''%C(cyan)[%an]%Creset %C(green bold)%d%Creset %C(yellow)%h%Creset : %s %C(cyan)[%ad]%Creset'\'''

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
