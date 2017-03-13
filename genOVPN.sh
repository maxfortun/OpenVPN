#!/bin/bash
wanIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
CA=$(cat ca.crt)
CA=${CA//$'\n'/\\$'\n'}
CA=${CA//$'\r'/\\$'\r'}

PUB=$(cat server.crt)
PUB=${PUB//$'\n'/\\$'\n'}
PUB=${PUB//$'\r'/\\$'\r'}

PRI=$(cat server.key)
PRI=${PRI//$'\n'/\\$'\n'}
PRI=${PRI//$'\r'/\\$'\r'}

for ovpn in *.ovpn; do
	sed "s#your-publicly-accessible-ip-here#$wanIP#g" $ovpn
	echo sed "s#... your ca cert here ...#$CA#g" $ovpn
	sed "s#... your client public cert here ...#$PUB#g" $ovpn
	sed "s#... your client private key here ...#$PRI#g" $ovpn
done
