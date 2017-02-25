FROM debian:stretch-slim

ENV  JOURNALBEAT_VERSION=v5.1.2
RUN  export DEBIAN_FRONTEND=noninteractive \
 &&  apt-get update \
 &&  apt-get install -y curl \
 &&  curl -L https://github.com/mheese/journalbeat/releases/download/$JOURNALBEAT_VERSION/journalbeat-debian \
     | install -D -m 0744 -o root -g root /dev/stdin /usr/bin/journalbeat.real \
 &&  curl -L https://github.com/mheese/journalbeat/raw/master/etc/journalbeat.yml \
     | install -D -m 0644 -o root -g root /dev/stdin /etc/journalbeat/journalbeat.yml \
 &&  apt-get remove --purge -y curl \
 &&  apt-get autoremove -y \
 &&  apt-get clean \
 &&  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["journalbeat"]
ADD docker-entrypoint.sh /bin/journalbeat
