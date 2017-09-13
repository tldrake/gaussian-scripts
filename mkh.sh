#!/bin/bash

file_name=$1

project=$(echo $file_name | cut -d '_' -f 2)
complex=$(echo $file_name | cut -d '_' -f 3)
metal=$(echo $complex | cut -d '-' -f 1)
species=$(echo $complex | sed 's/-//')
charge_multi=$(echo $file_name | cut -d '_' -f 4)
func_basis=$(echo $file_name | cut -d '_' -f 5)

mkdir -p $project/$metal/$species/$charge_multi/$func_basis
#mv $1.com $project/$metal/$species/$charge_multi/$func_basis
#mv $1.chk $project/$metal/$species/$charge_multi/$func_basis
cd $project/$metal/$species/$charge_multi/$func_basis

