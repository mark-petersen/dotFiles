#!/usr/bin/env bash

echo "Loading modules for grizzly intel19"

#source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/base/etc/profile.d/conda.sh
#conda activate test_compass_1.0

module purge
module load friendly-testing
module load intel/19.0.4 intel-mpi/2019.4 hdf5-parallel/1.8.16 pnetcdf/1.11.2 netcdf-h5parallel/4.7.3 mkl/2019.0.4
export NETCDF=/usr/projects/hpcsoft/toss3/grizzly/netcdf/4.7.3_intel-19.0.4_intel-mpi-2019.4_hdf5-1.8.16
export PNETCDF=/usr/projects/hpcsoft/toss3/grizzly/pnetcdf/1.11.2_intel-19.0.4_intel-mpi-2019.4_hdf5-1.8.16
export PIO=/usr/projects/climate/xylar/libraries/grizzly/scorpio-1.1.6-intel

module unload python; source /usr/projects/climate/SHARED_CLIMATE/anaconda_envs/load_latest_compass.sh
