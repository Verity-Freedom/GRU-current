#!/usr/bin/env bash
cd "$(dirname "$0")"
curl "https://ipfs.io/ipns/link/test.txt" -f -s -o /dev/null
if [ $? -eq 22 ]; then
read -p "I need ipfs.io connectivity to update. Please check your Internet connection. "
exit
fi
if [[ $(ls -d */ | wc -l) -gt X || $(find . -maxdepth 1 -type f | wc -l) -gt Y ]]; then
read -n 1 -p "There are too many files to update. You don't want to run the updater in a folder with your personal files. Press any key if you want to exit or 0 if you want to update anyway. " INP
echo
 if [ $INP != 0 ]; then
 exit
 fi
fi
lsof -t ./ld-linux-x86-64.so.2 | xargs -r kill
cp -r ./data ~/data
rm -r *
curl "https://ipfs.io/ipns/link/file.zip" -O
unzip ./file.zip
rm ./file.zip
cp -r ~/data ./
rm -r ~/data
