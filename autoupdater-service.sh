#!/usr/bin/env bash
cd "$(dirname "$0")"
UPD=(VERSION*)
curl "https://ipfs.io/ipns/link/$UPD" -f -s -o /dev/null
if [[ $? = 22 && ! -f "./AUTO.no" ]]; then
read -n 1 -p "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to disable autoupdate (delete AUTO.no to enable again) " INP
echo
systemctl --user is-active --quiet .service
 if [ $? = 0 ]; then
 CHECK=0
 fi
 if [ $INP != 0 ]; then
 ./updater.sh
 fi
 if [ $INP = 0 ]; then
 touch "./AUTO.no"
 fi
 if [[ $INP != 0 && $CHECK = 0 ]]; then
 exit
 fi
fi
