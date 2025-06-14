from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.utils.enum import DifficultyEnum, IdeaSourceEnum, StatusEnum
from app.database.schemas.user_schema import UserOut
from app.database.schemas.student_schema import StudentOut

class SubmissionBase(BaseModel):
    title: str
    title_field: str
    difficulty: DifficultyEnum
    idea_source: IdeaSourceEnum
    title_status: StatusEnum
    simmilarity_score: Optional[float] = None

class SubmissionCreate(SubmissionBase):
    user_id: int

class SubmissionUpdate(BaseModel):
    title: Optional[str] = None
    title_field: Optional[str] = None
    difficulty: Optional[DifficultyEnum] = None
    idea_source: Optional[IdeaSourceEnum] = None
    title_status: Optional[StatusEnum] = None
    simmilarity_score: Optional[float] = None

class SubmissionOut(SubmissionBase):
    submission_id: int
    user_id: int
    created_at: datetime
    updated_at: datetime
    user: UserOut
    student: Optional[StudentOut] = None

    model_config = {
        "from_attributes": True
    }