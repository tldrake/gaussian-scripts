#!/bin/sh -x

#project='/project/wenbinlin/tasha'

#`ls -l *.com| awk '{print $9}' |sed 's/.fchk//g' > file_list`

#echo "%mem=6GB" > head
#echo "%nproc=2" >>head
#echo "# opt=(modredundant,tight) rm062x/aug-cc-pvdz scf=xqc density=current int=grid=ultrafine nosymm iop(5/33=1) " >>head
#echo " " >>head
#echo "C2H6 cluster stable structure search" >> head
#echo " ">>head
#echo "0 1" >>head

#$1 is .com file from gaussian_restart.sbatch
base_name=$(echo $1 | cut -d '.' -f 1)


#cat $file_list|while read each_file
#do
#first restart
#cd $each_file
seq_no=$(echo $base_name | cut -d '_' -f 1)
seq_no=$(($seq_no+1))
new_file=$(echo $base_name | sed -E "s/[0-9]+/$seq_no/")
cp $base_name.com $new_file.com
cp $base_name.chk $new_file.chk
#sed -i "s?chk\\=?chk\\=$(pwd)\/?" $new_file.com
#sed -i "s/\.chk/\.chk\n\%chk=$new_file.chk/" $new_file.com
sed -i "s/$base_name/$new_file/" $new_file.com
sed -i 's/opt /opt=restart /' $new_file.com
echo "$new_file"
#mv $new_file.com $project/
#mv $new_file.chk $project/
#cd ..

#done
