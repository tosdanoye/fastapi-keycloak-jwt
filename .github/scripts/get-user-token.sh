#! /bin/bash -e

pip install jq

export access_token=$(\
curl -X POST http://localhost:8080/realms/SmartOcean/protocol/openid-connect/token \
-H 'content-type: application/x-www-form-urlencoded' \
-d 'client_id=SO_service' \
-d 'username=alice&password='$ALICE_PWD'&grant_type=password' | jq --raw-output '.access_token' \
)

poetry run python tests/update_env.py