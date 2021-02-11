FROM alpine:3.12

RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY telegraf.conf /root/.telegraf/

ENTRYPOINT [ "telegraf" ]
	
