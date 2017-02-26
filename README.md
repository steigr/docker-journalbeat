# Journalbeat

[![](https://images.microbadger.com/badges/image/steigr/journalbeat.svg)](http://microbadger.com/images/steigr/journalbeat "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/steigr/journalbeat.svg)](http://microbadger.com/images/steigr/journalbeat "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/steigr/journalbeat.svg)](http://microbadger.com/images/steigr/journalbeat "Get your own commit badge on microbadger.com")

This docker image can be used to stream from journald to elastic search.

The image does not contain any special configuration.

# Docker

```shell
docker run --rm --network=host \
    --env=ELASTICSEARCH_HOST=http://localhost:9200 \
    --env=ELASTICSEARCH_USERNAME=elastic \
    --env=ELASTICSEARCH_PASSWORD=changeme \
    --tmpfs=/data:rw,noexec,nosuid,size=32k \
    --volume=/var/log/journal:/var/log/journal \
    --volume=/run/log/journal:/run/log/journal \
    --volume=/etc/machine-id:/etc/machine-id:ro \
    --name=journalbeat steigr/journalbeat
```

# Systemd

```INI
[Install]
WantedBy=multi-user.target
[Unit]
Requires=docker.service
After=ndocker.service

[Service]
Restart=always
RestartSec=5s

Environment=ELASTICSEARCH_HOST=localhost:9200
Environment=ELASTICSEARCH_USERNAME=elastic
Environment=ELASTICSEARCH_PASSWORD=changeme
Environment=IMAGE=steigr/journalbeat
Environment=CONTAINER_NAME=%p

ExecStartPre=-/usr/bin/docker rm -f ${CONTAINER_NAME}
ExecStartPre=-/usr/bin/docker pull ${IMAGE}
ExecStart=/usr/bin/docker run --rm --network=host \
    --env=ELASTICSEARCH_HOST \
    --env=ELASTICSEARCH_USERNAME \
    --env=ELASTICSEARCH_PASSWORD \
    --tmpfs=/data:rw,noexec,nosuid,size=32k \
    --volume=/var/log/journal:/var/log/journal \
    --volume=/run/log/journal:/run/log/journal \
    --volume=/etc/machine-id:/etc/machine-id:ro \
    --name=${CONTAINER_NAME} ${IMAGE}
```