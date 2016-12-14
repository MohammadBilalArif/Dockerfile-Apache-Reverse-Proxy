#!/bin/sh
echo "To support HTTPS, Dockerfile will use these certificates."
mkdir -p ~/ssl && cd ~/ssl
openssl genrsa -out ca.key 2048
openssl req -nodes -new -key ca.key -out ca.csr
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt
