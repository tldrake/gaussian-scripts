#!/bin/bash
#SBATCH --partition=sandyb
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --constraint=ib
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=tdrake@uchicago.edu
#SBATCH	-t 24:00:00

# make a directory with filename $1 only if it doesn't exist (-p) 

#current_folder=$(pwd)
com_file=$1
project_folder=/project/wenbinlin/tasha
#chk_file=$1.chk
#folder_name=$1

#create folder hierarchy based on .com file name

#source ./mkh.sh $folder_name
#remove the numeric prefix from file name

#folder_name=$(echo $1 | sed 's/[1-9]_//')

#mkdir -p $folder_name

#mv $current_folder/$com_file $folder_name

#if [ -f $current_folder/$chk_file ] ; then mv $current_folder/$chk_file $folder_name; fi  

#cd $folder_name

# first 

sbatch --dependency=afternotok:$SLURM_JOBID --job-name=$SLURM_JOB_NAME  $project_folder/gaussian_restart.sbatch $project_folder


g09 $com_file

