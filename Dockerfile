FROM debian:10.1

EXPOSE 80 25 587 995

WORKDIR /home

RUN apt-get update && \
    apt-get install -y supervisor gettext-base && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libsasl2-2 sasl2-bin \
    libsasl2-modules fail2ban certbot dovecot-pop3d dovecot-core dovecot-lmtpd \
    dovecot-pgsql postfix postfix-pgsql postgresql-client

COPY rootfs/ /

RUN adduser --system --no-create-home --uid 500 --group --disabled-password --disabled-login --gecos 'dovecot virtual mail user' vmail && \
    mkdir -p /var/vmail && \
    chown vmail:vmail /var/vmail && \
    chmod 700 /var/vmail

RUN chmod +x /home/run.sh

RUN service postfix stop
RUN service dovecot stop

VOLUME /var/vmail
VOLUME /etc/letsencrypt

CMD ["/home/run.sh"]
