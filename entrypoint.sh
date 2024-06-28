#!/bin/sh

CERT_DIR=/certs
CERT_FILE=$CERT_DIR/certificate.crt
KEY_FILE=$CERT_DIR/privateKey.key

# Check if certificate and key files exist, if not, create them
if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
  #echo "Generating self-signed cert"
  #echo "Generating a 2048 bit RSA private key"
  mkdir -p $CERT_DIR
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY_FILE -out $CERT_FILE -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=localhost" -verbose
  #echo "writing new private key to '${KEY_FILE}'"
fi

# Start your application here, e.g., for a Node.js app
# node /path/to/your/app.js
echo "Starting nginx"
exec "$@"
