FROM debian:10.1

EXPOSE 80 25 587 995

WORKDIR /home

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dumb-init gettext-base libsasl2-2 sasl2-bin libsasl2-modules fail2ban certbot dovecot-pop3d dovecot-core dovecot-lmtpd dovecot-pgsql postfix postfix-pgsql postgresql-client

COPY rootfs/ /

RUN service fail2ban restart

RUN adduser --system --no-create-home --uid 500 --group --disabled-password --disabled-login --gecos 'dovecot virtual mail user' vmail && \
    mkdir -p /var/vmail && \
    chown vmail:vmail /var/vmail && \
    chmod 700 /var/vmail

RUN chmod +x /home/run.sh

#VOLUME /var/vmail
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/home/run.sh"]
