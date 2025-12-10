openssl req -x509 -nodes -newkey rsa:2048 \
  -keyout automation-challenge.cgi.com.key \
  -out automation-challenge.cgi.com.crt \
  -days 365 \
  -subj "/CN=automation-challenge.cgi.com"

