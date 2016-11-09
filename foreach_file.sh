#!/bin/bash
VIEW=/Users/qiuyiwei/dev/qhj/app/views/

function foreach_file(){
	filelist=$(ls $1)
	for file in $filelist
	do
		if [ -f $1/$file ];then
			ls $1/$file | awk '{print $1}'
		fi
		if [ -d $1/$file ];then
			foreach_file $1/$file
		fi
	done
}

foreach_file $VIEW
