#!/bin/sh
pidof tini </dev/null >/dev/null 2>&1 || exec tini "$0" "$@"

cd /etc/journalbeat
exec journalbeat.real -e -c journalbeat.yml