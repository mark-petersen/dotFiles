# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's exportting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for exportting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export SVN_EDITOR="/usr/bin/vim"
export LESS="$LESS -FRXK" 
export OMP_NUM_THREADS=1

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export BASHRC_SOURCED=yes

# command line
PS1='\[\e[1;32m\]\h:\W\$\[\e[0m\] ' # bright green
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Settings specific to individual machines:
HOST=`hostname -s`

# Default, unless replaced below: 
umask 022
alias ls='ls --color'
alias lsgraph='ls -l *part.??; ls -l *part.???; ls -l *part.????; ls -l *part.?????'
export TARFILE="~/a/tar.tar"
export HOMEDIR=~

### Local laptops
if [[ $HOST = pn* ]]; then
  echo 'mac hostname: ' $HOST
  PS1='\W$ '
  alias ls='ls -G'
  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

  alias r='echo "cd /Users/mpeterse/runs";cd /Users/mpeterse/runs'
  alias octave='/usr/local/octave/3.8.0/bin/octave-3.8.0'

### LANL local unix box
elif [[ $HOST = forest* ]]; then
  echo 'forest hostname: ' $HOST
  PS1='\W$ '

### LANL ccs servers
elif [[ $HOST = ccs* ]]; then
  echo 'ccs hostname: ' $HOST
  PS1='\[\e[1;31m\]\h:\W\$\[\e[0m\] ' # red
  alias sc='echo "cd /scratch/mpeterse";cd /scratch/mpeterse; pwd'
  alias r='echo "cd /scratch/mpeterse";cd /scratch/mpeterse; pwd'

### LANL turquoise IC: grizzly and wolf
elif [[ $HOST = gr* ]] || [[ $HOST = wf* ]]; then
  echo 'IC hostname: ' $HOST
  PS1='\[\e[1;32m\]\h:\W\$\[\e[0m\] ' # bright green
  export HOMEDIR=/usr/projects/climate/mpeterse
  export QUEUETYPE=slurm
  alias ml='module purge; echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio"; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/; module load python/anaconda-2.7-climate; module load intel/15.0.5 openmpi/1.6.5 netcdf/4.4.0 parallel-netcdf/1.5.0 pio/1.7.2; module load git'
  alias mlg='module purge; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio"; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/; module load python/anaconda-2.7-climate; module load gcc/4.8.2 openmpi/1.6.5 netcdf/4.4.0 parallel-netcdf/1.5.0 pio/1.7.2; module load git'
  alias mlgr='module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mlgri='module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load intel/17.0.1 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias r='cd /lustre/scratch3/turquoise/mpeterse/runs; pwd'
  alias r2='cd /lustre/scratch2/turquoise/mpeterse/runs; pwd'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/real_bathymetry_uniform/; pwd'
  # add from mlgr for default
  module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; 
  echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"
  
  ### acme section ###
  export RUN_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/cases
  export ARCHIVE_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/archive
  alias in='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data; pwd; ls'
  alias inu='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data_for_uploading/acme/inputdata; pwd; ls'
  TARFILE="/lustre/scratch3/turquoise/mpeterse/trash/tar.tar"

  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

### LANL yellow IC: snow
elif [[ $HOST = sn* ]]; then
  echo 'IC hostname: ' $HOST
  PS1='\[\e[1;33m\]\h:\W\$\[\e[0m\] ' # yellow
  export HOMEDIR=/users/mpeterse
  export QUEUETYPE=slurm
  alias ml='module purge; module load git; module use /users/mpeterse/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mli='module purge; module load git; module use /users/mpeterse/modulefiles/all/;module load python/anaconda-2.7-climate;module load intel/17.0.1 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias r='cd /lustre/scratch3/turquoise/mpeterse/runs; pwd'
  alias r2='cd /lustre/scratch2/turquoise/mpeterse/runs; pwd'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/real_bathymetry_uniform/; pwd'
  # add from mlgr for default
  # from turquoise module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; 
  #echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"
  
  ### acme section ###
  export RUN_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/cases
  export ARCHIVE_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/archive
  alias in='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data; pwd; ls'
  alias inu='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data_for_uploading/acme/inputdata; pwd; ls'
  TARFILE="/lustre/scratch3/turquoise/mpeterse/trash/tar.tar"

  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

