read -p "Enter file name: " file
read -p "Enter pattern 1: " str1
read -p "Enter pattern 2: " str2

total_cnt=`grep -w -c $str1 $file`
if [ $total_cnt -ne 0 ]
then
    text=`sed -i "s/$str1/$str2/g" $file`
else
    echo "Error: No lines contain given string."
fi
