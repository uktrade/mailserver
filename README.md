# Postfix and dovecot docker mailserver

## Notes

* Ports: SMTP transport: 25, SMTP MUA (mail client), pop3s: 995, imap is not enabled
* If USE_LETSENCRYPT is set to 'yes', then certs will be allocated for mail.yourdomain.tld and pop3.yourdomain.tld. Otherwise self signed certs will be used.
* Letsencrypt will not work from your local machine as it requires a public server and domain name to issue the certificates.
* TLS is required on all ports.  

## Run a local environment

Stand up the server with docker-compose: `docker-compose up`

Based on the configuration in the `docker-compose.yml file:

The email address is: `username@example.com`
The username for both pop3 and smtp is: username
The password for both services is: password

You can use a mail client to connect to localhost on ports 995 for pop3 or 587 for smtp.

## example connecting to pop3 using openssl's s_client (telnet over TLS):

Example connecting to pop3:

```
$ openssl s_client -quiet -connect localhost:995 
---
+OK Dovecot (Debian) ready.
user username
+OK
pass password
+OK Logged in.
stat
+OK 0 0
quit
+OK Logging out.
closed 
```

## To connect to smtp:

Examples can be found online for making SMTP connections via telnet. The openssl command to initiate a connection is:

`$ openssl s_client -quiet -connect localhost:587 -starttls smtp`




