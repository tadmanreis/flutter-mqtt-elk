#!/bin/sh

#Create key pair for CA
echo "---------------------------"
echo "Creating key pair for CA"
echo "---------------------------"
openssl genrsa -des3 -out ca.key 2048

#Create a certificate for the CA using the CA key from first step
echo "---------------------------"
echo "Creating certificarte CA"
echo "---------------------------"
openssl req -new -x509 -days 10000 -key ca.key -out ca.crt

#Create server key pair that will be used by Broker
echo "---------------------------"
echo "Creating Server Key Pair"
echo "---------------------------"
openssl genrsa -out server.key 2048

#Create certificade request .csr
echo "---------------------------"
echo "Creating certificade request"
echo "---------------------------"
openssl req -new -out server.csr -key server.key

#Sign the server certificate
echo "---------------------------"
echo "Singning Certificate"
echo "---------------------------"
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 10000
