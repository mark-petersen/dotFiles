# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# login without password every time
# Locally, do this:
# mkdir ~/.ssh/connections
# vi ~/.ssh/config
# Host *
#     ControlMaster auto
#     ControlPath ~/.ssh/connections/%h_%p_%r

# ** bash colors **
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Normal='\[\e[1;0m\]'

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's exporting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth


# for exporting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

export SVN_EDITOR="/usr/bin/vim"
export LESS="$LESS -FRXK" 
#export OMP_NUM_THREADS=1
# added this to avoid window pop-ups from git commands
unset SSH_ASKPASS

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export BASHRC_SOURCED=yes


if [[ $SHELL = /bin/bash ]]; then
   # append to the history file, don't overwrite it
   shopt -s histappend
   PS1='\[\e[1;32m\]\h:\W\$\[\e[0m\] ' # bright green
   bind '"\e[A": history-search-backward'
   bind '"\e[B": history-search-forward'
fi

# Settings specific to individual machines:
HOST=`hostname -s`

# Default, unless replaced below: 
umask 022
alias ls='ls --color'
alias ls1='ls -1 --color' # one file name per line
function lss { ls $1 | sed "s:^:`pwd`/: "; }
alias dir='ls -tlFh | head'
alias lsgraph='ls -l *part.??; ls -l *part.???; ls -l *part.????; ls -l *part.?????'
export TARFILE="~/a/tar.tar"
export HOMEDIR=~
export QUEUETYPE=slurm
export e=~/repos/E3SM
alias py='echo "Load python for e3sm-unified"; module unload python; module use $MODULEFILES; module load e3sm-unified'
alias ci='vi'
alias b='cd $HOMEDIR/repos/model; pwd; dir'
alias call='cal -y'
alias vit='vi `ls -tr |tail -n 1`'
alias tit='tail -f `ls -tr |tail -n 1`'
alias cdt='cd `ls -d1tr */ |tail -n 1`'
alias pm='cd $HOMEDIR/repos/polaris/ma*; dir'

alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_gnu_*.sh;PS1='\[\e[1;32m\]\h:g:\W\$\[\e[0m\] '"
alias li="source ~/repos/polaris/ma*/load_dev_polaris_*_intel_*.sh;PS1='\[\e[1;32m\]\h:i:\W\$\[\e[0m\] '"
alias lc="source ~/repos/polaris/ma*/load_dev_polaris_*_cray_*.sh;PS1='\[\e[1;32m\]\h:i:\W\$\[\e[0m\] '"

# directory aliases. May be reset below for each machine.
alias n='cd $n; ls -tlFh | head'
alias nn='cd $n; cd  "$(\ls -1dt ./*/ | head -n 1)"'

### Local laptops
if [[ $HOST = pn* ]]||[[ $HOST = loft* ]]; then
  echo 'mac hostname: ' $HOST
  PS1='\W$ '
  alias ls='ls -G'
  alias dir='ls -tlFhG |head'
  # see https://hpc.lanl.gov/proxy_setup
  # mrp 211209 this should be for lanl ic only.
  #export http_proxy="http://proxyout.lanl.gov:8080"
  #export https_proxy="http://proxyout.lanl.gov:8080"
  #export ftp_proxy="http://proxyout.lanl.gov:8080"
  #export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  #export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  #export FTP_PROXY="http://proxyout.lanl.gov:8080"
  #export no_proxy="localhost,127.0.0.1"

  alias r='echo "cd ~/runs";cd ~/runs'
  alias b='vi ~/s/other/my_pubs.bib'
  alias a='vi ~/s/other/pa'
  alias mu='cd ~/s/m/forever/hillstompers/music/active; pwd; ls'
  # Following lines are for zsh. 
  # also add 'source .bashrc' to .zshrc
  bindkey "^[[A" history-beginning-search-backward
  bindkey "^[[B" history-beginning-search-forward
  PROMPT='%F{115}%1~%f %# '
  alias pm='ssh mpeterse@perlmutter-p1.nersc.gov'

  if [[ $HOST = pn1707929 ]]; then
    alias git=~/miniconda3/bin/git
  fi

### LANL ccs servers
elif [[ $HOST = ccs* ]]; then
  echo 'ccs hostname: ' $HOST
  PS1='\[\e[1;31m\]\h:\W\$\[\e[0m\] ' # red
  alias sc='echo "cd /scratch/$USER";cd /scratch/$USER; pwd'
  alias r='echo "cd /scratch/$USER";cd /scratch/$USER; pwd'

