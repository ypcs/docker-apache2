FROM ypcs/debian:stretch

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

RUN \
    /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get install --no-install-recommends --no-install-suggests --assume-yes \
        apache2 && \
    /usr/lib/docker-helpers/apt-cleanup

RUN \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

STOPSIGNAL SIGTERM

COPY run.sh /run.sh
CMD ["/run.sh"]

RUN echo "Source: https://github.com/ypcs/docker-apache2\nBuild date: $(date --iso-8601=ns)" >/README
