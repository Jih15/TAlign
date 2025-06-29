from pydantic import BaseModel, EmailStr
from app.utils.enum import UserRoleEnum
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    username: str
    email: EmailStr

class UserCreate(UserBase):
    password: str
    role: UserRoleEnum

class UserPublicCreate(UserBase):
    password: str

class UserUpdate(BaseModel):
    username: str | None = None
    email: EmailStr | None = None
    password: str | None = None
    role: UserRoleEnum | None = None

class UserOut(UserBase):
    user_id: int
    role: UserRoleEnum
    created_at: datetime
    updated_at: datetime

    model_config = {
        "from_attributes": True
    }