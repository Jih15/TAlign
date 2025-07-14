from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional
from app.utils.enum import SubmissionStatusEnum
from app.database.schemas.student_submission_schema import SubmissionOutAlt
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

class StatusOut(BaseModel):
    status_id: int
    submission_id: int
    student_id: int
    lecturer_id: Optional[int] = None
    status: SubmissionStatusEnum
    created_at: datetime
    updated_at: datetime
    # submission: Optional[SubmissionOutAlt] = Field(None, alias="student_submission")
    # student: Optional[StudentOut] = None
    # lecturer: Optional[LecturerOut] = None

    model_config = {
        "from_attributes": True,
        "populate_by_name": True  
    }