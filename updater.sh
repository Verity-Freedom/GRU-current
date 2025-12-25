#!/usr/bin/env bash
cd "$(dirname "$0")"
ping -c 1 ipfs.io
if [ $? -ne 0 ]; then
read -p "I need ipfs.io connectivity to update. Please check your Internet connection."
exit
fi
cp -r ./data ~/data
rm -r *
curl "https://ipfs.io/ipns/link/file.zip" -O
unzip ./file.zip
rm ./file.zip
cp -r ~/data ./
rm -r ~/data
