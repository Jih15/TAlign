from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base
from app.utils.enum import DifficultyEnum, IdeaSourceEnum, SubmissionStatusEnum

class StudentSubmission(Base):
    __tablename__ = "student_submissions"

    submission_id = Column(Integer, primary_key=True, index=True)
    student_id = Column(Integer, ForeignKey("students.student_id", ondelete ="CASCADE"), index=True)
    title = Column(String(255))
    title_field = Column(String(100))
    difficulty = Column(Enum(DifficultyEnum))
    idea_source = Column(Enum(IdeaSourceEnum))
    title_status = Column(Enum(SubmissionStatusEnum))
    similarity_score = Column(Float)
    created_at = Column(TIMESTAMP, server_default=func.now())
    updated_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    student = relationship("Student", back_populates="submissions")
    statuses = relationship(
        "SubmissionStatus",
        back_populates="student_submission",
        cascade="all, delete"
    )
