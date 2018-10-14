#!/bin/bash

for dir in E:/Data_Extracted/*; do

    echo ${dir##*/}
    echo -n "Proceed? [y/n]: "
    
    read -n 1 ans 
    echo $ans
    
    if [$"ans" = "y"]; then 
        temp = ${dir##*/}; 
        mp3wrap dir/$temp.mp3 dir/*.mp3;
    
done
    