#!/bin/bash

: "${EMAIL_DOMAIN?Need to set EMAIL_DOMAIN}"
: "${CERTBOT_EMAIL?Need to set CERTBOT_EMAIL}"
: "${POSTGRES_DATABASE?Need to set POSTGRES_DATABASE}"
: "${POSTGRES_HOSTNAME?Need to set POSTGRES_HOSTNAME}"
: "${POSTGRES_USERNAME?Need to set POSTGRES_USERNAME}"
: "${POSTGRES_PASSWORD?Need to set POSTGRES_PASSWORD}"

envsubst < "/etc/postfix/main.cf.tmpl" > "/etc/postfix/main.cf"
envsubst < "/etc/postfix/pgsql-virtual-alias-maps.cf.tmpl" > "/etc/postfix/pgsql-virtual-alias-maps.cf"
envsubst < "/etc/postfix/pgsql-virtual-email2email.cf.tmpl" > "/etc/postfix/pgsql-virtual-email2email.cf"
envsubst < "/etc/postfix/pgsql-virtual-mailbox-domains.cf.tmpl" > "/etc/postfix/pgsql-virtual-mailbox-domains.cf"
envsubst < "/etc/postfix/pgsql-virtual-mailbox-maps.cf.tmpl" > "/etc/postfix/pgsql-virtual-mailbox-maps.cf"
envsubst < "/etc/dovecot/dovecot-sql.conf.ext.tmpl" > "/etc/dovecot/dovecot-sql.conf.ext"
envsubst < "/etc/dovecot/conf.d/10-auth.conf.tmpl" > "/etc/dovecot/conf.d/10-auth.conf"

if [ "$USE_LETSENCRYPT" == "yes" ]; then
  if [ ! -f "/etc/letsencrypt/live/${EMAIL_DOMAIN}/fullchain.pem"]; then
    certbot certonly --noninteractive --agree-tos --email ${CERTBOT_EMAIL} --standalone -d mail.${EMAIL_DOMAIN}
  else
    certbot renew
  fi
  postconf -e "smtpd_tls_cert_file = /etc/letsencrypt/live/${EMAIL_DOMAIN}/fullchain.pem"
  postconf -e "smtpd_tls_key_file = /etc/letsencrypt/live/${EMAIL_DOMAIN}/privkey.pem"
  sed -i "s/^ssl_cert = .*$/ssl_cert = \<\/etc\/letsencrypt\/live\/${EMAIL_DOMAIN}\/fullchain.pem/g" /etc/dovecot/conf.d/10-ssl.conf
  sed -i "s/^ssl_key = .*$/ssl_key = \<\/etc\/letsencrypt\/live\/${EMAIL_DOMAIN}\/privkey.pem/g" /etc/dovecot/conf.d/10-ssl.conf
fi

rm /var/spool/postfix/pid/master.pid

cd /etc/supervisor && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
