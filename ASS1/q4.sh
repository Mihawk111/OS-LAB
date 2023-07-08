argc=$#
REC_BIN="./my_deleted_files"
if ! [ -d $REC_BIN ]
then
    mkdir -p $REC_BIN
fi

if [ $argc == 0 ]
then
    echo "Error: No input"
elif [ $argc -eq 2 ]
then
    echo "Error: Multiple inputs"
else
    if [ $1 == "-c" ]
    then
        read -p "Do you want to clear my_deleted_files? (y/n): " conf
        if [ $conf == "y" ]
        then
            rm -rf $REC_BIN
            echo "my_deleted_files Cleared!!!"
        fi
    else
        file=$1
        if ! [ -f $file ]
        then
            echo "Error: File does not exist..."
        else
            if [ -f $REC_BIN"/"${file%.*}"_0."${file##*.} ]
            then
                count=0
                while [ -f $REC_BIN"/"${file%.*}"_"$count"."${file##*.} ]
                do
                    count=$(($count + 1))
                done
                newfile=${file%.*}"_"$count"."${file##*.}
                mv $file $REC_BIN"/"$newfile
            elif [ -f $REC_BIN"/"$file ]
            then
                mv $REC_BIN"/"$file $REC_BIN"/"${file%.*}"_0."${file##*.}
                mv $file $REC_BIN"/"${file%.*}"_1."${file##*.}
            else
                mv $file $REC_BIN"/"$file
            fi
            echo "File deleted succesfully..."
        fi
    fi

fi