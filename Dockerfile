FROM debian:jessie-slim

RUN apt-get update -y && \
    apt-get -qq -y --force-yes dist-upgrade --no-install-recommends && \
    apt-get -qq -y --force-yes install --no-install-recommends wget ca-certificates && \
    apt-get clean && \
    apt-get autoremove
RUN mkdir -p /opt/jre
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jre-8u121-linux-x64.tar.gz -O /opt/jre.tgz && \
    tar -xzf /opt/jre.tgz -C /opt/jre --strip-components=1 && \
    rm -f /opt/jre.tgz
RUN update-alternatives --install /usr/bin/java java /opt/jre/bin/java 100
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 -O /sbin/dumb-init && chmod 755 /sbin/dumb-init
RUN useradd -m nm-user

ADD run.sh /
EXPOSE 8080
CMD ["/sbin/dumb-init", "/bin/sh", "/run.sh"]