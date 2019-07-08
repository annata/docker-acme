#!/bin/sh
set -e
if [ $CERT ];then
	if ! [[ $(acme.sh --list) =~ $CERT ]]; then
		acme.sh --issue --fullchain-file /cert/cert.crt --key-file /cert/cert.key --standalone -d $CERT
	fi
fi
trap "echo stop && killall crond && exit 0" SIGTERM SIGINT 
crond && while true; do sleep 1; done;