#!/bin/sh -x

my_date=$(date +%m_%d_%y_%H_%M_%S)

# retrieves all .com files and removes the .com extension and puts into a file named "file_list

`ls *.com| sed 's/.com//g' > file_list_$my_date`

cat file_list_$my_date|while read each_file
do

sbatch --job-name=$each_file gaussian_dummy.sbatch $each_file

done
# /bin/rm file_list 
