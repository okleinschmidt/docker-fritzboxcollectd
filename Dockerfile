FROM alpine:latest
LABEL org.label-schema.name="docker-collectd-fritzcollectd" \
      org.label-schema.description="Fritzbox collectd" \
      org.label-schema.url="https://github.com/acidhunter" \
      authors="Martin Friedrich" \
      maintainer="npanic@kmpt.nz"

# Packages
RUN apk update
RUN apk -U add py2-pip gcc python2-dev musl-dev
RUN apk -U add linux-headers libxml2-dev libxml2 py2-libxml2 libxslt libxslt-dev
RUN apk -U add collectd collectd-python gettext libintl

RUN pip install lxml requests fritzconnection fritzcollectd

ENV FB_IP=192.168.178.1 \
    FB_USER=monitor \
    FB_PW=setapassword \
    GRAPHITE_HOST=graphite \
    ESC='$'

COPY collectd/collectd.tmpl /etc/collectd/collectd.tmpl
CMD /bin/sh -c "envsubst < /etc/collectd/collectd.tmpl > /etc/collectd/collectd.conf && /usr/sbin/collectd -f || cat /etc/collectd/collectd.conf"
