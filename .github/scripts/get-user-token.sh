#! /bin/bash -e

pip install jq

export access_token1=$(\
curl -X POST http://localhost:8080/realms/ADA502/protocol/openid-connect/token \
-d 'client_id=ada502app' \
-d 'username=user1&password='$USER1_PWD'&grant_type=password' | jq --raw-output '.access_token' \
)

export access_token2=$(\
curl -X POST http://localhost:8080/realms/ADA502/protocol/openid-connect/token \
-d 'client_id=ada502app' \
-d 'username=user2&password='$USER2_PWD'&grant_type=password' | jq --raw-output '.access_token' \
)

poetry run python tests/update_env.py