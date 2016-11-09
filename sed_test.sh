#!/bin/bash
LINE='\/static\/js\/tool.js?v=hahahah'
PART=

function sed_test(){
	PART=$(echo $LINE | sed '/^$/d' | sed 's/\?.*$//g')
    aa $LINE $PART
}

function aa(){
	sed -i "" "s/$2/$1/g" '/Users/qiuyiwei/dev/autoshell/tet'
}

sed_test
