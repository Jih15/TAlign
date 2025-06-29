from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from app.database.models.feedback_model import Feedback
from app.database.models.user_model import User
from app.database.schemas.feedback_schema import FeedbackCreate

def get_feedback(db: Session, feedback_id: int):
    return db.query(Feedback).filter(Feedback.feedback_id == feedback_id).first()

def get_feedbacks(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Feedback).offset(skip).limit(limit).all()

def create_feedback(db: Session, feedback: FeedbackCreate):
    # Validasi: user harus terdaftar
    db_user = db.query(User).filter(User.user_id == feedback.user_id).first()
    if not db_user:
        raise ValueError("User not found")

    # Validasi: rating antara 1 - 5
    if feedback.rating < 1 or feedback.rating > 5:
        raise ValueError("Rating must be between 1 and 5")

    try:
        db_feedback = Feedback(**feedback.model_dump())
        db.add(db_feedback)
        db.commit()
        db.refresh(db_feedback)
        return db_feedback
    except IntegrityError:
        db.rollback()
        raise ValueError("Failed to create feedback")
