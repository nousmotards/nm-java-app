FROM debian:jessie-slim

RUN \
	# Install openjdk
	apt-get update -y && \
	apt-get install -y default-jdk \

ADD entrypoint.sh /

EXPOSE 8080
CMD entrypoint.sh
