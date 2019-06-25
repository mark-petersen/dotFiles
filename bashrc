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
# added this to avoid window pop-ups from git commands
unset SSH_ASKPASS

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
alias dir='ls -tlFh | head'
alias lsgraph='ls -l *part.??; ls -l *part.???; ls -l *part.????; ls -l *part.?????'
export TARFILE="~/a/tar.tar"
export HOMEDIR=~
alias py='echo "Load python for e3sm-unified"; module unload python; module use $MODULEFILES; module load e3sm-unified'
alias py2='source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_latest_e3sm_unified_py2.7_nox.sh'

### Local laptops
if [[ $HOST = pn* ]]||[[ $HOST = loft* ]]; then
  echo 'mac hostname: ' $HOST
  PS1='\W$ '
  alias ls='ls -G'
  alias dir='ls -tlFhG |head'
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

### LANL turquoise IC: grizzly and badger
elif [[ $HOST = gr* ]] || [[ $HOST = wf* ]] || [[ $HOST = ba* ]]; then
  echo 'IC hostname: ' $HOST
  PS1='\[\e[1;32m\]\h:\W\$\[\e[0m\] ' # bright green
  export HOMEDIR=/usr/projects/climate/mpeterse
  export QUEUETYPE=slurm
  alias mlba='module purge; module load git; source ~/repos/dotFiles/modules_badger_gnu.sh'
  alias mlgr='module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/; module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_compass.sh; echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias mlgri='module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_compass.sh; module load intel/17.0.1 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; echo "loading modules anaconda, intel, openmpi, netcdf, pnetcdf, pio for grizzly"'
  alias r2='cd /lustre/scratch2/turquoise/mpeterse/runs; pwd'
  alias r3='cd /lustre/scratch3/turquoise/mpeterse/runs; pwd'
  alias r4='cd /lustre/scratch4/turquoise/mpeterse/runs; pwd'
  alias r='cd /lustre/scratch4/turquoise/mpeterse/runs; pwd'
  alias ic='cd /usr/projects/regionalclimate/COMMON_MPAS/ocean/grids/initial_condition_database/; pwd'
  # add from mlgr for default
  module purge; module load git; module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/;module load python/anaconda-2.7-climate;module load gcc/5.3.0 openmpi/1.10.5 netcdf/4.4.1 parallel-netcdf/1.5.0 pio/1.7.2; 
  echo "loading modules anaconda, gnu, openmpi, netcdf, pnetcdf, pio for grizzly"
  alias vtk='python /turquoise/usr/projects/climate/mpeterse/repos/MPAS-Tools/master/visualization/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '
  alias py='echo "Load python for e3sm-unified"; module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_latest_e3sm_unified.sh'

  ### E3SM section ###
  export RUN_ROOT=/lustre/scratch3/turquoise/mpeterse/E3SM/cases
  export ARCHIVE_ROOT=/lustre/scratch3/turquoise/mpeterse/E3SM/archive
  alias in='cd /lustre/scratch3/turquoise/mpeterse/E3SM/input_data; pwd; ls'
  alias inu='cd /lustre/scratch3/turquoise/mpeterse/E3SM/input_data_for_uploading/E3SM/inputdata; pwd; ls'
  TARFILE="/lustre/scratch3/turquoise/mpeterse/trash/tar.tar"

  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

  # added by Miniconda2 installer
  # export PATH="/usr/projects/climate/mpeterse/software/miniconda2/bin:$PATH"
  #. /usr/projects/climate/mpeterse/software/miniconda2/etc/profile.d/conda.sh

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
  
  ### E3SM section ###
  export RUN_ROOT=/lustre/scratch3/turquoise/mpeterse/E3SM/cases
  export ARCHIVE_ROOT=/lustre/scratch3/turquoise/mpeterse/E3SM/archive
  alias in='cd /lustre/scratch3/turquoise/mpeterse/E3SM/input_data; pwd; ls'
  alias inu='cd /lustre/scratch3/turquoise/mpeterse/E3SM/input_data_for_uploading/E3SM/inputdata; pwd; ls'
  TARFILE="/lustre/scratch3/turquoise/mpeterse/trash/tar.tar"

  # see https://hpc.lanl.gov/proxy_setup
  export http_proxy="http://proxyout.lanl.gov:8080"
  export https_proxy="http://proxyout.lanl.gov:8080"
  export ftp_proxy="http://proxyout.lanl.gov:8080"
  export HTTP_PROXY="http://proxyout.lanl.gov:8080"
  export HTTPS_PROXY="http://proxyout.lanl.gov:8080"
  export FTP_PROXY="http://proxyout.lanl.gov:8080"
  export no_proxy="localhost,127.0.0.1"

