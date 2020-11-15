#!/usr/bin/env bash

echo "Loading modules for grizzly intel19"
module purge
module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/scorpio
module load friendly-testing
module load intel/19.0.4 intel-mpi/2019.4 hdf5-parallel/1.8.16 pnetcdf/1.11.2 netcdf-h5parallel/4.7.3 mkl/2019.0.4 pio2/1.10.1
# note: if you already did this:
#  module use /usr/projects/climate/SHARED_CLIMATE/modulefiles/all/
# then it will show 'no such file' for hdf5-parallel/1.8.16. 
# solution: log into a new node and try with only the commands above.
export I_MPI_CC=icc
export I_MPI_CXX=icpc
export I_MPI_F77=ifort
export I_MPI_F90=ifort
