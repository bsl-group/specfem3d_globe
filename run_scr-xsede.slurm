#!/bin/bash
#SBATCH --job-name RUN11
#SBATCH --time=02:40:00
#SBATCH --partition=skx-normal
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=48
#SBATCH --verbose
#SBATCH --exclusive
#SBATCH --error job_%j.err
#SBATCH --output job_%j.log
#SBATCH --mail-type=all
#SBATCH --mail-user=d.soergel@berkeley.edu
#SBATCH --mail-type=BEGIN,END,ERROR


# compute total number of nodes needed
NPROC_XI=`grep ^NPROC_XI DATA/Par_file | cut -c 34- `
NPROC_ETA=`grep ^NPROC_ETA DATA/Par_file | cut -c 34- `
NCHUNKS=`grep ^NCHUNKS DATA/Par_file | cut -c 34- `

# total number of nodes is the product of the values read
numnodes=$(( $NCHUNKS * $NPROC_XI * $NPROC_ETA ))
echo "Num of processes: $numnodes"
SRUN_ARGS="-n $numnodes"


# module purge
# module load shared gcc/6.3.0 openmpi-2.1.1/gcc-6.3.0 slurm 
# module load shared slurm/17.02.10 intel/compiler/64/15.0/1.133 openmpi/intel/64/1.10.3

echo "Running on: $SLURM_NODELIST"
echo "SLURM_NTASKS=$SLURM_NTASKS"
echo "SLURM_NTASKS_PER_NODE=$SLURM_NTASKS_PER_NODE"
echo "SLURM_NNODES=$SLURM_NNODES"


echo Time is `TZ="America/Los_Angeles" date`
. par.inp

if [ -d "$meshloc" ]
then
if [ -L "$binloc/OUTPUT_FILES/addressing.txt" ] && [ -e "$binloc/OUTPUT_FILES/addressing.txt" ]
then 
    echo "Links already exist: $binloc/OUTPUT_FILES/addressing.txt"
else
    ln -s $meshloc .
    ln -s $binloc/OUTPUT_FILES/addressing.txt OUTPUT_FILES/.
    ln -s $binloc/OUTPUT_FILES/output_mesher.txt OUTPUT_FILES/.
    ln -s $binloc/OUTPUT_FILES/values_from_mesher.h OUTPUT_FILES/.
fi
else
echo ">>>> Running Mesh `TZ="America/Los_Angeles" date`"
start=`date +%s`
# Running Mesher
ibrun $SRUN_ARGS ${binloc}/bin/xmeshfem3D
#srun $SRUN_ARGS ${binloc}/bin/xmeshfem3D
end=`date +%s`
runtime=$((end-start))
echo "---> Mesher run time is $runtime"
fi

echo ">>>> Running Spec `TZ="America/Los_Angeles" date`"
start=`date +%s`
# Running simulation
#mpiexec $SRUN_ARGS ./bin/xspecfem3D
ibrun $SRUN_ARGS ${binloc}/bin/xspecfem3D
#srun $SRUN_ARGS ${binloc}/bin/xspecfem3D
end=`date +%s`
runtime=$((end-start))
echo "---> Solver run time is $runtime"
