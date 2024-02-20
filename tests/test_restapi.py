import os

from dotenv import load_dotenv
from fastapi.testclient import TestClient

from api.restapi import app

client = TestClient(app)


def test_public_api():
    response = client.get('/api/v1/public')
    assert response.status_code == 200
    assert response.json() == {"Data": "This is a public resource for everyone."}


def test_protected_admin_endpoint():
    load_dotenv()
    acc_token = os.environ.get('token')
    _headers = {"Authorization": f"Bearer {acc_token}"}
    response = client.get('/api/v1/admin', headers=_headers)
    print(response.headers)
    assert response.status_code == 200
    assert response.json() == {"Data": "This is a protected resource for ADMIN role."}
