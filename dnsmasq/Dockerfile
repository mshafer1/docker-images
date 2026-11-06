FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

RUN apk update && \
    apk add --no-cache dnsmasq && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD ["dnsmasq", "-k"]