### LANL turquoise IC: chicoma
elif [[ $HOSTNAME = ch-* ]]; then
  echo 'IC hostname: ' $HOST
  if [[ $HOST = ch-fe* ]]; then
    PS1='\[\e[1;32m\]ch:\W\$\[\e[0m\] ' # login: green
    alias lg="source /usr/projects/climate/$USER/repos/polaris/ma*/load_dev_polaris_*gnu*.sh;PS1='\[\e[1;32m\]ch:\[\e[0;32m\]g:\[\e[1;32m\]\W\$\[\e[0m\] '"
    alias li="echo 'intel not available'" #source /usr/projects/climate/$USER/repos/polaris/ma*/load_dev_polaris_*intel*.sh;PS1='\[\e[1;32m\]ch:\[\e[1;36m\]i:\[\e[1;32m\]\W\$\[\e[0m\] '"
  else
    PS1='\[\e[1;31m\]ch:\[\e[1;32m\]\W\$\[\e[0m\] ' # compute: red and green
    alias lg="source /usr/projects/climate/$USER/repos/polaris/ma*/load_dev_polaris_*gnu*.sh;PS1='\[\e[1;31m\]ch:\[\e[0;32m\]g:\[\e[1;32m\]\W\$\[\e[0m\] '"
    alias li="echo 'intel not available'" #source /usr/projects/climate/$USER/repos/polaris/ma*/load_dev_polaris_*intel*.sh;PS1='\[\e[1;31m\]ch:\[\e[1;36m\]i:\[\e[1;32m\]\W\$\[\e[0m\] '"
  fi
  export HOMEDIR=/usr/projects/climate/$USER

  alias r3='cd /lustre/scratch3/$USER/runs; pwd'
  alias r4='cd /lustre/scratch4/$USER/runs; pwd'
  alias rf='cd /lustre/scratch5/$USER/runs; pwd'
  alias nf='cd /lustre/scratch5/$USER/runs/n; pwd'
  alias r='cd /lustre/scratch5/$USER/runs; ls -tlFh | head'
  alias s='cd /lustre/scratch5/$USER/runs/s; ls'
  alias rrg='cd /lustre/scratch5/$USER/E3SM/scratch/chicoma-gpu; pwd; ls'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/initial_condition_database/; pwd'
  alias vtk='python /usr/projects/climate/$USER/repos/MPAS-Tools/ma*/visualization/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '
  alias py='echo "Load python for e3sm-unified"; module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_latest_e3sm_unified_badger.sh'
  alias sedc="cp /usr/projects/climate/$USER/repos/dotFiles/config.ocean_turq config.ocean; echo 'sed -i Qs/ddd/yourdir/gQ config.ocean'"
  alias sb="cp /usr/projects/climate/$USER/repos/dotFiles/sbatch_LANL_IC sbatch_script"
  alias sa='salloc -N 1 -t 2:0:0 --qos=debug --reservation=debug --account=t25_coastal_ocean'
  alias sag='salloc -N 1 -t 2:0:0 --account=t25_coastal_ocean_g --partition=gpu'
  export b=/usr/projects/climate/$USER/repos/model
  export n=/lustre/scratch5/$USER/runs/n
  export n4=/lustre/scratch4/$USER/runs/n
  export n5=/lustre/scratch5/$USER/runs/n
  export r=/lustre/scratch5/$USER/runs
  export e=/usr/projects/climate/$USER/repos/E3SM
  module load git

  ### E3SM section ###
  export RUN_ROOT=/lustre/scratch5/$USER/E3SM/scratch/chicoma-cpu/
  export ARCHIVE_ROOT=/lustre/scratch5/$USER/E3SM/archive
  export INPUTDATA=/usr/projects/e3sm/inputdata
  #alias in='cd /lustre/scratch5/$USER/E3SM/inputdata/ocn/mpas-o; pwd; ls'
  #alias inu='cd /lustre/scratch5/$USER/E3SM/inputdata_for_uploading/E3SM/inputdata; pwd; ls'
  export TARFILE="/lustre/scratch5/$USER/trash/tar.tar"

  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

  # added by Miniconda2 installer
  # export PATH="/usr/projects/climate/$USER/software/miniconda2/bin:$PATH"
  #. /usr/projects/climate/$USER/software/miniconda2/etc/profile.d/conda.sh

### LANL yellow IC: snow
elif [[ $HOST = sn* ]]; then
  echo 'IC hostname: ' $HOST
  if [[ $HOST = sn-rfe* ]]; then
    PS1='\[\e[1;33m\]\h:\W\$\[\e[0m\] ' # login: yellow
  else
    PS1='\[\e[1;31m\]\h:\[\e[1;33m\]\W\$\[\e[0m\] ' # compute: red and blue
  fi
  export HOMEDIR=/users/$USER
  export n=/lustre/scratch4/yellow/$USER/runs/n
  export r=/lustre/scratch4/yellow/$USER/runs
  alias sa='salloc -N 1 -t 2:0:0 --qos=interactive'
  alias r='cd /lustre/scratch4/yellow/$USER/runs/; pwd'
  alias rt='cd /lustre/scratch5/$USER/runs; pwd'
  alias ml='module purge; module load git; module use /users/$USER/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mli='module purge; module load git; module use /users/$USER/modulefiles/all/;module load python/anaconda-2.7-climate;module load intel/17.0.1 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/real_bathymetry_uniform/; pwd'
  alias jj='cd /users/$USER/repos/jayenne; pwd; ls'
  alias jd='cd /users/$USER/repos/jayenne/develop; pwd'
  alias jb='cd /usr/projects/jayenne/devs/$USER/jayenne_build/; pwd; ls'
  alias sm='echo "cd src/mcgrid/test/phys_verification/"; cd src/mcgrid/test/phys_verification/; ls -l|grep py; ls -l |grep test\$'
  alias jm='cd /users/$USER/repos/jayenne/develop/src/mcgrid/test/phys_verification; pwd'
  
  ### E3SM section ###
  export RUN_ROOT=/users/$USER/jayenne_build/jayenne/src/mcgrid/test/phys_verification
  export ARCHIVE_ROOT=/lustre/scratch3/turquoise/$USER/E3SM/archive
  export INPUTDATA=/usr/projects/e3sm/inputdata
  alias inu='cd /lustre/scratch3/turquoise/$USER/E3SM/inputdata_for_uploading/E3SM/inputdata; pwd; ls'
  export TARFILE="/lustre/scratch4/yellow/$USER/trash/tar.tar"

  # see https://hpc.lanl.gov/software/software-guides/proxy-setup.html
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

