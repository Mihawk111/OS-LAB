count_files_only()
{
    if (( $# == 0 ))
    then
        echo 0
    else
        path="$1" 
        no_of_files=0
        for file in "$path"/*
        do
            if [ -d "$file" ]
            then 
                rec_return=$(count_files_only "$file/")
                no_of_files=$(($no_of_files + $rec_return))
            elif [ -f "$file" ]
            then
                no_of_files=$(($no_of_files + 1))
            fi
        done
        
        echo $no_of_files
    fi
}

count_files_with_subdir()
{
    if (( $# == 0 ))
    then
        echo 0
    else
        path="$1" 
        no_of_files=0
        for file in "$path"/*
        do
            if [ -d "$file" ]
            then 
                no_of_files=$(($no_of_files + 1))
                rec_return=$(count_files_with_subdir "$file/")
                no_of_files=$(($no_of_files + $rec_return))
            elif [ -f "$file" ]
            then
                no_of_files=$(($no_of_files + 1))
            fi
        done
        
        echo $no_of_files
    fi
}

ans1=$(count_files_only ".")
echo "Number of files only: $ans1"
ans2=$(count_files_with_subdir ".")
echo "Number of files with sub-directories: $ans2"
