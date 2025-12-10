#!/usr/bin/env bash
cd "$(dirname "$0")"
./ipfs init
./ipfs daemon &
sleep 10
./ipfs routing get /ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4 > record.bin
curl -i -X PUT https://delegated-ipfs.dev/routing/v1/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4 -H "Content-Type: application/vnd.ipfs.ipns-record" --data-binary @record.bin
