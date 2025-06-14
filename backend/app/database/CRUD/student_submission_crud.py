from sqlalchemy.orm import Session
from sqlalchemy import and_
from app.database.models.student_submission_model import StudentSubmission
from app.database.models.user_model import User
from app.database.models.student_model import Student
from app.database.schemas.student_submission_schema import SubmissionCreate, SubmissionUpdate

def get_submission(db: Session, submission_id: int): 
    return db.query(StudentSubmission).filter(StudentSubmission.submission_id == submission_id).first()

# def get_submission_by 