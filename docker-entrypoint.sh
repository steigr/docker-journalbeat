#!/bin/sh

cd /etc/journalbeat
for template in journalbeat.template.json journalbeat.template-es2x.json; do
	test -f "$template" \
	|| echo '{}' | install -D -m 0644 -o root -g root /dev/stdin "$template"
done

exec journalbeat.real -e -c journalbeat.yml