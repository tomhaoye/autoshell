#!/bin/bash
VIEW=/Users/qiuyiwei/dev/qhj/app/views/
FILEROOT=/Users/qiuyiwei/dev/qhj/public/
AR=/Users/qiuyiwei/dev/

OPTFILE=/var/log/mytest/opt
TIMEFILE=/var/log/mytest/timefile
QUCHONG=/var/log/mytest/quchong
REPLACE=/var/log/mytest/replace

function for_in_file(){
	filelist=$(ls $1)
	for file in $filelist
		do
			if [ -f $1/$file ];then
				cat $1/$file | grep "^<script.*src" | while read LINE  
					do
						 #echo $LINE | sed 's/^.*src="//g'| sed 's/".*$//g' | sed 's/^http.*$//g' | sed '/^$/d' | sed 's/\?.*$//g' >> $OPTFILE
						 echo $LINE | sed 's/^.*src="//g'| sed 's/".*$//g' | sed 's/^http.*$//g' | sed '/^$/d'  >> $OPTFILE
					done
			fi
			if [ -d $1/$file ];then
				for_in_file $1/$file
			fi
		done
}

function add_file_time(){
	cat $QUCHONG | while read LINE
		do
			LINE=$(echo $LINE | sed 's/\?.*$//g')
			if [ -f $FILEROOT$LINE ];then
				version=$(ls -full $FILEROOT$LINE | awk '{print $5}' | base64) 
				echo $LINE?v=$version >> $TIMEFILE
			else
				echo >> $TIMEFILE
			fi
		done
}

function quchong(){
	sort -k2n $OPTFILE  | uniq > $QUCHONG
	rm $OPTFILE
}

function for_in_script(){
	cat $REPLACE | while read LINE
	do
		PART=$(echo $LINE | sed '/^$/d' | sed 's/\?.*$//g' | sed "s:\/:\\\/:g")
		LINE=$(echo $LINE | sed "s:\/:\\\/:g")
    	replace_in_view $LINE $PART $VIEW
	done
}

function replace_in_view(){
	filelist=$(ls $3)
	for file in $filelist
	do
		if [ -f $3/$file ];then
			sed -i "" "s/src=\"$2.*\"/src=\"$1\"/g" $3/$file
		fi
		if [ -d $3/$file ];then
			replace_in_view $1 $2 $3/$file
		fi
	done
}

function diff_version(){
	diff $QUCHONG $TIMEFILE -u | grep '^+/' | sed 's/+//g' > $REPLACE
	rm $TIMEFILE
}

#function for_in_view(){
#	filelist=$(ls $1)
#	for file in $filelist
#	do
#		if [ -f $1/$file ];then
#			cat $TIMELINE | while read LINE
#			do
#				PART=$(echo $LINE | sed '/^$/d' | sed 's/\?.*$//g' | sed "s:\/:\\\/:g")
#				LINE=$(echo $LINE | sed "s:\/:\\\/:g")
#				sed -i "" "s/src=\"$PART.*\"/src=\"$LINE\"/g" $1/$file
#			done
#		fi
#		if [ -d $1/$file ];then
#			for_in_view $1/$file
#		fi
#	done
#}

for_in_file $VIEW
quchong
add_file_time
diff_version
for_in_script
#for_in_view $VIEW
