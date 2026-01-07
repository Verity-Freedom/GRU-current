#!/usr/bin/env bash
cd "$(dirname "$0")"
ping -c 1 ipfs.io
if [ $? -ne 0 ]; then
read -p "I need ipfs.io connectivity to update. Please check your Internet connection."
exit
fi
if [ $(ls -1 | wc -l) -gt 18 ]; then
read -n 1 -p "There are too many files to update. You don't want to run the updater in a folder with your personal files. Press any key if you want to exit or 0 if you want to update anyway." INP
 if [ $INP != 0 ]; then
 exit
 fi
fi
cp -r ./data ~/data
rm -r *
curl "https://ipfs.io/ipns/link/file.zip" -O
unzip ./file.zip
rm ./file.zip
cp -r ~/data ./
rm -r ~/data
