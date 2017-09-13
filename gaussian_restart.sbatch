#!/bin/bash
#SBATCH --partition=sandyb
#SBATCH --nodes=1
#SBATCH --exclusive
##SBATCH --constraint=ib
##SBATCH --mail-type=end
##SBATCH --mail-type=fail
##SBATCH --mail-user=tdrake@uchicago.edu
#SBATCH	-t 0:03:00

root_folder=$1
log_file=$(ls -tr *.log | tail -n 1)
#If Noraml does not show up in the last line of the log file, we keep running
result_normal=$(tail $log_file | grep "Normal")
result_error=$(grep "Error" $log_file)


com_file=$(ls -tr *.com | tail -n 1)

new_file=$(sh $root_folder/restart2.sh $com_file)
new_com_file=$new_file.com

sbatch --dependency=afternotok:$SLURM_JOBID --job-name=$SLURM_JON_NAME $root_folder/gaussian_restart.sbatch $root_folder 
#give some time to copy the .chk file
sleep 30

#if the previous run did not finish b/c of timeout
if [[ -z "$result_normal" ]] && [[ -z "$result_error" ]] ; then

    g09 $new_com_file
    
elif [ ! -z "$result_normal" ] ; then
# create new .com and .chk and copy to root of /project
    sh gaussian_hierarchy.sh 
    if [ $? == 0 ] ; then
        cd ~/tasha
        sh ./submit.sh
    fi
fi

