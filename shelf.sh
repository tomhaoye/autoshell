#!/bin/bash
VIEW=/Users/qiuyiwei/dev/qhj/app/views/
FILEROOT=/Users/qiuyiwei/dev/qhj/public/
AR=/Users/qiuyiwei/dev/

OPTFILE=/var/log/mytest/opt
TIMEFILE=/var/log/mytest/timefile
QUCHONG=/var/log/mytest/quchong

function for_in_file(){
	filelist=$(ls $1)
	for file in $filelist
		do
			if [ -f $1/$file ];then
				cat $1/$file | grep "^<script.*src" | while read LINE  
					do
						 echo $LINE | sed 's/^.*src="//g'| sed 's/".*$//g' | sed 's/^http.*$//g' | sed '/^$/d' | sed 's/\?.*$//g' >> $OPTFILE
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
			if [ -f $FILEROOT$LINE ];then
				ls -full $FILEROOT$LINE | awk '{print $8}' | base64 | awk '{print "'$LINE'?v="$1}' >> $TIMEFILE
			else
				echo >> $TIMEFILE
			fi
		done
}

function quchong(){
	sort -k2n $OPTFILE  | uniq > $QUCHONG
	rm $OPTFILE
}

#function replace_them_in_view(){
	
#}

for_in_file $VIEW
quchong
add_file_time
