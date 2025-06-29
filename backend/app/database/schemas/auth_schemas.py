from pydantic import BaseModel
from app.database.schemas.user_schema import UserOut

class LoginSchema(BaseModel):
    username: str
    password: str

class TokenSchema(BaseModel):
    access_token: str
    token_type: str = "bearer"

class LoginResponse(BaseModel):
    user: UserOut
    access_token: str
    token_type: str = "beaerer"