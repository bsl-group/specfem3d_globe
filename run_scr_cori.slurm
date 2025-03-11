#!/bin/bash
#SBATCH --job-name comp_solv
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=48
#SBATCH --time=03:20:00
#SBATCH --output job_%j.log
#SBATCH --error job_%j.err
#SBATCH --verbose
#SBATCH --qos=regular
#SBATCH --constraint=haswell


# compute total number of nodes needed
NPROC_XI=`grep ^NPROC_XI DATA/Par_file | cut -c 34- `
NPROC_ETA=`grep ^NPROC_ETA DATA/Par_file | cut -c 34- `
NCHUNKS=`grep ^NCHUNKS DATA/Par_file | cut -c 34- `

# total number of nodes is the product of the values read
numnodes=$(( $NCHUNKS * $NPROC_XI * $NPROC_ETA ))

RUN_ARGS="-n ${numnodes}"

echo "Running on: $SLURM_NODELIST"
echo "SLURM_NTASKS=$SLURM_NTASKS"
echo "SLURM_NTASKS_PER_NODE=$SLURM_NTASKS_PER_NODE"
echo "SLURM_NNODES=$SLURM_NNODES"


run_mesh=true
run_solver=true

echo Time is `TZ="America/Los_Angeles" date`

if [ "$run_mesh" = true ]; then
echo ">>>> Running Mesh `TZ="America/Los_Angeles" date`"
start=`date +%s`
# Running Mesher
srun $RUN_ARGS ./bin/xmeshfem3D
end=`date +%s`
runtime=$((end-start))
echo "---> Mesher run time is $runtime seconds"
fi

if [ "$run_solver" = true ]; then
echo ">>>> Running Spec `TZ="America/Los_Angeles" date`"
start=`date +%s`
# Running simulation 
srun $RUN_ARGS ./bin/xspecfem3D
end=`date +%s`
runtime=$((end-start))
echo "---> Solver run time is $runtime"
fi