### nersc
elif [ ! -z "$NERSC_HOST" ]; then # if variable not empty
  #echo 'Compute facility is nersc'
  #echo "machine is $NERSC_HOST"
  #echo "host is $HOST"
  Cyan='\[\e[1;36m\]'
  MachineColor=$Cyan
  HostColor=$Cyan
  if [[ $NERSC_HOST = perlmutter ]]; then
     MachineName='pm'
     ACCOUNT='e3sm'
     #ACCOUNT='m4572'
     alias sa="salloc --nodes 1 --qos interactive --time 01:00:00 --constraint cpu --account=$ACCOUNT"
     alias saa="salloc --nodes 1 --qos interactive --time 02:00:00 --constraint cpu --account=$ACCOUNT"
     alias sag="salloc --nodes 1 --qos interactive --time 01:00:00 --constraint gpu --account=$ACCOUNT"
     alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_gnu_*.sh;PS1='\[\e[1;36m\]pm:\[\e[1;32m\]g:\[\e[1;36m\]\W\$\[\e[0m\] '"
     alias li="echo 'intel not available'" #source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_intel_*.sh;PS1='\[\e[1;36m\]pm:\[\e[1;34m\]i:\[\e[1;36m\]\W\$\[\e[0m\] '"
     if [[ $HOST = nid* ]]; then
        HostColor='\[\e[1;31m\]'
        alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_gnu_*.sh;PS1='\[\e[1;31m\]pm:\[\e[1;32m\]g:\[\e[1;36m\]\W\$\[\e[0m\] '"
        alias li="source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_intel_*.sh;PS1='\[\e[1;31m\]pm:\[\e[1;34m\]i:\[\e[1;36m\]\W\$\[\e[0m\] '"
     fi
     alias r='cd $SCRATCH/runs; pwd; ls -tlFh | head'
     alias n='cd $SCRATCH/runs/n; pwd; ls -tlFh | head'
     alias nn='cd $SCRATCH/runs/n; cd  "$(\ls -1dt ./*/ | head -n 1)"'
     alias www='cd /global/cfs/cdirs/e3sm/www/mpeterse; echo "see web at https://portal.nersc.gov/project/e3sm/"; pwd; ls'
     export r="$SCRATCH/runs"
     export n="$SCRATCH/runs/n"
     export INPUTDATA=/global/cfs/cdirs/e3sm/inputdata
     
     TARFILE="$SCRATCH/trash/tar.tar"
  fi
  PS1="${HostColor}${MachineName}:${MachineColor}\W\$${Normal} " # bright blue
  MODULEFILES='/global/project/projectdirs/acme/software/modulefiles/all' 

  export RUN_ROOT=/pscratch/sd/m/mpeterse/e3sm_scratch/pm-cpu/
  export ARCHIVE_ROOT=/scratch1/scratchdirs/$USER/E3SM/archive
  alias ans='echo "cd to analysis results"; cd /global/cscratch1/sd/$USER/analysis/; pwd;ls'
  alias anh='echo "cd to analysis html dir"; cd /global/project/projectdirs/m2833/www/mpas_analysis_output/; pwd; ls'
  alias vtk='python ~/repos/MPAS-Tools/MPAS-Tools/python_scripts/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '
  alias se='cd /global/cscratch1/sd/$USER/repos/e3sm; pwd; ls'
  alias py='echo "perlmutter: Load python for e3sm-unified"; source /global/common/software/e3sm/anaconda_envs/load_latest_e3sm_unified_pm-cpu.sh'

  alias pyc='echo "Load python for polaris"; module unload python; source /global/project/projectdirs/e3sm/software/anaconda_envs/load_latest_polaris.sh'
  alias ec='cd /global/cscratch1/sd/$USER/repos/E3SM/pr; pwd'
  alias ecm='cd ~/repos/E3SM_current/ma*; pwd; dir'
  alias sedc="cp /usr/projects/climate/$USER/repos/dotFiles/config.ocean_nersc config.ocean; echo 'sed -i Qs/ddd/yourdir/gQ config.ocean'"
  export b=~/repos/model
  export e=/global/homes/m/$USER/repos/E3SM
  alias mini='cd /global/homes/m/$USER/repos/miniWeather; pwd; ls'

### Oak Ridge: summit, frontier
elif [[ $HOME = "/ccs/home/$USER" ]]; then
  #echo 'Oak Ridge hostname: ' $HOST
  alias r='cd /lustre/orion/cli115/scratch/mpetersen/runs; pwd; ls -tlFh | head'
  export r=/lustre/orion/cli115/scratch/mpetersen/runs
  export n=/lustre/orion/cli115/scratch/mpetersen/runs/n
  if [[ $HOST = login* ]]; then
     if [[ $LMOD_SYSTEM_NAME = summit ]]; then
        PS1='\[\e[1;35m\]su:\W\$\[\e[0m\] ' # maroon
        module load python
        alias sa="echo 'bsub -W 2:00 -nnodes 1 -P CLI115 -Is /bin/bash'; bsub -W 2:00 -nnodes 1 -P CLI115 -Is /bin/bash"
        alias r='cd /gpfs/alpine/cli115/scratch/mpetersen/runs; pwd; ls -tlFh | head'
     elif [[ $LMOD_SYSTEM_NAME = frontier ]]; then
        PS1='\[\e[1;35m\]fr:\W\$\[\e[0m\] ' # maroon
        alias sa="echo 'salloc -A cli115 -J inter -t 2:00:00 -q debug -N 1 -S 0'; salloc -A cli115 -J inter -t 2:00:00 -q debug -N 1 -S 0"
        alias sa="echo 'salloc -A cli115 -J inter -t 2:00:00 -q debug -N 1 -p batch'; salloc -A cli115 -J inter -t 2:00:00 -q debug -N 1 -p batch"
     elif [[ $LMOD_SYSTEM_NAME = crusher ]]; then
        PS1='\[\e[1;35m\]cr:\W\$\[\e[0m\] ' # maroon
        alias sa="echo 'salloc -A CLI115 -J mrp_test -t 00:05:00 -p batch -N 2'; salloc -A CLI115 -J mrp_test -t 00:05:00 -p batch -N 2"
        module load cray-python
     else
        PS1='\[\e[1;35m\]\h\W\$\[\e[0m\] ' # maroon
     fi
  elif [[ $HOST = batch* ]]||[[ $HOST = crusher* ]]; then
     alias sa="echo 'already on compute node'"
     if [[ $LMOD_SYSTEM_NAME = summit ]]; then
        PS1='\[\e[1;31m\]su:\[\e[1;35m\]\W\$\[\e[0m\] ' # compute: red and blue
        module load python
     elif [[ $LMOD_SYSTEM_NAME = frontier ]]; then
        PS1='\[\e[1;31m\]fr:\h:\W\$\[\e[0m\] ' # maroon
