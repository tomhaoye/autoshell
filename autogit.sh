#!/bin/bash
QHJ=/Users/qiuyiwei/dev/qhj/

cd $QHJ
git pull
gulp fontall

if [ $# -gt 0 ]; then   
	if [ $1 = "production" ];then
		rsync --rsh=ssh -avz --delete --exclude-from "exclude.txt" ~/dev/qhj/ root@$2:/home/likun/php/qhj
	else
		rsync --rsh=ssh -avz --delete --exclude-from "exclude.txt" ~/dev/qhj/ root@$2:/home/likun/php/qhj_test
	fi
fi 
