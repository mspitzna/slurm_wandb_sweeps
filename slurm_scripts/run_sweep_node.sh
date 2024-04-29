#!/bin/bash
#SBATCH --job-name=wandb-sweep
#SBATCH --nodes=1                 # Request 1 node
#SBATCH --ntasks=1  # Start with a default of 1 task
#SBATCH --gres=gpu:4              # 4 GPUs per node
#SBATCH --output=sweep-%j.out

# Activate your conda environment
source activate pytorch

# Check if both sweep ID and zip file path are provided
if [ -z "$1" ]; then
    echo "Error: Sweep ID not provided."
    exit 1
fi
if [ -z "$2" ]; then
    echo "Error: Zip file path not provided."
    exit 1
fi
if [ -z "$3" ]; then
    echo "Error: Number of GPUs per node not provided."
    exit 1
fi

SWEEP_ID=$1
ZIP_FILE=$2
GPU_PER_NODE=$3

# Unzip the file into the node-specific temporary directory
echo "Unzipping $ZIP_FILE into $TMPDIR"
unzip $ZIP_FILE -d $TMPDIR/

# Start the WandB agents, one for each GPU
for (( i=0; i<$GPU_PER_NODE; i++ ))
do
    CUDA_VISIBLE_DEVICES=$i wandb agent $SWEEP_ID &
done

wait  # Wait for all background processes to finish
