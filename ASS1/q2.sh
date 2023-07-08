read -p "Enter filename:" file

if [ -f $file ]
then
    echo "File exists"
    lines=`grep -c "." $file`
    echo "Number of lines: $lines"
else
    echo "File does not exist. Creating new file..."
    read -p "Enter text(# to end input):" line
    touch $file
    while [[ $line != "#" ]]
    do
        echo $line >> $file
        read line
    done
fi
