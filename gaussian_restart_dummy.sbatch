#!/bin/bash
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --exclusive
##SBATCH --constraint=ib
##SBATCH --mail-type=end
##SBATCH --mail-type=fail
#SBATCH --mail-user=tdrake@uchicago.edu
#SBATCH	-t 00:02:00

root_folder=$1
log_file=$(ls -tr *.log | tail -n 1)	
result=$(tail $log_file | egrep "Normal | Error")

com_file=$(ls -tr *.com | tail -n 1)

new_file=$(sh $root_folder/restart2.sh $com_file)
new_com_file=$new_file.com

sbatch --dependency=afternotok:$SLURM_JOBID --job-name=$SLURM_JOB_NAME $root_folder/gaussian_restart_dummy.sbatch $root_folder

sleep 30

if [ -z "$result" ] ; then

    g09 $new_com_file
fi

