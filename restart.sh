#!/bin/sh -x

project='/project/wenbinlin/tasha'

#`ls -l *.com| awk '{print $9}' |sed 's/.fchk//g' > file_list`

#echo "%mem=6GB" > head
#echo "%nproc=2" >>head
#echo "# opt=(modredundant,tight) rm062x/aug-cc-pvdz scf=xqc density=current int=grid=ultrafine nosymm iop(5/33=1) " >>head
#echo " " >>head
#echo "C2H6 cluster stable structure search" >> head
#echo " ">>head
#echo "0 1" >>head

cat $1|while read each_file
do
#first restart
cd $each_file
seq_no=$(echo $each_file | cut -d '_' -f 1)
seq_no=$(($seq_no+1))
new_file=$(echo $each_file | sed "s/[1-9]/$seq_no/")
cp $each_file.com $new_file.com
cp $each_file.chk $new_file.chk
#sed -i "s?chk\\=?chk\\=$(pwd)\/?" $new_file.com
#sed -i "s/\.chk/\.chk\n\%chk=$new_file.chk/" $new_file.com
sed -i "s/$each_file/$new_file/" $new_file.com
sed -i 's/opt /opt=restart /' $new_file.com
sed -i 's/geom=connectivity /geom=allcheck /' $new_file.com
mv $new_file.com $project/
mv $new_file.chk $project/
cd ..

done
