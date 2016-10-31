FROM alpine:3.4

ENV TERM=vt100 \
    S3_REGION=us-east-1

RUN apk add -U dcron py-pip py-cffi python-dev openssl-dev musl-dev gcc && \
    pip install letsencrypt letsencrypt-s3front && \
    apk del python-dev openssl-dev musl-dev gcc && \
    rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

COPY . /

VOLUME ["/etc/letsencrypt", "/var/lib/letsencrypt"]

ENTRYPOINT ["/entrypoint.sh"]
