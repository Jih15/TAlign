from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional
from app.database.schemas.user_schema import UserOut

# Base schema
class FeedbackBase(BaseModel):
    rating: int = Field(..., ge=1, le=5, description="Rating between 1 (worst) and 5 (best)")
    comment: Optional[str] = Field(None, description="Optional feedback comment")

# Schema for creation
class FeedbackCreate(FeedbackBase):
    user_id: int

# Schema for response/output
class FeedbackOut(FeedbackBase):
    feedback_id: int
    user_id: int
    created_at: datetime
    updated_at: datetime
    user: UserOut

    model_config = {
        "from_attributes": True
    }
