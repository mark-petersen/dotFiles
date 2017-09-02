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


