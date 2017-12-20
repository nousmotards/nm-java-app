FROM openjdk:8u151-jdk-alpine

RUN apk update && apk add bash && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 -O /sbin/dumb-init && chmod 755 /sbin/dumb-init
RUN adduser -h /home/nm-user -s /bin/sh nm-user -D

ADD run.sh /
EXPOSE 8080
CMD ["/sbin/dumb-init", "/bin/bash", "/run.sh"]