### nersc: edison and cori
elif [[ $HOST = ed* ]] || [[ $HOST = cori* ]] || [[ $HOST = nid* ]]; then
  echo 'NERSC hostname: ' $HOST
  export QUEUETYPE=slurm
  PS1='\[\e[1;36m\]\h:\W\$\[\e[0m\] ' # bright blue
  TARFILE='/global/cscratch1/sd/mpeterse/trash/tar.tar'
  MODULEFILES='/global/project/projectdirs/acme/software/modulefiles/all' 

  alias r='cd $SCRATCH/runs; pwd'
  alias cs='cd $CSCRATCH/runs; pwd'
  alias inu='cd /global/cscratch1/sd/mpeterse/acme_scratch/input_data_for_upload_171113/acme/inputdata; pwd; ls'
  alias in='cd /project/projectdirs/acme/inputdata/ocn/mpas-o; pwd; ls'
  export RUN_ROOT=/global/cscratch1/sd/mpeterse/acme_scratch/cori-knl
  export ARCHIVE_ROOT=/scratch1/scratchdirs/mpeterse/E3SM/archive
  alias anre='echo "cd to analysis repo"; cd /global/homes/m/mpeterse/repos/analysis/develop_180430;pwd;ls'
  alias ans='echo "cd to analysis results"; cd /global/cscratch1/sd/mpeterse/analysis/; pwd;ls'
  alias anh='echo "cd to analysis html dir"; cd /global/project/projectdirs/m2833/www/mpas_analysis_output/; pwd; ls'
  alias vtk='python /global/homes/m/mpeterse/repos/MPAS-Tools/MPAS-Tools/python_scripts/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '
  alias se='cd /global/cscratch1/sd/mpeterse/repos/e3sm; pwd; ls'
  alias py='echo "Load python for e3sm-unified"; module unload python; source /global/project/projectdirs/acme/software/anaconda_envs/load_latest_e3sm_unified.sh'

### Argonne: theta
elif [[ $HOST = theta* ]]; then
  echo 'theta hostname: ' $HOST
  PS1='\[\e[1;34m\]\h:\W\$\[\e[0m\] ' # blue
  export QUEUETYPE=pbs
  export RUN_ROOT=/projects/OceanClimate_2/mpeterse
  TARFILE='/projects/OceanClimate_2/mpeterse/trash/tar.tar'
  MODULEFILES='/lus/theta-fs0/projects/ccsm/acme/tools/modulefiles'
  alias in='cd /projects/OceanClimate_2/acme/inputdata; pwd; ls'
  alias r='cd $RUN_ROOT/runs; pwd'
  alias anre='echo "cd to analysis repo"; cd /home/mpeterse/repos/analysis/develop_180430;pwd;ls'
  alias ans='echo "cd to analysis results"; cd /projects/OceanClimate_2/mpas_analysis_output; pwd;ls'
  alias anh='echo "cd to analysis html dir"; cd /projects/OceanClimate_2/mpas_analysis_html; pwd; ls'
  alias py='module unload python e3sm-unified; source /lus/theta-fs0/projects/ccsm/acme/tools/e3sm-unified/load_latest_e3sm_unified.sh'

