#! /bin/bash -e
#  docker option may fail because the latest version may not yet be stable. Use the above or change to a more stable/recent release
  docker run --name keycloak_unoptimized -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -v ./kcdb/data/import:/opt/keycloak/data/import quay.io/keycloak/keycloak:latest start-dev --import-realm &
  sleep 40