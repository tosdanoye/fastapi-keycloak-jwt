Securing FastAPI REST Services with JWT and Keycloak IdP
===================================================

This guide provides example of integrating REST services with Keycloak Identity and Access Management to provide stateless Authentication and Authorization Services.

Configuring the Keycloak Server
-------------------

Keycloak can be started in multiple ways: [Keycloak Getting Started guides](https://github.com/keycloak/keycloak?tab=readme-ov-file#getting-started). Here, we'll use the easiest option :-)
- Download the latest release, unzip and copy the data folder [data](kcdb) in your unzipped directory.
- From that directory, run the command: 
```shell
bin/kc.[sh|bat] start-dev`
```
The data folder contains the h2 database with configured realm (SmartOcean), service (SO_service), roles, and users.

Point your url to: http://localhost:8080 and log in as the `admin` user to access the Keycloak Administration Console. Username is `admin` and password `admin`.

RestAPI Endpoints
---------------------

There are 5 endpoints exposed by the service:

* http://localhost:8090/api/v1/public - can be invoked by any user
* http://localhost:8090/api/v1/admin - can be invoked by users with the `ADMIN` role
* http://localhost:8090/api/v1/admin/service - can be invoked by users with the `S_ADMIN` role
* http://localhost:8090/api/v1/protected - can be invoked by users with the `USER` role
* http://localhost:8090/api/v1/protected/service - can be invoked by users with the `S_USER` role

To access the resources at the protected endpoints using a JWT bearer token, your client needs to obtain an OAuth2 access token from the Keycloak IdP server.
For this demo, we will obtain tokens using the resource owner password grant type.

You should be able to obtain tokens for any of these users:

| Username | Password | Roles        |  Level    |
|----------|----------|--------------|-----------|
| alice    | alice    | ADMIN        | Realm     |          
| bob      | bob      | USER         | Realm     |
| berit    | berit    | S_ADMIN      | SO_service|
| jan      | jan      | S_USER       | SO_service|

To obtain the auth JWT bearer token, use curl as below (Linux/Mac) or other relevant client (e.g., Postman):

```shell
export token=$(\
curl -X POST http://{IP-address}:8080/realms/SmartOcean/protocol/openid-connect/token \
-d 'client_id=SO_service' \
-d 'username=alice&password=alice&grant_type=password'| jq --raw-output '.access_token' \
)
```
(Make sure to have `jq` package installed.)
You can use the same command to obtain tokens on behalf of other users, by changing the `username` and `password` request parameters.

After running the command above, you can now access the `http://localhost:8090/api/v1/admin` endpoint
for the user `alice` with the `ADMIN` role (realm) as follows:

```shell
curl http://localhost:8090/api/v1/admin -H "Authorization: Bearer "$token
```

You should see the following response from the service:

```
{"Data":"This is a protected resource for ADMIN role."}