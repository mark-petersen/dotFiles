# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\(__git_ps1 " (%s)")$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export SVN_EDITOR="/usr/bin/vim"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export BASHRC_SOURCED=yes

if [ -f ~/.bash_profile ]; then
    if [ -z ${BASH_PROFILE_SOURCED} ]; then
        source ~/.bash_profile
    fi
fi

#homebrew token
export HOMEBREW_GITHUB_API_TOKEN=`cat ~/.github_token`

# enable ctrl+s to not stop terminal so it can do ctrl+r forward / ctrl+s back searches
stty -ixon

source ~/scripts/setup_module.sh
source ~/scripts/find_host.sh
source ~/scripts/set_proxy_info.sh

### From Mark, added to Phillip's bash file, 170709:

# command line
export PS1='\W$ '
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Add to path:
export PATH=${PATH}:.

# User specific aliases and functions
alias rm='rm -i'
alias matlabline='matlab -r -nosplash -nodisplay -nojvm'
alias lsdir="ls -l | grep '^d'"
#alias suntansconvert="hexdump -v -e '4/8 \"%15E \"' -e '\"\n\"'"
alias codecount="ls *.[c-h] | xargs wc "
alias doxygencommentsready="ls *.[c-h] | xargs sed -i 's/\/\*/\/\*\*/g'"
alias cleandoxygencommentsready="ls *.[c-h] | xargs sed -i 's/\/\*\+/\/\*\*/g'"
alias vi='vim'

# git aliases
alias gco='git co'
alias gci='git ci'
alias grb='git rb'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=always -GFh'
    alias less='less -R'
    alias dir='dir --color=always'
    alias vdir='vdir --color=always'

    alias cgrep='grep --color=always -n'
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias cack='ack --color'
alias cack_ocean='ack --color --ignore-dir=src/core_atmosphere/ --ignore-dir=src/core_init_atmosphere/ --ignore-dir=src/core_landice/ --ignore-dir=src/core_sw/ --ignore-dir=DoxygenDocumentation'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# mac os x trash alias (doesn't quite work properly because the "put back" functionality is gone)
#alias trash='function _trash(){ echo "Trashing $1..."; mv $1 ~/.Trash; echo "Done";};_trash'

# rsync to act like scp
alias rsync-scp='rsync -avzP'

# lanl ICC
alias sshMustang='ssh -t -X wtrw1.lanl.gov ssh mu-fe.lanl.gov'

alias julia='/Applications/Julia-0.3.1.app/Contents/Resources/julia/bin/julia'
alias ijulia="ipython notebook --profile julia"

alias objcopy="/usr/local/Cellar/binutils/2.24/bin/gobjcopy"
alias objdump="/usr/local/Cellar/binutils/2.24/bin/gobjdump"

alias dropboxwork="HOME=$HOME/Dropbox-work /Applications/Dropbox.app/Contents/MacOS/Dropbox &"
 
### From Mark, added to Phillip's bash aliases, 170709:

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


