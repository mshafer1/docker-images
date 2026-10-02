FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

RUN apk update && \
    apk add --no-cache dnsmasq && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD ["dnsmasq", "-k"]
