#!/usr/bin/env bash
cd "$(dirname "$0")"
ping -c 1 ipfs.io
if [ $? -ne 0 ]; then
read -p "I need ipfs.io connectivity to update. Please check your Internet connection."
exit
fi
if [[ $(ls -d */ | wc -l) -gt X || $(find . -maxdepth 1 -type f | wc -l) -gt Y ]]; then
read -n 1 -p "There are too many files to update. You don't want to run the updater in a folder with your personal files. Press any key if you want to exit or 0 if you want to update anyway." INP
 if [ $INP != 0 ]; then
 exit
 fi
fi
lsof -t ./dir/ld-linux-x86-64.so.2 | xargs -r kill
cp -r ./data ~/data
rm -r *
curl "https://ipfs.io/ipns/link/file.zip" -O
unzip ./file.zip
rm ./file.zip
cp -r ~/data ./
rm -r ~/data
