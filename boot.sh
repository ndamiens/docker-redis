#!/bin/bash
set -e
RARGS=""

if [ ! -z "$APPENDONLY" ]; then
	RARGS="--appendonly yes"
fi

if [ ! -z "$AUTH" ]; then
	RARGS="$RARGS --requirepass \"$AUTH\""
fi

cat >/etc/supervisor/conf.d/redis.conf << EOF
[program:redis]
command=/usr/local/bin/redis-server $RARGS
autorestart=true
startretries=3
EOF

supervisord -n -c /etc/supervisor/supervisord.conf

echo "42 7 * * * root redis-cli $RCARGS BGREWRITEAOF" >/etc/cron.d/redis_bgrewrite
echo "4,15 15 * * * root redis-cli $RCARGS SAVE" >/etc/cron.d/redis_dump