### Oak Ridge: titan and EOS
elif [[ $HOST = titan* ]] || [[ $HOST = eos* ]] || [[ $HOST = rhea* ]]; then
  echo 'Oak Ridge hostname: ' $HOST
  export QUEUETYPE=pbs
  PS1='\[\e[1;33m\]\h:\W\$\[\e[0m\] ' # yellow
  export RUN_ROOT=/lustre/atlas/scratch/mpetersen/cli127
  alias inu='cd /ccs/home/mpetersen/input_data_for_uploading; pwd; ls'
  TARFILE="/lustre/atlas2/cli127/scratch/mpetersen/trash/tar.tar"
  MODULEFILES='/ccs/proj/cli900/sw/rhea/modulefiles/all'
  alias anre='echo "cd to analysis repo"; cd /ccs/home/mpetersen/repos/analysis/develop_180430;pwd;ls'
  alias ans='echo "cd to analysis results"; cd /lustre/atlas/scratch/mpetersen/cli127/analysis; pwd;ls'
  alias anh='echo "cd to analysis html dir"; cd /lustre/atlas/scratch/mpetersen/cli127/mpas-analysis_html; pwd; ls'
  module load git
  module load python
  alias anre='echo "cd to analysis repo"; cd /ccs/home/mpetersen/repos/analysis/develop_180424;pwd;ls'
  alias ans='echo "cd to analysis results"; cd /lustre/atlas/scratch/mpetersen/cli127/analysis; pwd;ls'
  alias anh='echo "cd to analysis html dir"; cd /lustre/atlas/scratch/mpetersen/cli127/mpas_analysis_html; pwd; ls'
  alias py='echo "Load python for e3sm"; module unload python python/base; module use /global/project/projectdirs/acme/software/modulefiles/all; module load e3sm-unified/1.1.2'

### Oak Ridge: anvil and blues
elif [[ $HOST = anvil* ]] || [[ $HOST = blogin* ]]; then
  echo 'Argonne hostname: ' $HOST
  export QUEUETYPE=pbs
  PS1='\[\e[1;35m\]\h:\W\$\[\e[0m\] ' # maroon
  export RUN_ROOT=/lcrc/group/acme/mpeterse/acme_scratch/
  alias py='echo "Load python for e3sm"; source /lcrc/soft/climate/e3sm-unified/base/etc/profile.d/conda.sh; conda activate e3sm_unified_1.2.2_py2.7_nox; unset LD_LIBRARY_PATH'
  alias anre='echo "cd to analysis repo"; cd /home/mpeterse/repos/analysis/develop_180430; pwd; ls'
  alias ans='echo "cd to analysis results"; cd /lcrc/group/acme/mpeterse/analysis; pwd; ls'
  alias anh='echo "cd to analysis html dir"; cd /lcrc/group/acme/mpeterse/mpas_analysis_html; pwd; ls'
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
alias b='cd $HOMEDIR/repos/model; pwd; dir'
alias o='cd $HOMEDIR/repos/model/ocean_develop; pwd'
alias ma='cd $HOMEDIR/repos/analysis; pwd; dir'
alias mt='cd $HOMEDIR/repos/tools; pwd; dir'
alias mtm='cd $HOMEDIR/repos/tools/master/grid_gen/mesh_conversion_tools; pwd; dir'
alias md='cd $HOMEDIR/repos/documents; pwd; dir'
alias mq='cd $HOMEDIR/repos/quickviz; pwd; dir'
alias dot='cd $HOMEDIR/repos/dotFiles; pwd'
alias linter='$HOMEDIR/repos/tools/master/source_code_processing/mpas_source_linter/mpas_source_linter.py'
alias vtk='python ${HOMEDIR}/repos/tools/master/visualization/paraview_vtk_field_extractor/paraview_vtk_field_extractor.py  -v allOnCells -d nVertLevels=0 maxEdges=0 '

E3SM_ROOT=$HOMEDIR/repos/E3SM
CASE_ROOT=$HOMEDIR/e3sm_cases

# git aliases
alias g='git log --graph --oneline -n 12'
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
alias ggin="echo 'git grep -in '; git grep -in "

# e3sm aliases
alias e='cd $HOMEDIR/repos/E3SM; echo "cd to E3SM_ROOT:" `pwd`; ls'
alias cr='cd $CASE_ROOT; echo "cd to CASE_ROOT:" `pwd`'
alias rr='cd $RUN_ROOT; echo "cd to RUN_ROOT:" `pwd`'

# unix aliases
alias ex='exit'
alias h='history'
alias m='less'
alias cdd='cd \!*; ls'
alias space='du -m | sort -n'
alias grep='grep -d skip --color=always'

