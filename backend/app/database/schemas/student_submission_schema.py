from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.utils.enum import DifficultyEnum, IdeaSourceEnum, SubmissionStatusEnum
from app.database.schemas.user_schema import UserOut
from app.database.schemas.student_schema import StudentOut

class SubmissionBase(BaseModel):
    title: str
    title_field: str
    difficulty: DifficultyEnum
    idea_source: IdeaSourceEnum
    title_status: Optional[SubmissionStatusEnum] = None
    similarity_score: Optional[float] = None

class SubmissionCreate(SubmissionBase):
    # student_id: int
    pass

class SubmissionUpdate(BaseModel):
    title: Optional[str] = None
    title_field: Optional[str] = None
    difficulty: Optional[DifficultyEnum] = None
    idea_source: Optional[IdeaSourceEnum] = None
    title_status: Optional[SubmissionStatusEnum] = None
    similarity_score: Optional[float] = None

class SubmissionOut(SubmissionBase):
    submission_id: int
    student_id: int
    created_at: datetime
    updated_at: datetime
    # user: UserOut
    student: Optional[StudentOut] 

    model_config = {
        "from_attributes": True
    }