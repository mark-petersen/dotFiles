#!/usr/bin/env bash

echo "Loading modules for badger gnu"
## badger modules ###
module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/spack-lmod/linux-rhel7-x86_64
#module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_latest_compass.sh;
# IC mods
module load gcc/6.4.0
module load openmpi/2.1.2
module load cmake/3.12.1
module load mkl
 
# spack mods
 module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/netcdf/4.4.1.1-zei2j6r
 module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/netcdf-fortran/4.4.4-v6vwmxs
 module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/parallel-netcdf/1.8.0-2qwcdbn
 module load openmpi/2.1.2-bheb4xe/gcc/6.4.0/pio/1.10.0-ljj73au
  
# spack mods aren't setting these correctly yet...
#export NETCDF=/usr/projects/climate/SHARED_CLIMATE/software/badger/spack-install/linux-rhel7-x86_64/gcc-6.4.0/netcdf-4.4.1.1-zei2j6rxcor4chgmgbcwlx37lb3khz7t
  export NETCDF=/usr/projects/climate/SHARED_CLIMATE/software/badger/spack-install/linux-rhel7-x86_64/gcc-6.4.0/netcdf-fortran-4.4.4-v6vwmxsv33t7pmulojlijwdbikrvmwkc
  export PNETCDF=/usr/projects/climate/SHARED_CLIMATE/software/badger/spack-install/linux-rhel7-x86_64/gcc-6.4.0/parallel-netcdf-1.8.0-2qwcdbnjcq5pnkoqpx2s7um3s7ffo3xd
  export PIO=/usr/projects/climate/SHARED_CLIMATE/software/badger/spack-install/linux-rhel7-x86_64/gcc-6.4.0/pio-1.10.0-ljj73au6ctgkwmh3gbd4mleljsumijys/