# same for summit?
#        alias r='cd /lustre/orion/cli115/scratch/mpetersen/runs; pwd; ls -tlFh | head'
     elif [[ $LMOD_SYSTEM_NAME = crusher ]]; then
        PS1='\[\e[1;31m\]\h:\W\$\[\e[0m\] ' # maroon
        module load cray-python
     else
        PS1='\[\e[1;31m\]\h\W\$\[\e[0m\] ' # maroon
     fi
  fi
  PATH=$PATH:/ccs/home/$USER/.local/summit/anaconda3/2020.07/3.8/bin
  export RUN_ROOT=/lustre/orion/cli115/proj-shared/${USER}/e3sm_scratch
  alias inu='cd /ccs/home/$USER/inputdata_for_uploading; pwd; ls'
# might be for summit:
#  export TARFILE="/gpfs/alpine/cli115/scratch/$USER/trash/tar.tar"
  export TARFILE="/lustre/orion/cli115/scratch/$USER/trash/tar.tar"
  module load git
  module load cmake
  alias py='echo "Load python for e3sm"; module unload python python/base; module use /global/project/projectdirs/acme/software/modulefiles/all; module load e3sm-unified/1.1.2'
  alias r='cd /lustre/orion/cli115/scratch/$USER/runs; pwd; ls -tlFh | head'
  alias n='cd /lustre/orion/cli115/scratch/$USER/runs/n; pwd; ls -tlFh | head'
  alias cppm='cd /ccs/home/$USER/repos/beginning-cpp20/mark_exercises; pwd; ls'
  alias mini='cd /gpfs/alpine/cli115/scratch/$USER/repos/miniWeather/simple_yakl_tests/cpp; pwd; ls'
  alias vip='vim -p main* timestep.cpp tendencies.cpp Config.cpp Mesh.cpp State.cpp Tend.cpp Diag.cpp io.cpp'

### Argonne: aurora
elif [[ $HOST = aurora* ]]; then
  #echo 'Oak Ridge hostname: ' $HOST
  alias r='cd /lustre/orion/cli115/scratch/mpetersen/runs; pwd; ls -tlFh | head'
  export r=/lustre/orion/cli115/scratch/mpetersen/runs
  export n=/lustre/orion/cli115/scratch/mpetersen/runs/n
  MachineName='au'
  HostColor='\[\e[1;33m\]'
  MachineColor='\[\e[1;33m\]'
  if [[ $HOST = nid* ]]; then # change for aurora
     HostColor='\[\e[1;31m\]'
     alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_gnu_*.sh;PS1='\[\e[1;31m\]pm:\[\e[1;32m\]g:\[\e[1;36m\]\W\$\[\e[0m\] '"
     alias li="source ~/repos/polaris/ma*/load_dev_polaris_*_pm-cpu_intel_*.sh;PS1='\[\e[1;31m\]pm:\[\e[1;34m\]i:\[\e[1;36m\]\W\$\[\e[0m\] '"
  fi
  PS1="${HostColor}${MachineName}:${MachineColor}\W\$${Normal} " # bright blue
  export RUN_ROOT=/lustre/orion/cli115/proj-shared/${USER}/e3sm_scratch
  alias inu='cd /ccs/home/$USER/inputdata_for_uploading; pwd; ls'
  export TARFILE="/lustre/orion/cli115/scratch/$USER/trash/tar.tar"
  module load cmake
  alias py='echo "Load python for e3sm"; module unload python python/base; module use /global/project/projectdirs/acme/software/modulefiles/all; module load e3sm-unified/1.1.2'
  alias r='cd /lustre/orion/cli115/scratch/$USER/runs; pwd; ls -tlFh | head'
  alias n='cd /lustre/orion/cli115/scratch/$USER/runs/n; pwd; ls -tlFh | head'

