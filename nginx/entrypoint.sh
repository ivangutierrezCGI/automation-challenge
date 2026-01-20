#!/bin/sh
set -eu

CERT_DIR="/etc/nginx/certs"
CRT="${CERT_DIR}/tls.crt"
KEY="${CERT_DIR}/tls.key"

mkdir -p "${CERT_DIR}"

if [ ! -f "${CRT}" ] || [ ! -f "${KEY}" ]; then
  FQDN="${TLS_FQDN:-automation-challenge-ivan.westeurope.azurecontainer.io}"
  echo "Generating self-signed certificate for CN=${FQDN}"
  openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout "${KEY}" \
    -out "${CRT}" \
    -days 365 \
    -subj "/CN=${FQDN}"
fi

exec nginx -g "daemon off;"
