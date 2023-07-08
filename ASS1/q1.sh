read -p "Enter uv1:" uv1
read -p "Enter uv2:" uv2

echo "$uv1,$uv2"
echo "$uv2 and $uv1"

len1=${#uv1}
len2=${#uv2}

for((i=$len1-1;i>=0;--i))
do
    rev1="$rev1${uv1:$i:1}"
done

for((i=$len2-1;i>=0;--i))
do
    rev2="$rev2${uv2:$i:1}"
done

echo "uv1 in reverse order:$rev1"
echo "uv2 in reverse order:$rev2"