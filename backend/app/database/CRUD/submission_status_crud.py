from sqlalchemy.orm import Session
from app.database.models.submission_status_model import SubmissionStatus
from app.database.models.lecturer_model import Lecturer
from app.database.models.student_submission_model import StudentSubmission
from app.utils.enum import SubmissionStatusEnum
from datetime import datetime, timezone

def get_status(db: Session, status_id: int):
    return db.query(SubmissionStatus).filter(SubmissionStatus.status_id == status_id).first()

def get_submission_statuses(db: Session, submission_id: int):
    return db.query(SubmissionStatus).filter(
        SubmissionStatus.submission_id == submission_id
    ).all()

def get_all_status(db:Session, skip: int = 0, limit: int = 100):
    return db.query(SubmissionStatus).offset(skip).limit(limit).all()

def insert_new_status(
    db: Session,
    submission_id: int,
    lecturer_id: int,
    new_status: SubmissionStatusEnum
):
    submission = db.query(StudentSubmission).filter(StudentSubmission.submission_id == submission_id).first()
    if not submission:
        raise ValueError("Submission not found")

    lecturer = db.query(Lecturer).filter(Lecturer.lecturer_id == lecturer_id).first()
    if not lecturer:
        raise ValueError("Lecturer not found")

    # Buat entry status baru (history)
    new_status_entry = SubmissionStatus(
        submission_id=submission_id,
        student_id=submission.student_id,
        lecturer_id=lecturer_id,
        status=new_status,
        submitted_at=datetime.now(timezone.utc)
    )
    db.add(new_status_entry)

    # Update status terbaru di tabel submission
    submission.title_status = new_status

    db.commit()
    db.refresh(new_status_entry)
    return new_status_entry
