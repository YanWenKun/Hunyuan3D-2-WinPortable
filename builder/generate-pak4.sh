#!/bin/bash
set -eu

echo '#' > pak4.txt

array=(
https://github.com/YanWenKun/Hunyuan3D-2/raw/refs/heads/main/requirements.txt
)

for line in "${array[@]}";
    do curl -w "\n" -sSL "${line}" >> pak4.txt
done

sed -i '/^#/d' pak4.txt
sed -i 's/[[:space:]]*$//' pak4.txt
sed -i 's/>=.*$//' pak4.txt
sed -i 's/_/-/g' pak4.txt

sort -ufo pak4.txt pak4.txt

# Remove duplicate items, compare to pak3.txt
grep -Fixv -f pak3.txt pak4.txt > temp.txt && mv temp.txt pak4.txt

echo "<pak4.txt> generated. Check before use."
