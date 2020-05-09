#!/bin/bash
# Created on 2020-04-27T21:05:10+1000, using template:mongodb.sh.tmpl and json:gearbox.json

test -f /etc/gearbox/bin/colors.sh && . /etc/gearbox/bin/colors.sh

c_ok "Started."

c_ok "Installing packages."
APKBIN="$(which apk)"
if [ "${APKBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/mongodb.apks ]
	then
		APKS="$(cat /etc/gearbox/build/mongodb.apks)"
		${APKBIN} update && ${APKBIN} add --no-cache ${APKS}; checkExit
	fi
fi

APTBIN="$(which apt-get)"
if [ "${APTBIN}" != "" ]
then
	if [ -f /etc/gearbox/build/mongodb.apt ]
	then
		DEBS="$(cat /etc/gearbox/build/mongodb.apt)"
		${APTBIN} update && ${APTBIN} install fuse; checkExit
		${APTBIN} install ${DEBS}; checkExit
	fi
fi


if [ -f /etc/gearbox/build/mongodb.env ]
then
	. /etc/gearbox/build/mongodb.env
fi

if [ ! -d /usr/local/bin ]
then
	mkdir -p /usr/local/bin; checkExit
fi

c_ok "Finished."
