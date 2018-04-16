FROM alpine:3.7

MAINTAINER Ole Kleinschmidt <ok@datenreisende.org>

# Packages
RUN apk update
RUN apk -U add py2-pip gcc python2-dev musl-dev linux-headers libxml2-dev \
libxml2 py2-libxml2 libxslt libxslt-dev collectd \
collectd-python

RUN pip install lxml requests fritzconnection fritzcollectd

COPY collectd/collectd.conf /etc/collectd/collectd.conf
COPY run.sh /
RUN chmod +x /run.sh

ENTRYPOINT /run.sh