### NERSC: edison and cori
elif [[ $HOST = ed* ]] || [[ $HOST = cori* ]] || [[ $HOST = nid* ]]; then
  echo 'NERSC hostname: ' $HOST
  export QUEUETYPE=slurm
  PS1='\[\e[1;36m\]\h:\W\$\[\e[0m\] ' # bright blue

  module load nco
  module load git
  alias r='cd $SCRATCH/runs; pwd'
  alias cs='cd $CSCRATCH/runs; pwd'
  alias inu='cd /global/cscratch1/sd/mpeterse/acme_scratch/input_data_for_upload_171113/acme/inputdata; pwd; ls'
  alias in='cd /project/projectdirs/acme/inputdata/ocn/mpas-o; pwd; ls'
  export RUN_ROOT=/global/cscratch1/sd/mpeterse/acme_scratch/cori-knl
  export ARCHIVE_ROOT=/scratch1/scratchdirs/mpeterse/ACME/archive

### Argonne: theta
elif [[ $HOST = theta* ]]; then
  echo 'theta hostname: ' $HOST
  rkcbeg DHRHRGLCR=cof
  PS1='\[\e[1;34m\]\h:\W\$\[\e[0m\] ' # blue

  module load hsi
  module load cray-netcdf
  export RUN_ROOT=/projects/OceanClimate/mpeterse
  alias in='cd /projects/OceanClimate/acme/inputdata; pwd; ls'
  alias r='cd $RUN_ROOT/runs; pwd'

### Oak Ridge: titan and EOS
elif [[ $HOST = titan* ]] || [[ $HOST = eos* ]] || [[ $HOST = rhea* ]]; then
  echo 'Oak Ridge hostname: ' $HOST
  export QUEUETYPE=pbs
  PS1='\[\e[1;33m\]\h:\W\$\[\e[0m\] ' # yellow
  export RUN_ROOT=/lustre/atlas/scratch/mpetersen/cli127
  alias inu='cd /ccs/home/mpetersen/input_data_for_uploading; pwd; ls'
  TARFILE="/lustre/atlas1/cli127/proj-shared/mpetersen/trash/tar.tar"
  module load git
  module load python

### Oak Ridge: anvil and blues
elif [[ $HOST = anvil* ]] || [[ $HOST = blogin* ]]; then
  echo 'Argonne hostname: ' $HOST
  export QUEUETYPE=pbs
  PS1='\[\e[1;35m\]\h:\W\$\[\e[0m\] ' # maroon
  export RUN_ROOT=/lcrc/group/acme/mpeterse/acme_scratch/
fi


if [[ $QUEUETYPE = slurm ]]; then
  alias j='echo "slurm: squeue -u mpeterse"; squeue -u mpeterse'
  alias ja='echo "slurm: squeue"; squeue'
  alias canceljob='echo "slurm: scancel"; scancel '
  alias llogin='echo "slurm: salloc --qos=interactive -t 4:0:0 -N 1"; salloc --qos=interactive -t 4:0:0 -N 1'
  # for cori: salloc --partition=debug --nodes=32 --time=30:00 -C knl
  alias partitions='echo "slurm: sinfo |cut -c 1-100"; sinfo |cut -c 1-100'
elif [[ $QUEUETYPE = pbs ]]; then
  export QSTAT_HEADER=JobId:JobName:User:WallTime:RunTime:Nodes:Mode:State:Queue:Score
  alias j='echo "pbs: qstat -u mpeterse(n)"; qstat -u mpeterse; qstat -u mpetersen'
  alias ja='echo "pbs: qstat"; qstat |cut -c1-100'
  alias canceljob='echo "pbs: qdel"; qdel '
  alias llogin='echo "pbs: qsub -I -t 1:00:00 -n 1 -q debug-flat-quad"; qsub -I -t 1:00:00 -n 1 -q debug-flat-quad'
  alias partitions='echo "pbs: qstat -Q"; qstat -Q'
fi

export PATH="$HOMEDIR/software/anaconda2/bin:$PATH"
# practice without this:
# export PATH=${PATH}:.

alias home='cd $HOMEDIR; pwd; ls'
alias re='cd $HOMEDIR/repos; pwd; ls'
alias b='cd $HOMEDIR/repos/MPAS; pwd; dir'
alias o='cd $HOMEDIR/repos/MPAS/ocean_develop; pwd'
alias ma='cd $HOMEDIR/repos/MPAS-Analysis; pwd; dir'
alias mt='cd $HOMEDIR/repos/MPAS-Tools; pwd; dir'
alias mtm='cd $HOMEDIR/repos/MPAS-Tools/master/grid_gen/mesh_conversion_tools; pwd; dir'
alias md='cd $HOMEDIR/repos/MPAS-Documents; pwd; dir'
alias mq='cd $HOMEDIR/repos/MPAS-QuickViz; pwd; dir'
alias dot='cd $HOMEDIR/repos/dotFiles; pwd'
alias a='cd $HOMEDIR/repos/ACME; pwd; dir'
alias linter='$HOMEDIR/repos/MPAS-Tools/master/python_scripts/mpas_source_linter/mpas_source_linter.py'

