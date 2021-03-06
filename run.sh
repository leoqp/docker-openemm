#!/bin/bash

#set -m
#set -e

if [ -f /home/openemm/.NOT_CONFIGURED ]; then
	/setup-openemm.sh
    rm /home/openemm/.NOT_CONFIGURED
fi

echo "" > /home/openemm/conf/bav/bav.conf-local

ln -s /var/log/mail.log /var/log/maillog
chmod 604 /var/log/maillog

#COUNTER="1"
#for ADDRESS in $MAIL_ADDRESSES; do
#	echo "${ADDRESS}@${OPEN_EMM_HOSTNAME} alias:ext_${COUNTER}@${OPEN_EMM_HOSTNAME}" >> /home/openemm/conf/bav/bav.conf-local
#	COUNTER=$[$COUNTER+1]
#done

echo "${OPEN_EMM_BOUNCE_DOMAIN}" > /etc/mail/relay-domains
echo "${OPEN_EMM_BOUNCE_DOMAIN} procmail:/home/openemm/conf/bav/bav.rc" > /etc/mail/mailertable
touch /etc/mail/virtusertable

make -C /etc/mail

/etc/init.d/syslog-ng start

#echo "${MAIL_USERNAME_AND_PASSWORD}@${MAIL_HOST}" > /home/openemm/conf/smart-relay

echo -n -e "\n=> Start OpenEMM ..."
echo -e "\n-----------------------------------"

su openemm -c '/home/openemm/bin/openemm.sh start'
tail -f /home/openemm/logs/* /home/openemm/var/log/*
su openemm -c '/home/openemm/bin/openemm.sh stop'
