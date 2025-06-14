from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.database.schemas.user_schema import UserOut

class LecturerBase(BaseModel):
    nip: int
    full_name: str
    field: str

class LecturerCreate(LecturerBase):
    user_id: int

class LecturerUpdate(BaseModel):
    nip: Optional[int] = None
    full_name: Optional[str] = None
    field: Optional[str] = None

class LecturerOut(LecturerBase):
    lecturer_id: int
    user_id: int
    created_at: datetime
    update_at: datetime
    user: UserOut

    model_config = {
        "from_attributes": True
    }