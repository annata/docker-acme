#!/bin/sh
set -e
CRT="/cert/"${CERT_PREFIX}"cert.crt"
KEY="/cert/"${CERT_PREFIX}"cert.key"
if [ $CERT ];then
	if ! [[ $(acme.sh --list) =~ $CERT ]]; then
		acme.sh --issue --fullchain-file $CRT --key-file $KEY --standalone -d $CERT || true
	fi
fi
trap "echo stop && killall crond && exit 0" SIGTERM SIGINT 
crond && while true; do sleep 1; done;