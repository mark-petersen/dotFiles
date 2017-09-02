# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export SVN_EDITOR="/usr/bin/vim"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export BASHRC_SOURCED=yes

# command line
export PS1='\W$ '
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# practice without this:
# export PATH=${PATH}:.

# Aliases 

# git aliases
alias gitlp='git log --graph --oneline -n 12'

# this should go to the scratch on every machine
alias csh='csh -f'
alias r='cd /Users/mpeterse/runs; pwd'
alias sc='cd /local1/mpetersen/; pwd; ls'
alias scr='cd /local1/mpetersen/runs; pwd'
alias nsc='cd /local1/mpetersen/; pwd; ls'
set t='/local/mpetersen/trash'
set hostname=`hostname -s`

# unix aliases
alias ex='exit'
alias dir='ls -tlFhG | head'
alias h='history'
alias m='less'
alias cdd='cd \!*; ls'
alias home='cd /home/mpeterse; pwd; ls'
alias space='du -k | sort -n'
alias ls='ls -G'
alias grep='grep -d skip --color=always'

alias python='/Users/mpeterse/anaconda/bin/python'
alias ipython='/Users/mpeterse/anaconda/bin/ipython'

# login aliases: turqoise network
alias ccs='ssh mpeterse@ccscs8.lanl.gov'
alias wf='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@wf-fe'
alias gr='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@gr-fe'
alias ed='ssh -Y edison.nersc.gov'
alias darwin='ssh darwin-fe.lanl.gov'
alias cori='ssh -Y cori.nersc.gov'
alias ted='scp edison.nersc.gov:a/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias toed='scp ~/a/tar.tar edison.nersc.gov:a/tar.tar'
alias git='/usr/local/git/bin/git'
alias gpfs='ssh -tX mpeterse@wtrw.lanl.gov ssh ar-tn'
alias eos='ssh mpetersen@eos.ccs.ornl.gov'
alias rhea='ssh mpetersen@rhea.ccs.ornl.gov'
alias titan='ssh mpetersen@titan.ccs.ornl.gov'
alias ttitan='scp mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli115/proj-shared/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias theta='ssh theta.alcf.anl.gov'

# taring aliases
alias t=' echo "tarring the following files to ~/a/tar.tar"; tar cvf ~/a/tar.tar'
alias unt='echo "** Untarring from ~/a/tar.tar"; tar xvf ~/a/tar.tar'
alias tt='scp mpeterse@wtrw.lanl.gov:mpeterse@wf-fe2.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar'
alias tot=' echo "sending ~/a/tar.tar to turqoise"; scp ~/a/tar.tar mpeterse@wtrw.lanl.gov:mpeterse@wf-fe1.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar;'
alias toccs='scp ~/a/tar.tar mpeterse@ccscs8:/home/mpeterse/a'
alias tccs='scp mpeterse@ccscs8.lanl.gov:/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'

# alias to change directory
alias c='rm -f ~/a/pwd_file; set d=`pwd`; echo `pwd` > ~/a/pwd_file; echo "put pwd in a/pwd_file:";pwd'
alias d='set d=`cat ~/a/pwd_file`; cd $d; echo "cd to"; pwd'


