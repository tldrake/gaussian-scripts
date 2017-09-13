#!/bin/bash
#SBATCH --partition=broadwl
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --constraint=ib
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --mail-user=tdrake@uchicago.edu
#SBATCH	-t 36:00:00

# make a directory with filename $1 only if it doesn't exist (-p) 
mkdir -p  $1

mv $1.com $1

if [ -f $1.chk ] ; then mv $1.chk $1; fi  

cd $1

g09 $1.com





#Search for string 1 and replace with string 2

# :%s/String1/String2/g






