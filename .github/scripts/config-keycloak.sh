#! /bin/bash -e
mkdir kc && cd kc
curl -OL https://github.com/keycloak/keycloak/releases/download/26.1.0/keycloak-26.1.0.zip
unzip keycloak-26.1.0.zip
cd keycloak-26.1.0
# mkdir -p data/import
mkdir data && cd data
mkdir import && cd import
# cp ../../kcdb/data/import/* .data/import
cp ../../../../kcdb/data/import/* . && cd ../..
./bin/kc.sh start-dev --import-realm &
# sleep 30
#  docker option may fail because the latest version may not yet be stable. Use the above or change to a more stable/recent release
#  docker run --name keycloak_unoptimized -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -v ./kcdb/data/import:/opt/keycloak/data/import quay.io/keycloak/keycloak:latest start-dev --import-realm
#  sleep 40