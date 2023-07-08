read -p "Enter file name: " file
read -p "Enter string to search for: " str

total_cnt=`grep -w -c $str $file`
echo "No. of lines containing given string: $total_cnt"
i=1
if [ $total_cnt -ne 0 ]
then
    while read -r line
    do
        cnt=`grep -o $str <<< $line | wc -l`
        if [ $cnt -ne 0 ]
        then
            echo "Occurences in line $i: $cnt"
        fi
        i=$((i+1))
    done < $file
else
    echo "No lines contain given string."
fi