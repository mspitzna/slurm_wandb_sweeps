# Overview slurm_wandb_sweeps

This repository is designed to facilitate the deployment and execution of distributed machine learning model training sweeps on the Horeka cluster, utilizing SLURM for job scheduling and Weights & Biases (WandB) for experiment tracking. It specifically handles multiple parallel training runs, leveraging the capabilities of multiple GPUs across different nodes.

## Scripts and Usage

### `slurm_sweep.sh`

This bash script automates the submission of multiple SLURM jobs, where each job corresponds to a training run defined within a WandB sweep. It allows specifying the number of GPUs per node.

**Usage:**
```
./slurm_sweep.sh <num_nodes> <sweep_id> <zip_file_path> [sbatch_options...]
```
**Arguments:**
- `<num_nodes>`: Number of nodes to deploy for the sweeps.
- `<sweep_id>`: Identifier for the WandB sweep.
- `<zip_file_path>`: Path to the zip file containing the data or resources for training.
- `[sbatch_options...]`: Additional SBATCH options as needed.

### `run_sweep_node.sh`

Executed by `slurm_sweep.sh` for each SLURM job submission, this script sets up the environment, manages data unzipping, and initiates the WandB agents for each specified GPU.

**Usage:**
TODO

## Data Handling and Environment

Configured for the Horeka cluster:
- Initial data is contained within a zip file and is extracted to the temporary directory (`$TMPDIR`) on each node for faster processing during the sweep.
- Data persistence and output management after processing must be handled by the executed Python script included in the sweep, which should ensure that data is written back to a persistent storage location (`$HOME / $PROJECT`).
