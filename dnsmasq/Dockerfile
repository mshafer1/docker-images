# 2.23.3
FROM alpine@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659

RUN apk update && \
    apk add --no-cache dnsmasq && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD ["dnsmasq", "-k"]
