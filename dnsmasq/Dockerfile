FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

RUN apk update && \
    apk add --no-cache dnsmasq && \
    rm -rf /var/cache/apk/*

EXPOSE 53/udp

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD ["dnsmasq", "-k"]
