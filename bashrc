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
export PS1='\e[0;32m\h:\W$ \e[m'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# practice without this:
# export PATH=${PATH}:.

# Settings specific to individual machines:
HOST=`hostname -s`
echo $HOST

# Default, unless replaced below: 
alias ls='ls --color'
TARFILE="~/a/tar.tar"
export HOMEDIR=~

if [[ $HOST = pn* ]]; then
  echo 'mac hostname: ' $HOST
  alias git='/usr/local/git/bin/git'
  export PS1='\W$ '
  alias ls='ls -G'
elif [[ $HOST = forest* ]]; then
  echo 'forest hostname: ' $HOST
  export PS1='\W$ '
elif [[ $HOST = ccs* ]]; then
  echo 'ccs hostname: ' $HOST
  export PS1='\e[0;31m\h:\W$ \e[m' # red
elif [[ $HOST = gr* ]] || [[ $HOST = wf* ]]; then
  echo 'IC hostname: ' $HOST
  PS1='\[\e[1;32m\]\h:\W\$\[\e[0m\] ' # bright green
  export HOMEDIR=/usr/projects/climate/mpeterse
  export QUEUETYPE=slurm
  module load git
  alias ml='echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio"; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/; module load python/anaconda-2.7-climate; module load intel/15.0.5 openmpi/1.6.5 netcdf/4.4.0 parallel-netcdf/1.5.0 pio/1.7.2'
  alias mlg='echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio"; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/; module load python/anaconda-2.7-climate; module load gcc/4.8.2 openmpi/1.6.5 netcdf/4.4.0 parallel-netcdf/1.5.0 pio/1.7.2'
  alias mlgr='module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mlgri='module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load intel/17.0.1 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mr='cd /usr/projects/climate/mpeterse/repos/MPAS-Release; pwd'
  alias mt='cd /usr/projects/climate/mpeterse/repos/MPAS-Tools; pwd'
  alias r='cd /lustre/scratch3/turquoise/mpeterse/runs; pwd'
  alias r2='cd /lustre/scratch2/turquoise/mpeterse/runs; pwd'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/real_bathymetry_uniform/; pwd'
  
  ### acme section ###
  set RUN_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/cases
  set ARCHIVE_ROOT=/lustre/scratch3/turquoise/mpeterse/ACME/archive
  
  alias ar='cd $ACME_ROOT; echo "cd to ACME_ROOT:" `pwd`'
  alias cr='cd $CASE_ROOT; echo "cd to CASE_ROOT:" `pwd`'
  
  alias rr='cd $RUN_ROOT; echo "cd to RUN_ROOT:" `pwd`'
  alias in='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data; pwd; ls'
  alias inu='cd /lustre/scratch3/turquoise/mpeterse/ACME/input_data_for_uploading/acme/inputdata; pwd; ls'
  TARFILE="/lustre/scratch3/turquoise/mpeterse/trash/tar.tar"

elif [[ $HOST = ed* ]] || [[ $HOST = cori* ]] || [[ $HOST = nid* ]]; then
  echo 'NERSC hostname: ' $HOST
  export QUEUETYPE=slurm
  export PS1='\e[0;34m\h:\W$ \e[m' # blue, edison
  export PS1='\e[0;36m\h:\W$ \e[m' # bright blue, cori

  module use /global/cscratch1/sd/lvroekel/modulefiles/all
  alias r='cd $SCRATCH/runs; pwd'
  alias cs='cd $CSCRATCH/runs; pwd'
  RUN_ROOT=/global/cscratch1/sd/mpeterse/acme_scratch
  ARCHIVE_ROOT=/scratch1/scratchdirs/mpeterse/ACME/archive

elif [[ $HOST = theta* ]]; then
  echo 'theta hostname: ' $HOST
  export QUEUETYPE=pbs

  module load hsi
  module load cray-netcdf
  export RUN_ROOT=/projects/OceanClimate/mpeterse
  alias in='cd /projects/OceanClimate/acme/inputdata; pwd; ls'