### Oak Ridge chrysalis
elif [[ $HOST = chr* ]]; then
  echo 'chrysalis hostname: ' $HOST
  if [[ $HOST = chrlogin* ]]; then
    PS1='\[\e[1;34m\]chr:\W\$\[\e[0m\] ' # login: blue
    alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_gnu_*.sh;PS1='\[\e[1;34m\]chr:\[\e[1;32m\]g:\[\e[1;34m\]\W\$\[\e[0m\] '"
    alias li="source ~/repos/polaris/ma*/load_dev_polaris_*_intel_*.sh;PS1='\[\e[1;34m\]chr:\[\e[1;36m\]i:\[\e[1;34m\]\W\$\[\e[0m\] '"
  elif [[ $HOST = chr-* ]]; then
    PS1='\[\e[1;31m\]\h:\[\e[1;34m\]\W\$\[\e[0m\] ' # compute: red and blue
    alias lg="source ~/repos/polaris/ma*/load_dev_polaris_*_gnu_*.sh;PS1='\[\e[1;31m\]\h:\[\e[1;32m\]g:\[\e[1;34m\]\W\$\[\e[0m\] '"
    alias li="source ~/repos/polaris/ma*/load_dev_polaris_*_intel_*.sh;PS1='\[\e[1;31m\]\h:\[\e[1;36m\]i:\[\e[1;34m\]\W\$\[\e[0m\] '"
  fi
  export RUN_ROOT=/lcrc/group/e3sm/$USER/scratch/chrys
  export TARFILE="/lcrc/group/e3sm/$USER/scratch/trash/tar.tar"
  export r=/lcrc/group/e3sm/$USER/scratch/runs
  export n=/lcrc/group/e3sm/$USER/scratch/runs/n
  export bo=/lcrc/group/e3sm/$USER/scratch/by_others/
  export INPUTDATA=/lcrc/group/e3sm/data/inputdata/
  alias r='cd /lcrc/group/e3sm/$USER/scratch/runs; ls -tlFh | head'
  alias n='cd /lcrc/group/e3sm/$USER/scratch/runs/n; ls -tlFh | head'
  alias sa="srun -p debug -N 1 -t 1:00:00 --pty bash"
  alias inu="cd /lcrc/group/acme/public_html/inputdata/; pwd; ls"
  alias inuo="cd /lcrc/group/acme/public_html/inputdata/ocn/mpas-o; pwd; ls"
  alias inui="cd /lcrc/group/acme/public_html/inputdata/ice/mpas-seaice/; pwd; ls"
  alias py='echo "Load python for e3sm"; source /lcrc/soft/climate/e3sm-unified/load_latest_e3sm_unified_chrysalis.sh'

### Oak Ridge: anvil and blues
elif [[ $HOST = anvil* ]] || [[ $HOST = blueslogin* ]]; then
  echo 'Argonne hostname: ' $HOST
  export RUN_ROOT=/lcrc/group/e3sm/$USER/scratch/anvil
  export TARFILE="/lcrc/group/e3sm/$USER/scratch/trash/tar.tar"
  PS1='\[\e[1;35m\]\h:\W\$\[\e[0m\] ' # maroon
  # old export RUN_ROOT=/lcrc/group/acme/$USER/acme_scratch/
  alias py='echo "Load python for e3sm"; source /lcrc/soft/climate/e3sm-unified/base/etc/profile.d/conda.sh; conda activate /lcrc/soft/climate/e3sm-unified/base/envs/e3sm_unified_1.5.0rc7_nompi; unset LD_LIBRARY_PATH'
  alias anre='echo "cd to analysis repo"; cd /home/$USER/repos/analysis/develop_180430; pwd; ls'
  alias ans='echo "cd to analysis results"; cd /lcrc/group/acme/$USER/analysis; pwd; ls'
  alias anh='echo "cd to analysis html dir"; cd /lcrc/group/acme/$USER/mpas_analysis_html; pwd; ls'
  module load git
  PATH=$PATH:/usr/libexec/git-core
  alias py='echo "Load python for e3sm-unified"; module unload python; source /lcrc/soft/climate/e3sm-unified/load_latest_e3sm_unified_anvil.sh' 
  export INPUTDATA=/lcrc/group/e3sm/data/inputdata/
  alias inn='cd /lcrc/group/e3sm/$USER/scratch/E3SM/inputdata; pwd; ls'

### PNNL: compy I did not renew compy!
#elif [[ $HOST = compy* ]]; then
#  PS1='\[\e[1;31m\]\W\$\[\e[0m\] ' # red
#  alias sc='echo "cd /scratch/$USER";cd /scratch/$USER; pwd'
#  alias r='echo "cd /scratch/$USER";cd /scratch/$USER; pwd'
#  alias rr='cd /compyfs/pete011/e3sm_scratch; pwd;ls -tlFh | head'
#  TARFILE='~/a/tar.tar'
#  module load git
#  module load python
#  export PROJECT=e3sm
#  alias py='echo "Load python for e3sm-unified"; module unload python; source /share/apps/E3SM/conda_envs/load_latest_e3sm_unified_compy.sh'

### TACC: stampede2 
elif [[ $HOST = login* ]] || [[ $HOST = c???-??? ]]; then
  echo 'TACC hostname: ' $HOST
  PS1='\[\e[1;33m\]\h:\W\$\[\e[0m\] ' # yellow
  export RUN_ROOT=/lustre/atlas/scratch/$USER/cli127
  alias py='conda activate e3sm-unified-mpich' # see instructions at e3sm unified conda
  export TARFILE='/scratch/03443/$USER/trash/tar.tar'

### LANL darwin
elif [[ $HOST = darwin* ]]; then
  PS1='\[\e[1;34m\]\h:\W\$\[\e[0m\] ' # blue
  echo 'darwin hostname: ' $HOST
  alias r='echo "cd /scratch/users/$USER/runs";cd /scratch/users/$USER/runs; pwd'

fi


