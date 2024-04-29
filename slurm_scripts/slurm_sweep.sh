#!/bin/bash

# Check if at least three arguments are provided
if [ $# -lt 3 ]; then
    echo "Usage: $0 <num_nodes> <sweep_id> <zip_file_path> [sbatch_options...]"
    exit 1
fi

NUM_NODES=$1
SWEEP_ID=$2
ZIP_FILE_PATH=$3
GPU_PER_NODE=${4:-4}  # Default to 4 GPUs per node
shift 3  # Remove the first three arguments, leaving any additional sbatch options

# Loop to submit the job NUM_NODES times
for (( i=0; i<$NUM_NODES; i++ ))
do
    # Pass all remaining arguments directly to sbatch
    sbatch "$@" --nodes="1" run_sweep.sh $SWEEP_ID $ZIP_FILE_PATH $GPU_PER_NODE
    echo "Submitted job $(($i + 1)) of $NUM_NODES"
done
