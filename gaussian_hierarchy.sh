#!/bin/sh -x

#$1 is .com file from gaussian_restart.sbatch
base_name=$(echo $1 | cut -d '.' -f 1)

#increament the step number of .com file to create new .com and .chk files
seq_no=$(echo $base_name | cut -d '_' -f 7)
seq_no=$(($seq_no+1))

new_file=$(echo $base_name | sed -E "s/[0-9]_of/${seq_no}_of/")
cp $base_name.com $new_file.com
cp $base_name.chk $new_file.chk
#update the .chk file name in the .com file
sed -i "s/$base_name/$new_file/" $new_file.com
#update the opt section .com file
new_line=$(grep ${seq_no}_of ${new_file}.com | tail -n 1| cut -d# -f 2)
if [ -z "$new_line" ] ; then
    echo "${seq_no}_of does not exist in ${new_file}.com"
    exit 1
fi
#using ? instead of / to avoid probelm with freq and opt lines
sed -i "s?^#.*?#${new_line}?" $new_file.com

#copy new .com file to root of /project

cp ${new_file}.com ~/tasha
cp ${new_file}.chk ~/tasha
