read -p 'please input total money :' money
echo "total money : $money"
read -p 'please input counts :' counts
echo "counts : $counts"
least=1

function rand(){  
    min=$1  
    max=$(($2-$min+1))  
    num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))  
}  

function pack(){
	if [ $counts = 1 ];then
		echo 'get money : '$money
		((money-=money))
		echo 'left money : '$money
	elif [ $counts -gt 0 ];then
		max=$((money/counts*2))
		if [ $max = 0 ];then
			max=1
		fi
		rnd=$(rand $least $max)
		echo 'get money : '$rnd
		((money-=rnd))
		echo 'left money : '$money
		((counts--))
		pack
	fi
}

pack

