from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from app.database.models.student_submission_model import StudentSubmission
from app.database.models.submission_status_model import SubmissionStatus
from app.database.models.student_model import Student
from app.database.schemas.student_submission_schema import SubmissionCreate, SubmissionUpdate
from app.utils.enum import SubmissionStatusEnum, DifficultyEnum, IdeaSourceEnum
from datetime import datetime, timezone

def get_submissions(db: Session, skip: int = 0, limit: int = 100):
    return db.query(StudentSubmission).offset(skip).limit(limit).all()

def get_submission(db: Session, submission_id: int): 
    return db.query(StudentSubmission).filter(StudentSubmission.submission_id == submission_id).first()

def get_submission_by_student(db: Session, student_id: int):
    return db.query(StudentSubmission).filter(StudentSubmission.student_id == student_id).all()

# def create_submission(db: Session, submission: SubmissionCreate, student_id: int):
    student = db.query(Student).filter(Student.student_id == student_id).first()
    if not student:
        raise ValueError("Student not found")

    try:
        db_submission = StudentSubmission(
            **submission.model_dump(exclude_unset=True),
            student_id=student_id,
            # title_status=SubmissionStatusEnum.WAITING
        )
        db.add(db_submission)
        db.commit()
        db.refresh(db_submission)

        db_status = SubmissionStatus(
            submission_id=db_submission.submission_id,
            student_id=student_id,
            status = SubmissionStatusEnum.WAITING,
            created_at=datetime.now(timezone.utc)
        )
        db.add(db_status)
        db.commit()

        return db_submission
    except IntegrityError:
        db.rollback()
        raise ValueError("Submission creation failed")

from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from app.database.models.student_submission_model import StudentSubmission
from app.database.models.submission_status_model import SubmissionStatus
from app.database.models.student_model import Student
from app.utils.enum import SubmissionStatusEnum, IdeaSourceEnum
from datetime import datetime, timezone

def create_submission(db: Session, submission_data: dict, student_id: int, file_path: str):
    student = db.query(Student).filter(Student.student_id == student_id).first()
    if not student:
        raise ValueError("Student not found")
    
    try:
        # Validate idea_source
        submission_data['idea_source'] = IdeaSourceEnum(submission_data['idea_source'])

        # Create submission
        db_submission = StudentSubmission(
            **submission_data,
            student_id=student_id,
            file_path=file_path
        )
        db.add(db_submission)
        db.commit()
        db.refresh(db_submission)

        # Create status entry
        db_status = SubmissionStatus(
            submission_id=db_submission.submission_id,
            student_id=student_id,
            status=SubmissionStatusEnum.WAITING,
            created_at=datetime.now(timezone.utc)
        )
        db.add(db_status)
        db.commit()

        return db_submission
    except IntegrityError as e:
        db.rollback()
        raise ValueError(f"Submission creation failed: {str(e)}")
    except ValueError as e:
        db.rollback()
        raise ValueError(f"Submission creation failed: {str(e)}")

def update_submission(db: Session, submission_id: int, update_data: SubmissionUpdate):
    db_submission = get_submission(db, submission_id)
    if not db_submission:
        raise ValueError("Submission not found")

    for field, value in update_data.model_dump(exclude_unset=True).items():
        setattr(db_submission, field, value)

    db.commit()
    db.refresh(db_submission)
    return db_submission

def delete_submission(db: Session, submission_id: int):
    db_submission = get_submission(db, submission_id)
    if not db_submission:
        raise ValueError("Submission not found")

    db.delete(db_submission)
    db.commit()
    return {"message" : "Submission deleted!"}
