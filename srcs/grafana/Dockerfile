FROM alpine:3.12

COPY grafana /tmp/grafana/

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

EXPOSE 3000

WORKDIR /tmp/grafana/bin/

ENTRYPOINT [ "./grafana-server" ]