elif [[ $HOST = titan* ]] || [[ $HOST = rhea* ]]; then
  echo 'Oak Ridge hostname: ' $HOST
  export QUEUETYPE=pbs
  export PS1='\e[0;33m\h:\W$ \e[m' # yellow
fi


if [[ $QUEUETYPE = slurm ]]; then
  alias j='echo "slurm: squeue -u mpeterse"; squeue -u mpeterse'
  alias ja='echo "slurm: squeue"; squeue'
  alias canceljob='echo "slurm: scancel"; scancel'
  alias llogin='echo "slurm: salloc --qos=interactive -t 4:0:0 -N 1"; salloc --qos=interactive -t 4:0:0 -N 1'
  # for cori: salloc --partition=debug --nodes=32 --time=30:00 -C knl
  alias partitions='echo "slurm: sinfo |cut -c 1-100"; sinfo |cut -c 1-100'
elif [[ $QUEUETYPE = pbs ]]; then
  export QSTAT_HEADER=JobId:JobName:User:WallTime:RunTime:Nodes:Mode:State:Queue:Score
  alias j='echo "pbs: qstat -u mpeterse"; qstat -u mpeterse'
  alias ja='echo "pbs: qstat"; qstat'
  alias llogin='echo "pbs: qsub -I -t 1:00:00 -n 1 -q debug-flat-quad"; qsub -I -t 1:00:00 -n 1 -q debug-flat-quad'
  alias partitions='echo "pbs: qstat -Q"; qstat -Q'
fi

alias home='cd $HOMEDIR; pwd; ls'
alias b='cd $HOMEDIR/repos/MPAS; pwd; dir'
alias o='cd $HOMEDIR/repos/MPAS/ocean_develop; pwd'
alias a='cd $HOMEDIR/repos/ACME; pwd; ls'
alias linter='$HOMEDIR/repos/MPAS-Tools/MPAS-Tools/python_scripts/mpas_source_linter/mpas_source_linter.py'

ACME_ROOT=$HOMEDIR/repos/ACME
CASE_ROOT=$HOMEDIR/acme_cases

# git aliases
alias gitlp='git log --graph --oneline -n 12'

alias a='cd $ACME_ROOT; echo "cd to ACME_ROOT:" `pwd`; ls'
alias ar='cd $ACME_ROOT; echo "cd to ACME_ROOT:" `pwd`'
alias cr='cd $CASE_ROOT; echo "cd to CASE_ROOT:" `pwd`'
alias rr='cd $RUN_ROOT; echo "cd to RUN_ROOT:" `pwd`'

# unix aliases
alias ex='exit'
alias dir='ls -tlFhG | head'
alias h='history'
alias m='less'
alias cdd='cd \!*; ls'
alias space='du -k | sort -n'
alias grep='grep -d skip --color=always'

alias python='/Users/mpeterse/anaconda/bin/python'
alias ipython='/Users/mpeterse/anaconda/bin/ipython'

# login and tar aliases
# CCS server
alias toccs='scp ~/a/tar.tar mpeterse@ccscs8:/home/mpeterse/a'
alias tccs='scp mpeterse@ccscs8.lanl.gov:/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'
alias ccs='ssh mpeterse@ccscs8.lanl.gov'
# LANL IC
alias tt='scp mpeterse@wtrw.lanl.gov:mpeterse@wf-fe2.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar'
alias tot=' echo "sending ~/a/tar.tar to turqoise"; scp ~/a/tar.tar mpeterse@wtrw.lanl.gov:mpeterse@wf-fe1.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar;'
alias gr='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@gr-fe'
alias wf='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@wf-fe'
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
alias ttitan='scp mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli115/proj-shared/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
# Argonne
alias theta='ssh theta.alcf.anl.gov'

# taring aliases
alias t="echo 'tarring the following files to $TARFILE'; tar cvf $TARFILE"
alias unt="echo '** Untarring from $TARFILE'; tar xvf $TARFILE"

# alias to change directory
alias c='rm -f ~/a/pwd_file; export d=`pwd`; echo `pwd` > ~/a/pwd_file; echo "put pwd in a/pwd_file:";pwd'
alias d='export=`cat ~/a/pwd_file`; cd $d; echo "cd to"; pwd'