# login and tar aliases
alias oceans11="ssh mpetersen@oceans11-insider.lanl.gov; echo 'ssh mpetersen@oceans11-insider.lanl.gov then cd /raid/mpas_data/initial_condition_database'"
# CCS server
alias toccs='scp ~/a/tar.tar mpeterse@ccscs8.lanl.gov:/home/mpeterse/a'
alias tccs='scp mpeterse@ccscs8.lanl.gov:/home/mpeterse/a/tar.tar .; tar xvf tar.tar; rm tar.tar'
alias ccs='ssh mpeterse@ccscs8.lanl.gov'
# LANL IC
alias tt="scp mpeterse@wtrw.lanl.gov:mpeterse@gr-fe.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar"
alias tba="scp mpeterse@wtrw.lanl.gov:mpeterse@ba-fe.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar .; tar xvf tar.tar; rm -f tar.tar"
alias tot=" echo 'sending tar.tar to turqoise'; scp $TARFILE mpeterse@wtrw.lanl.gov:mpeterse@gr-fe.lanl.gov:/lustre/scratch3/turquoise/mpeterse/trash/tar.tar;"
alias gr='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@gr-fe'
alias ba='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@ba-fe'
alias wf='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@wf-fe'
alias sn='ssh -tX mpeterse@sn-fey1.lanl.gov'
alias darwin='ssh darwin-fe.lanl.gov'
alias gpfs='ssh -tX mpeterse@wtrw.lanl.gov ssh ar-tn'
alias ar='ssh -tX mpeterse@wtrw.lanl.gov ssh mpeterse@ar-tn'
# NERSC
alias ed='ssh -Y mpeterse@edison.nersc.gov'
alias cori='ssh -Y mpeterse@cori.nersc.gov'
alias ted='scp mpeterse@edison.nersc.gov:/global/cscratch1/sd/mpeterse/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias tcori='scp mpeterse@cori.nersc.gov:/global/cscratch1/sd/mpeterse/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias toed='scp ~/a/tar.tar mpeterse@edison.nersc.gov:a/tar.tar'
# Oak Ridge
alias eos='ssh mpetersen@eos.ccs.ornl.gov'
alias rhea='ssh mpetersen@rhea.ccs.ornl.gov'
alias titan='ssh mpetersen@titan.ccs.ornl.gov'
alias ttitan='scp mpetersen@titan.ccs.ornl.gov:/lustre/atlas2/cli127/scratch/mpetersen/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias totitan='scp ~/a/tar.tar mpetersen@titan.ccs.ornl.gov:/lustre/atlas1/cli127/proj-shared/mpetersen/trash/tar.tar'
# Argonne
alias theta='ssh mpeterse@theta.alcf.anl.gov'
alias anvil='ssh mpeterse@blues.lcrc.anl.gov'
alias ttheta='scp mpeterse@theta.alcf.anl.gov:/projects/OceanClimate_2/mpeterse/trash/tar.tar .;tar xvf tar.tar; rm -f tar.tar'

# other logins
alias tacc='echo "stampede2 at tacc. cd into stampede2.tacc.utexas.edu"; ssh mpeterse@stampede2.tacc.utexas.edu'
alias blues='ssh mpeterse@blues.lcrc.anl.gov'
alias bl='ssh mpeterse@blues.lcrc.anl.gov'
alias tbl='scp mpeterse@blues.lcrc.anl.gov:a/tar.tar .;tar xvf tar.tar; rm -f tar.tar'
alias totacc='scp ~/a/tar.tar stampede2.tacc.utexas.edu:~/a/tar.tar'

# taring aliases
alias t="echo 'tarring the following files to $TARFILE'; tar cvf $TARFILE"
alias unt="echo '** Untarring from $TARFILE'; tar xvf $TARFILE"

# alias to change directory
alias c='rm -f ~/a/pwd_file; export d=`pwd`; echo `pwd` > ~/a/pwd_file; echo "put pwd in a/pwd_file:";pwd'
alias d='export d=`cat ~/a/pwd_file`; cd $d; echo "cd to"; pwd'

