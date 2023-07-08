conv() {
    T=$1
    Y=$((T/60/60/24/365))
    Mo=$((T/60/60/24%365/30))
    D=$((T/60/60/24%365%30))

    (( $Y > 0 )) && res="$res$Y years "
    (( $Mo > 0 )) && res="$res$Mo months "
    (( $D > 0 )) && res="$res$D days"
    echo $res
}

read -p "Enter first birthday: " b1
read -p "Enter second birthday: " b2

IFS='/' read -r -a dateArr1 <<< $b1
IFS='/' read -r -a dateArr2 <<< $b2

# temp=${dateArr1[0]}
# dateArr1[0]=${dateArr1[1]}
# dateArr1[1]=$temp

# temp=${dateArr2[0]}
# dateArr2[0]=${dateArr2[1]}
# dateArr2[1]=$temp

b1="${dateArr1[1]}/${dateArr1[0]}/${dateArr1[2]}"
b2="${dateArr2[1]}/${dateArr2[0]}/${dateArr2[2]}"

day1=$(date +%a --date=$b1)
day2=$(date +%a  --date=$b2)

echo $day1
echo $day2

if [ $day1 == $day2 ]
then
    echo "Day matches"
else
    echo "Day does not match"
fi

cur=$(date +%s)
date1=$(date +%s --date=$b1)
date2=$(date +%s  --date=$b2)

a1=$((cur-date1))
a2=$((cur-date2))

age1=$(conv $a1)
age2=$(conv $a2)

echo "Age of first person: $age1"
echo "Age of second person: $age2"