if [[ $QUEUETYPE = slurm ]]; then
  alias j='echo "slurm: squeue -u $USER"; squeue -u $USER -l|cut -c1-120'
  alias ja='echo "slurm: squeue"; squeue -l|cut -c1-120'
  alias canceljob='echo "slurm: scancel"; scancel '
  alias llogin='echo "slurm: salloc --qos=interactive -t 4:0:0 -N 1"; salloc --qos=interactive -t 4:0:0 -N 1'
  alias partitions='echo "slurm: sinfo |cut -c 1-100"; sinfo |cut -c 1-100'
elif [[ $QUEUETYPE = pbs ]]; then
  export QSTAT_HEADER=JobId:JobName:User:WallTime:RunTime:Nodes:Mode:State:Queue:Score
  alias j='echo "pbs: qstat -u $USER"; qstat -u ${USER}; qstat -u ${USER}|cut -c1-120'
  alias ja='echo "pbs: qstat"; qstat |cut -c1-100'
  alias canceljob='echo "pbs: qdel"; qdel '
  alias llogin='echo "pbs: qsub -I -t 1:00:00 -n 1 -q debug-flat-quad"; qsub -I -t 1:00:00 -n 1 -q debug-flat-quad'
  alias partitions='echo "pbs: qstat -Q"; qstat -Q'
elif [[ $QUEUETYPE = LSF ]]; then
  export QSTAT_HEADER=JobId:JobName:User:WallTime:RunTime:Nodes:Mode:State:Queue:Score
  alias j='echo "lsf: bjobs"; bjobs|cut -c1-120'
  alias canceljob='echo "lsf: bkill"; bKill'
fi

# mrp 200923 turn off this path for python
#export PATH="$HOMEDIR/software/anaconda2/bin:$PATH"
# practice without this:
# export PATH=${PATH}:.

alias home='cd $HOMEDIR; pwd; ls'
alias re='cd $HOMEDIR/repos; pwd; ls'
alias o='cd $HOMEDIR/repos/model/ocean_develop; pwd'
alias cl='cd $HOMEDIR/repos/compass/legacy; pwd'
alias cpr='cd $HOMEDIR/repos/compass/pr; dir'
alias mt='cd $HOMEDIR/repos/tools; pwd; dir'
alias mtm='cd $HOMEDIR/repos/tools/ma*/grid_gen/mesh_conversion_tools; pwd; dir'
alias md='cd $HOMEDIR/repos/documents; pwd; dir'
alias mq='cd $HOMEDIR/repos/quickviz; pwd; dir'
alias dot='cd $HOMEDIR/repos/dotFiles; pwd'
alias sdot='source $HOMEDIR/repos/dotFiles/bashrc'
alias sd='source $HOMEDIR/repos/dotFiles/bashrc'
alias sdoc='echo "source ${HOME}/miniforge3/etc/profile.d/conda.sh"; echo "conda activate omega_dev"; source ${HOME}/miniforge3/etc/profile.d/conda.sh; conda activate omega_dev; echo "You can now: "; echo "cd components/omega/doc/"; echo "make clean"; echo "make html"'

alias vtk='python ${HOMEDIR}/repos/tools/ma*/visualization/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '
alias cs='cd cime/scripts'

E3SM_ROOT=$HOMEDIR/repos/E3SM
CASE_ROOT=$HOMEDIR/e3sm_cases

# git aliases
alias gs='git status'
alias gb='git branch'
alias gba='git branch --all'
alias grv='git remote -v'
alias gl='git log -n 1'
alias g='git log --graph --oneline -n 12'
alias gg='git log --graph --oneline'
alias gitlp='git log --graph --oneline -n 12'
alias gl='git log -n 1'
alias gf="echo 'git fetch --prune origin'; git fetch --prune origin"
alias gfa="echo 'git fetch --prune --all'; git fetch --prune --all"
alias gfme="echo 'git fetch --prune me'; git fetch --prune me"
alias gfx="echo 'git fetch --prune xylar'; git fetch --prune xylar"
#alias gp="echo 'git push origin master'; git push origin master; git push origin main"
alias gp="git push"
alias gc="echo 'git commit -a'; git commit -a"
alias gcm="echo 'git commit -am'; git commit -am"
alias gca="echo 'git commit -a --amend'; git commit -a --amend"
alias grom="echo 'git rebase origin/master'; git rebase origin/master"
alias grhom="echo 'git reset --hard origin/master'; git reset --hard origin/master"
alias grhh="echo 'git reset --hard HEAD'; git reset --hard HEAD"
alias gsu="echo 'git submodule update --init --recursive'; git submodule update --init --recursive"
alias gsuo='git submodule update --init --recursive src/cvmix/ src/gotm/ src/BGC src/MARBL src/gotm src/FFTW src/SHTNS src/ppr; echo "git submodule update --init --recursive src/cvmix/ src/gotm/ src/BGC src/MARBL src/gotm src/ppr"'
alias gsuom='git submodule update --init --recursive externals/ekat externals/scorpio externals/cpptrace cime; echo "git submodule update --init --recursive externals/ekat externals/scorpio externals/cpptrace cime"'
alias gd="git diff"
alias gds="git diff --stat"
alias gdt="echo 'git difftool --tool=vimdiff'; git difftool --tool=vimdiff"
alias gdo="echo 'git diff origin/master'; git diff origin/master"
alias gdos="echo 'git diff origin/master'; git diff origin/master --stat"
alias ggin="echo 'git grep -in '; git grep -in "
alias gdh="echo 'git diff HEAD~1'; git diff HEAD~1"
alias gdhs="echo 'git diff HEAD~1 --stat'; git diff HEAD~1 --stat"
alias gdh2="echo 'git diff HEAD~2'; git diff HEAD~2"
alias gdhs2="echo 'git diff HEAD~2 --stat'; git diff HEAD~2 --stat"
alias gdh3="echo 'git diff HEAD~3'; git diff HEAD~3"
alias gdhs3="echo 'git diff HEAD~3 --stat'; git diff HEAD~3 --stat"
alias gdh4="echo 'git diff HEAD~4'; git diff HEAD~4"
alias gdhs4="echo 'git diff HEAD~4 --stat'; git diff HEAD~4 --stat"

