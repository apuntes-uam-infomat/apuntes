#!/bin/bash

#Variables
fiext="aux log synctex.gz idx ilg ind out toc"
fiextarray=( $fiext )
finum=${#fiextarray[@]}
wd=`pwd`
noneflag=true

#Functions.
rmauxcheck(){

	for i in `seq 0 $(( $finum-1 ))`
		do
			count=`ls -1 *.${fiextarray[i]} 2>/dev/null | wc -l`
			if [ $count != 0 ]
			then
				noneflag=false
				break
			fi
		done
}

rmaux(){
	for i in `seq 0 $(( $finum-1 ))`
		do
			count=`ls -1 *.${fiextarray[i]} 2>/dev/null | wc -l`
			if [ $count != 0 ]
			then
				ls -1 *.${fiextarray[i]} | awk '{for(i=1; i<=NF; i++) print "\t", $i, "\t\tRemoved"}'
				rm *.${fiextarray[i]}
			fi
		done
}

#Question
read -p "Remove auxiliar TeX files at $wd [Y/n]: " -n 1 reply

#Reply
while true
do
	if [ -z $reply ] || [[ $reply = [Yy] ]]
	then
		echo
		echo "Removing auxiliar TeX files:"
		rmauxcheck
		if $noneflag
		then 
			echo "There are not auxiliar files."
		else
			rmaux
		fi
		break
	elif [[ $reply = [Nn] ]]
	then
		echo
		echo "Cancelled."
		exit
	else 
		echo
		read -p "Wrong option. Remove auxiliar TeX files at $wd [Y/n]: " -n 1 reply
	fi
done

reply=0
read -p "Remove PDF files too? [Y/n]: " -n 1 reply

while true
do
	if [ -z $reply ] || [[ $reply = [Yy] ]]
	then
		echo
		count=`ls -1 *.pdf 2>/dev/null | wc -l`
		if [ $count != 0 ]
		then
			ls -1 *.pdf | awk '{for(i=1; i<=NF; i++) print "\t", $i, "\tRemoved"}'
			rm *.pdf
		else
			echo "There are not PDF files."
		fi
		exit

	elif [[ $reply = [Nn] ]]
	then
		echo
		echo "PDF files have not been removed."
		exit
	else 
		echo
		read -p "Wrong option. Remove PDF files too? [Y/n]: " -n 1 reply
	fi
done
