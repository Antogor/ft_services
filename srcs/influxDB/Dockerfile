FROM alpine:3.12

COPY start.sh /tmp/

RUN apk add influxdb; \
	chmod 777 /tmp/start.sh

EXPOSE 8086

ENTRYPOINT [ "/tmp/start.sh" ]
