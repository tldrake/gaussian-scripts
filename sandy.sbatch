#!/bin/bash
#SBATCH -J 1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --constraint=ib
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=tdrake@uchicago.edu
#SBATCH	-t 36:00:00


mkdir  1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate

mv 1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate.com 1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate 


cd 1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate

g09 1_Ti8_Co-ClTHF_neg3-4_b3lyp-6311g_opt_CoClTHFbridgeO_free_12formate.com





#Search for string 1 and replace with string 2

# :%s/String1/String2/g






