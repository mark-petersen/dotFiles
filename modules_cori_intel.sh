
source /global/cfs/cdirs/e3sm/software/anaconda_envs/load_latest_compass.sh

module rm intel
module load intel/18.0.1.163
module load cray-mpich/7.7.6
module load cray-hdf5-parallel/1.10.2.0
module load cray-netcdf-hdf5parallel/4.6.1.3
module load cray-parallel-netcdf/1.8.1.4
export PIO_VERSION=1.10.1
export PIO=/global/homes/m/mpeterse/libraries/pio-${PIO_VERSION}-intel