# e3sm aliases
alias e='cd $HOMEDIR/repos/E3SM; echo "cd to E3SM_ROOT:" `pwd`; ls'
alias ee='cd $HOMEDIR/repos/E3SM; echo "cd to E3SM_ROOT:" `pwd`; ls'
alias em='cd $HOMEDIR/repos/E3SM/master; echo "cd to E3SM_ROOT/master:" `pwd`; ls'
alias epr='cd $HOMEDIR/repos/E3SM/pr; echo "cd to E3SM_ROOT:" `pwd`; ls'
alias p='cd $HOMEDIR/repos/polaris/main; echo "cd to polaris/main:" `pwd`; ls'
alias cc='cd $HOMEDIR/repos/compass; dir'
alias cm='cd $HOMEDIR/repos/compass/ma*; dir'
alias q='cd $HOMEDIR/repos/quickviz; echo "cd to quickviz:" `pwd`; ls'
alias cr='cd $CASE_ROOT; echo "cd to CASE_ROOT:" `pwd`'
alias rr='cd $RUN_ROOT; echo "cd to RUN_ROOT:" `pwd`; ls -tlFh | head'
alias rrr='cd $RUN_ROOT; cd  "$(\ls -1dt ./*/ | head -n 1)"'
alias r1='cd $RUN_ROOT; cd  "$(\ls -1dt ./*/ | head -n 1)"'
alias r2='cd $RUN_ROOT; cd  "$(\ls -1dt ./*/ | head -n 2|tail -n 1)"'
alias to='tail  "$(\ls -1dt ocn.log*|head -n 1 )" -n 1'
alias ke='echo "ncdump -v kineticEnergyCellMax analysis_members/globalStats.*.nc |tail -n 20";ncdump -v kineticEnergyCellMax analysis_members/globalStats.*.nc |tail -n 20'

# unix aliases
alias ex='exit'
alias h='history'
alias m='less'
alias cdd='cd \!*; ls'
alias cd.='cd ..'
alias cd..='cd ../..'
alias cd...='cd ../../..'
alias cd....='cd ../../../..'
alias space='du --block-size=1G | sort -n'
alias grep='grep -d skip --color=always'

# login and tar aliases
# CCS server
alias toccs='scp ~/a/tar.tar mpeterse@ccscs1.lanl.gov:/home/mpeterse/a'
alias tccs='scp mpeterse@ccscs1.lanl.gov:/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'
alias ccs='ssh mpeterse@ccscs1.lanl.gov'
# LANL IC
alias tt="scp -O mpeterse@ch-fe.lanl.gov:/lustre/scratch5/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar"
alias tot=" echo 'sending tar.tar to turqoise'; scp -O $TARFILE mpeterse@ch-fe.lanl.gov:/lustre/scratch5/mpeterse/trash/tar.tar;"
alias tch="scp -O mpeterse@ch-fe.lanl.gov:/lustre/scratch5/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar"
alias toch=" echo 'sending tar.tar to turqoise'; scp -O $TARFILE mpeterse@ch-fe.lanl.gov:/lustre/scratch5/mpeterse/trash/tar.tar;"
alias toy=" echo 'sending tar.tar to yellow'; scp -O $TARFILE mpeterse@ro-rfe.lanl.gov:/lustre/roscratch1/mpeterse/trash/tar.tar;"
alias ty="scp -O mpeterse@ro-rfe.lanl.gov:/lustre/roscratch1/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar"
alias ch='ssh -t mpeterse@ch-fe'
alias ro='ssh mpeterse@ro-rfe.lanl.gov'
alias summit='ssh mpetersen@summit.olcf.ornl.gov'
alias su='ssh mpetersen@summit.olcf.ornl.gov'
alias fr='ssh mpetersen@frontier.olcf.ornl.gov'
alias crusher='ssh mpetersen@crusher.olcf.ornl.gov'
alias da='ssh mpeterse@darwin-fe.lanl.gov'
alias toda='scp ~/a/tar.tar mpeterse@darwin-fe.lanl.gov:/vast/home/mpeterse/a'
alias tda='scp mpeterse@darwin.lanl.gov:/vast/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'
alias gpfs='ssh -t mpeterse@ar-tn'
alias ar='ssh -t mpeterse@ar-tn'
alias makehtml='conda activate test_compass_docs; export DOCS_VERSION="test"; cd docs; make html; cd _build; t html; cd ../../'
# NERSC
alias tpm='scp mpeterse@perlmutter-p1.nersc.gov:/pscratch/sd/m/mpeterse/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias topm='scp ~/a/tar.tar mpeterse@perlmutter-p1.nersc.gov:/pscratch/sd/m/mpeterse/trash/tar.tar'
# PNNL
alias compy='echo "Did not renew compy' #ssh pete011@compy.pnl.gov'
#alias tcompy='scp pete011@compy.pnl.gov:~/a/tar.tar .; tar xvf tar.tar; rm -f tar.tar'
#alias tocompy='scp ~/a/tar.tar pete011@compy.pnl.gov:~/a/tar.tar'
# Oak Ridge
alias eos='ssh mpetersen@eos.ccs.ornl.gov'
alias rhea='ssh mpetersen@rhea.ccs.ornl.gov'
alias titan='ssh mpetersen@titan.ccs.ornl.gov'
alias ttitan='scp mpetersen@titan.ccs.ornl.gov:/lustre/atlas2/cli127/scratch/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias totitan='scp ~/a/tar.tar mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli127/proj-shared/mpetersen/trash/tar.tar'
# Argonne
alias theta='ssh mpeterse@theta.alcf.anl.gov'
alias ttheta='scp mpeterse@theta.alcf.anl.gov:/projects/OceanClimate_2/mpeterse/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'