ACME_ROOT=$HOMEDIR/repos/ACME
CASE_ROOT=$HOMEDIR/acme_cases

# git aliases
alias gitlp='git log --graph --oneline -n 12'
alias gf="echo 'git fetch --prune origin'; git fetch --prune origin"
alias gfa="echo 'git fetch --prune --all'; git fetch --prune --all"
alias gp="echo 'git push origin master'; git push origin master"
alias gc="echo 'git commit -a'; git commit -a"
alias gcm="echo 'git commit -am'; git commit -am"
alias gca="echo 'git commit -a --amend'; git commit -a --amend"
alias grom="echo 'git rebase origin/master'; git rebase origin/master"
alias gsu="echo 'git submodule update'; git submodule update"
alias gd="echo 'git diff'; git diff"

# acme aliases
alias a='cd $HOMEDIR/repos/ACME; echo "cd to ACME_ROOT:" `pwd`; ls'
alias cr='cd $CASE_ROOT; echo "cd to CASE_ROOT:" `pwd`'
alias rr='cd $RUN_ROOT; echo "cd to RUN_ROOT:" `pwd`'

# unix aliases
alias ex='exit'
alias dir='ls -tlFhG | head'
alias h='history'
alias m='less'
alias cdd='cd \!*; ls'
alias space='du -m | sort -n'
alias grep='grep -d skip --color=always'

# login and tar aliases
# CCS server
alias toccs='scp ~/a/tar.tar mpeterse@ccscs8.lanl.gov:/home/mpeterse/a'
alias tccs='scp mpeterse@ccscs8.lanl.gov:/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'
alias ccs='ssh mpeterse@ccscs8.lanl.gov'
# LANL IC
alias tt='scp mpeterse@wtrw.lanl.gov:mpeterse@wf-fe2.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar'
alias tot=' echo "sending ~/a/tar.tar to turqoise"; scp ~/a/tar.tar mpeterse@wtrw.lanl.gov:mpeterse@wf-fe1.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar;'
alias gr='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@gr-fe'
alias wf='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@wf-fe'
alias sn='ssh -tX mpeterse@sn-fey1.lanl.gov'
alias gpfs='ssh -tX mpeterse@wtrw.lanl.gov ssh ar-tn'
# NERSC
alias ed='ssh -Y edison.nersc.gov'
alias darwin='ssh darwin-fe.lanl.gov'
alias cori='ssh -Y cori.nersc.gov'
alias ted='scp edison.nersc.gov:a/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias toed='scp ~/a/tar.tar edison.nersc.gov:a/tar.tar'
# Oak Ridge
alias eos='ssh mpetersen@eos.ccs.ornl.gov'
alias rhea='ssh mpetersen@rhea.ccs.ornl.gov'
alias titan='ssh mpetersen@titan.ccs.ornl.gov'
alias ttitan='scp mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli127/proj-shared/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias totitan='scp ~/a/tar.tar mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli127/proj-shared/mpetersen/trash/tar.tar'
# Argonne
alias theta='ssh theta.alcf.anl.gov'
alias anvil='ssh blues.lcrc.anl.gov'
alias blues='ssh blues.lcrc.anl.gov'
alias bl='ssh blues.lcrc.anl.gov'
alias tbl='scp blues.lcrc.anl.gov:a/tar.tar .;tar xvf tar.tar; rm -f tar.tar'

# taring aliases
alias t="echo 'tarring the following files to $TARFILE'; tar cvf $TARFILE"
alias unt="echo '** Untarring from $TARFILE'; tar xvf $TARFILE"

# alias to change directory
alias c='rm -f ~/a/pwd_file; export d=`pwd`; echo `pwd` > ~/a/pwd_file; echo "put pwd in a/pwd_file:";pwd'
alias d='export d=`cat ~/a/pwd_file`; cd $d; echo "cd to"; pwd'

# Added by Ruby Oct 2017: 
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
