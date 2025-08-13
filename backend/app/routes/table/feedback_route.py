from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.schemas.feedback_schema import FeedbackCreate, FeedbackOut
from app.database.CRUD.feedback_crud import (
    get_feedback,
    get_feedbacks,
    create_feedback
)
from app.database.mysql import get_db

router = APIRouter(
    prefix="/feedback",
    tags=["Feedback"]
)

@router.get("/", response_model=list[FeedbackOut])
def read_feedbacks(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return get_feedbacks(db, skip, limit)

@router.get("/{feedback_id}", response_model=FeedbackOut)
def read_feedback(feedback_id: int, db: Session = Depends(get_db)):
    feedback = get_feedback(db, feedback_id)
    if not feedback:
        raise HTTPException(status_code=404, detail="Feedback not found")
    return feedback

@router.post("/", response_model=FeedbackOut)
def submit_feedback(feedback: FeedbackCreate, db: Session = Depends(get_db)):
    try:
        return create_feedback(db, feedback)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