# other logins
alias tacc='echo "stampede2 at tacc. cd into stampede2.tacc.utexas.edu"; ssh mpeterse@stampede2.tacc.utexas.edu'
alias totacc='scp /scratch/03443/mpeterse/trash/tar.tar mpeterse@stampede2.tacc.utexas.edu:/scratch/03443/mpeterse/trash/tar.tar'
alias ttacc='scp mpeterse@stampede2.tacc.utexas.edu:/scratch/03443/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar'
alias bl='ssh -l ac.mpetersen -i ~/.ssh/id_rsa_blues blues.lcrc.anl.gov'
alias chr='ssh -l ac.mpetersen -i ~/.ssh/id_rsa chrysalis.lcrc.anl.gov'
alias tbl='scp -i ~/.ssh/id_rsa_blues ac.mpetersen@blues.lcrc.anl.gov:/lcrc/group/e3sm/ac.mpetersen/scratch/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias tchr='scp -i ~/.ssh/id_rsa_blues ac.mpetersen@chrysalis.lcrc.anl.gov:/lcrc/group/e3sm/ac.mpetersen/scratch/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias tochr=" echo 'sending tar.tar to chyrsalis'; scp -i ~/.ssh/id_rsa_blues $TARFILE ac.mpetersen@chrysalis.lcrc.anl.gov:/lcrc/group/e3sm/ac.mpetersen/scratch/trash/tar.tar"
alias tobl='scp -i ~/.ssh/id_rsa_blues ~/a/tar.tar ac.mpetersen@blues.lcrc.anl.gov:/lcrc/group/e3sm/ac.mpetersen/scratch/trash/tar.tar'
alias su='ssh mpetersen@summit.olcf.ornl.gov'
alias tsu='scp -O mpetersen@summit.olcf.ornl.gov:/gpfs/alpine/cli115/scratch/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias tosu='scp -O ~/a/tar.tar mpetersen@summit.olcf.ornl.gov:/gpfs/alpine/cli115/scratch/mpetersen/trash/tar.tar'
alias tfr='scp -O mpetersen@frontier.olcf.ornl.gov:/lustre/orion/cli115/scratch/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias tofr='scp -O ~/a/tar.tar mpetersen@frontier.olcf.ornl.gov:/lustre/orion/cli115/scratch/mpetersen/trash/tar.tar'

alias au='ssh mpeterse@aurora.alcf.anl.gov'

# taring aliases
alias t="echo 'tarring the following files to $TARFILE'; tar cvf $TARFILE"
alias unt="echo '** Untarring from $TARFILE'; tar xvf $TARFILE"

# alias to change directory
alias c='rm -f ~/a/pwd_file; export d=`pwd`; echo `pwd` > ~/a/pwd_file; echo "c=";pwd'
alias d='export d=`cat ~/a/pwd_file`; cd $d; echo "cd to d:"; pwd'
alias c1='rm -f ~/a/pwd_file1; export d1=`pwd`; echo `pwd` > ~/a/pwd_file1; echo "c1=";pwd'
alias d1='export d1=`cat ~/a/pwd_file1`; cd $d1; echo "cd to d1:"; pwd'
alias c2='rm -f ~/a/pwd_file2; export d2=`pwd`; echo `pwd` > ~/a/pwd_file2; echo "c2=";pwd'
alias d2='export d2=`cat ~/a/pwd_file2`; cd $d2; echo "cd to d2:"; pwd'
alias c3='rm -f ~/a/pwd_file3; export d3=`pwd`; echo `pwd` > ~/a/pwd_file3; echo "c3=";pwd'
alias d3='export d3=`cat ~/a/pwd_file3`; cd $d3; echo "cd to d3:"; pwd'
alias c4='rm -f ~/a/pwd_file4; export d4=`pwd`; echo `pwd` > ~/a/pwd_file4; echo "c4=";pwd'
alias d4='export d4=`cat ~/a/pwd_file4`; cd $d4; echo "cd to d4:"; pwd'

export om=/components/mpas-ocean/
alias om='cd components/mpas-ocean'
alias co="echo 'cd components/omega'; cd components/omega"
alias cos="echo 'cd components/omega/src'; cd components/omega/src"
alias cdp='cd ocean/global_ocean/QU240/PHC/performance_test/forward/'
alias cr='compass run'
alias cs='cd cime/scripts'
alias per='cd ocean/global_ocean/QU240/PHC/performance_test/forward'
alias cppm='cd ~/repos/beginning-cpp20/mark_exercises; pwd; ls'
alias caod='conda activate omega_dev'

alias in='cd $INPUTDATA; pwd; ls'
alias ino='cd $INPUTDATA/ocn/mpas-o/; pwd; ls'
alias ini='cd $INPUTDATA/ice/mpas-seaice/; pwd; ls'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mpeterse/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mpeterse/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/mpeterse/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mpeterse/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

