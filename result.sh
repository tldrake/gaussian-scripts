#!/bin/sh -x

#input_file will have .log extension

input_file=$1
base_name=$(basename $input_file .log)

# Details of calculation and summary of steps are put into steps_filename.txt

echo "$input_file" > steps_$base_name.txt
echo " " >> steps_$base_name.txt
grep -A 1 '^ #' $input_file >> steps_$base_name.txt
echo " " >> steps_$base_name.txt
grep 'Charge = ' $input_file | head -n 1 >> steps_$base_name.txt
echo " " >> steps_$base_name.txt

egrep 'out of|SCF Don|Converged| NO |YES|exceeded' $input_file >> steps_$base_name.txt

#Table of NBO charges is created in charge_filename.txt

echo "$input_file" > charge_$base_name.txt
echo " " >> charge_$base_name.txt
grep -A 1 '^ #' $input_file >> charge_$base_name.txt
echo " " >> charge_$base_name.txt
grep 'Charge = ' $input_file | head -n 1 >> charge_$base_name.txt
echo " " >> charge_$base_name.txt

# Define when  optimization is complete
limit=$(grep 'Stationary point' $input_file -n | cut -d: -f 1)

#charge=$(grep 'Charge = ' $input_file | awk '{print $3}')
#Charge = $2 since restart files don't recall the charge

charge=$2

noNBO=$(grep "Summary of Natural" $input_file) 

if [ -z "$noNBO" ] ; then 
	echo "no NBO anaylsis" | tee -a charge_$base_name.txt; 
else
# Look for keyword Summary of Natural to find table after optimization
start=$(tail -n +$limit $input_file | grep 'Summary of Natural' -n | head -n 1 | cut -d: -f 1)
# Start of table
start=$(($start+$limit-1))
# end of table
end=$(grep ' Total ' $input_file -n | grep -- "$charge.00000" | tail -n1 | cut -d: -f 1)

sed -n "$start,${end}p" $input_file >> charge_$base_name.txt

fi 
# Table of Spin densitie sis created in spin_filename.txt

echo "$input_file" > spin_$base_name.txt
echo " " >> spin_$base_name.txt
grep -A 1 '^ #' $input_file >> spin_$base_name.txt
echo " " >> spin_$base_name.txt
grep 'Charge = ' $input_file| head -n 1 >> spin_$base_name.txt
echo " " >> spin_$base_name.txt


start=$(grep 'Mulliken atomic spin dens' $input_file -n | grep -v 'Sum' | tail -n1 | cut -d: -f 1)

end=$(grep 'Sum of Mulliken atomic spin' $input_file -n | tail -n1 | cut -d : -f 1)

if [ ! -z $start ] ; then
    sed -n $start,${end}p $input_file >> spin_$base_name.txt
fi
# Table of thermochemistry data

echo "$input_file" > freq_$base_name.txt
echo " " >> freq_$base_name.txt
grep -A 1 '^ #' $input_file >> freq_$base_name.txt
echo " " >> freq_$base_name.txt
grep 'Charge = ' $input_file | head -n 1 >> freq_$base_name.txt
echo " " >> freq_$base_name.txt

grep "Stoichiometry" $input_file | head -n 1 >> freq_$base_name.txt
echo " " >> freq_$base_name.txt

# look for thermochemistry and print out 2 lines after thermochemistry and print that whole line
grep "Thermochemistry" -A 2 $input_file | tail -n1 >> freq_$base_name.txt
echo " " >> freq_$base_name.txt
grep "Molecular mass" $input_file >> freq_$base_name.txt
echo " " >> freq_$base_name.txt
grep -A 1 "Zero-point vibrational energy" $input_file | tr -d '\n' | tr -s " " >> freq_$base_name.txt
echo " " >> freq_$base_name.txt
echo " " >> freq_$base_name.txt

grep "SCF Done" $input_file | tail -n 1 >> freq_$base_name.txt
echo " " >> freq_$base_name.txt
grep -A 8 "Zero-point correction" $input_file >> freq_$base_name.txt


