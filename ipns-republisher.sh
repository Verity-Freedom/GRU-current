#!/usr/bin/env bash
cd "$(dirname "$0")"
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs init
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs daemon &
sleep 10
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs routing get /ipns/link > record.bin
curl -i -X PUT https://delegated-ipfs.dev/routing/v1/ipns/link -H "Content-Type: application/vnd.ipfs.ipns-record" --data-binary @record.bin
