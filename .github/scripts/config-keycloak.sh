#! /bin/bash -e
mkdir kc && cd kc
curl -OL https://github.com/keycloak/keycloak/releases/download/23.0.6/keycloak-23.0.6.zip
unzip keycloak-23.0.6.zip
cd keycloak-23.0.6
cp -R ../../kcdb/data .
./bin/kc.sh start-dev &