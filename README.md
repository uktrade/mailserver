# Postfix and dovecot docker mailserver

## Notes

* Ports: SMTP transport: 25, SMTP MUA (mail client), pop3s: 995, imap is not enabled
* If USE_LETSENCRYPT is set to 'yes', then certs will be allocated for mail.yourdomain.tld and pop3.yourdomain.tld. Otherwise self signed certs will be used
* TLS is required on all ports
