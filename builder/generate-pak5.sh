#!/bin/bash
set -eu

echo '#' > pak5.txt

array=(
https://github.com/Tencent-Hunyuan/Hunyuan3D-2.1/raw/refs/heads/main/requirements.txt
)

for line in "${array[@]}";
    do curl -w "\n" -sSL "${line}" >> pak5.txt
done

sed -i '/^#/d' pak5.txt
sed -i 's/[[:space:]]*$//' pak5.txt
sed -i 's/>=.*$//' pak5.txt
sed -i 's/_/-/g' pak5.txt
sed -i 's/==.*$//g' pak5.txt

sort -ufo pak5.txt pak5.txt

# Remove duplicate items, compare to pak3.txt and pak4.txt
grep -Fixv -f pak3.txt pak5.txt > temp.txt && mv temp.txt pak5.txt
grep -Fixv -f pak4.txt pak5.txt > temp.txt && mv temp.txt pak5.txt

echo "<pak5.txt> generated. Check before use."
