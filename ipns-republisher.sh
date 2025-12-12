#!/usr/bin/env bash
cd "$(dirname "$0")"
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs init
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs daemon &
sleep 20
while pgrep -x ld-linux-x86-64 > /dev/null
do
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs routing get /ipns/link > record.bin
curl -i -X PUT https://delegated-ipfs.dev/routing/v1/ipns/link -H "Content-Type: application/vnd.ipfs.ipns-record" --data-binary @record.bin
sleep 1d
done
