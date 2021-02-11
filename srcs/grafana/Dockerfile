FROM alpine:3.12

COPY start.sh /tmp/

RUN apk add wget; \
	wget https://dl.grafana.com/oss/release/grafana-7.4.1.linux-amd64.tar.gz; \
	tar -zxvf grafana-7.4.1.linux-amd64.tar.gz; \
	mv grafana-7.4.1 grafana; \
	chmod -R 777 grafana/; \
	chmod 777 /tmp/start.sh

EXPOSE 3000

ENTRYPOINT [ "/tmp/start.sh" ]
