from pydantic import BaseModel, EmailStr
from app.utils.enum import UserRoleEnum
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    username: str
    email: EmailStr
    profile_picture: Optional[str] = None

class UserCreate(UserBase):
    password: str
    role: UserRoleEnum

class UserPublicCreate(UserBase):
    password: str
    profile_picture: Optional[str] = None


class UserUpdate(BaseModel):
    username: str | None = None
    email: EmailStr | None = None
    password: str | None = None
    role: UserRoleEnum | None = None
    profile_picture: str | None = None 

class UserOut(UserBase):
    user_id: int
    role: UserRoleEnum
    created_at: datetime
    updated_at: datetime
    profile_picture: Optional[str] = None 

    model_config = {
        "from_attributes": True
    }
