#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



base=/opt/sf-log-receiver/templates/$OSVER

if [ "$SYSLOG" != "true" ]; then
	echo "install sf-log-forwarder extension instead of sf-log-receiver"
	exit 0
fi

if [ ! -f $base/rsyslog.tpl ] || [ ! -f /etc/rsyslog.conf ]; then
	echo "skipping rsyslog setup, unsupported operating system version"
	exit 1
fi

save_original_config /etc/rsyslog.conf

echo "configuring rsyslog as log receiver"
cat $base/rsyslog.tpl >/etc/rsyslog.conf

service rsyslog restart
