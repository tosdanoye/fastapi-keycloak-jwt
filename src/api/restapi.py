from fastapi import FastAPI, Depends, status
from kc.auth import verify_admin_role, verify_user_role, verify_sadmin_role, verify_suser_role

app = FastAPI()


@app.get('/api/v1/admin')
def protected_admin(admin: bool = Depends(verify_admin_role)):
    return {"Data": "This is a protected resource for ADMIN role."}


@app.get('/api/v1/admin/service')
def protected_sadmin(admin: bool = Depends(verify_sadmin_role)):
    return {"Data": "This is a protected resource for S_ADMIN role."}


@app.get('/api/v1/protected')
def protected_user(user: bool = Depends(verify_user_role)):
    return {"Data": "This is a protected resource for USER role."}


@app.get('/api/v1/protected/service')
def protected_suser(user: bool = Depends(verify_suser_role)):
    return {"Data": "This is a protected resource for S_USER role."}


@app.get('/api/v1/public', status_code=status.HTTP_200_OK)
def public_user():
    return {"Data": "This is a public resource for everyone."}
