FROM alpine:3.12

COPY start.sh /tmp/

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat; \
	wget https://dl.grafana.com/oss/release/grafana-7.4.1.linux-amd64.tar.gz; \
	tar -zxvf grafana-7.4.1.linux-amd64.tar.gz; \
	mv grafana-7.4.1 grafana; \
#	chmod +x grafana/bin/grafana-server; \
	chmod 777 /tmp/start.sh

#RUN apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

EXPOSE 3000

WORKDIR /grafana/bin/
#WORKDIR /usr/share/grafana

#COPY defaults.ini /usr/share/grafana/conf/
ENTRYPOINT [ "./grafana-server" ]
#CMD [ "grafana-server" ]
