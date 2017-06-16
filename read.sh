read -p 'please input something in 5 second :' -t 5 something
echo $something
echo -e "\nBoom !"
read -p 'then input your password :' -s password
echo "your password is :"$password