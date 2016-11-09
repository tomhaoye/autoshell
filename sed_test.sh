#!/bin/bash
LINE='\/static\/js\/lib\/zepto.js?v=23d2e2'
PART=

function sed_test(){
	PART=$(echo $LINE | sed '/^$/d' | sed 's/\?.*$//g')
   	aa $LINE $PART
}

function aa(){
	sed -i "" "s/src=\"$2.*\"/src=\"$1\"/g" '/Users/qiuyiwei/dev/qhj/app/views/AmCenterView.php'
}

sed_test
