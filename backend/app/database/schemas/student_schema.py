from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.database.schemas.user_schema import UserOut

class StudentBase(BaseModel):
    nim: int
    full_name: str
    majors: str
    study_program: str

class StudentCreate(StudentBase):
    user_id: int

class StudentUpdate(BaseModel):
    nim: Optional[int] = None
    full_name: Optional[str] = None
    majors: Optional[str] = None
    study_program: Optional[str] = None

class StudentOut(StudentBase):
    student_id: int
    user_id: int
    created_at: datetime
    updated_at: datetime
    user: UserOut

    model_config = {
        "from_attributes": True
    }