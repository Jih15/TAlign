from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.utils.enum import SubmissionStatusEnum
from app.database.schemas.student_submission_schema import SubmissionOut
from app.database.schemas.student_schema import StudentOut
from app.database.schemas.lecturer_schema import LecturerOut

class StatusBase(BaseModel):
    submission_id: int
    student_id: int
    lecturer_id: Optional[int] = None
    status: SubmissionStatusEnum

class StatusCreate(StatusBase):
    pass

class StatusUpdate(BaseModel):
    status: Optional[SubmissionStatusEnum] = None

class StatusOut(StatusBase):
    status_id: int
    created_at: datetime
    updated_at: datetime

    model_config = {
        "from_attributes": True
    }