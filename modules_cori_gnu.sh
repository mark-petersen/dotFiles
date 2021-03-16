module purge
module load PrgEnv-gnu
module load cray-netcdf-hdf5parallel
module load cray-parallel-netcdf
module load cmake
module load git
source /global/project/projectdirs/e3sm/software/anaconda_envs/load_latest_e3sm_unified.sh
export PIO=/global/u2/h/hgkang/my_programs/Scorpio

# debug:
#make gnu-nersc CORE=ocean USE_PIO2=true OPENMP=false DEBUG=true GEN_F90=true
