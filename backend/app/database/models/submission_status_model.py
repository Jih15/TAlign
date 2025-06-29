from sqlalchemy import Column, Integer, ForeignKey, TIMESTAMP, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base
from app.utils.enum import SubmissionStatusEnum

class SubmissionStatus(Base):
    __tablename__ = "submission_status"

    status_id = Column(Integer, primary_key=True, index=True)
    submission_id = Column(Integer, ForeignKey("student_submissions.submission_id", ondelete ="CASCADE"), index=True)
    student_id = Column(Integer, ForeignKey("students.student_id", ondelete="CASCADE"), index=True)
    lecturer_id = Column(Integer, ForeignKey("lecturers.lecturer_id", ondelete="CASCADE"), index=True)
    status = Column(Enum(SubmissionStatusEnum))
    created_at = Column(TIMESTAMP, server_default=func.now())
    updated_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    student_submission = relationship("StudentSubmission", back_populates="statuses")
    student = relationship("Student", back_populates="submission_statuses")
    lecturer = relationship("Lecturer", back_populates="submission_statuses")