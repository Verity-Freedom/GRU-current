#!/usr/bin/env bash
cd "$(dirname "$0")"
UPD=(VERSION*)
curl "https://ipfs.io/ipns/link/$UPD" -f -s -o /dev/null
if [ $? -eq 22 ]; then
read -n 1 -p "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to skip " INP
echo
systemctl --user is-active --quiet .service
 if [ $? -eq 0 ]; then
 CHECK=0
 fi
 if [ $INP != 0 ]; then
 ./updater.sh
 fi
 if [[ $INP != 0 && $CHECK = 0 ]]; then
 exit
 fi
fi
