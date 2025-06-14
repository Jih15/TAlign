from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP, Enum, Float
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base
from app.utils.enum import DifficultyEnum, IdeaSourceEnum, StatusEnum

class StudentSubmission(Base):
    __tablename__ = "student_submissions"

    submission_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), index=True)
    title = Column(String(255))
    title_field = Column(String(100))
    difficulty = Column(Enum(DifficultyEnum))
    idea_source = Column(Enum(IdeaSourceEnum))
    title_status = Column(Enum(StatusEnum))
    simmilarity_score = Column(Float)
    create_at = Column(TIMESTAMP, server_default=func.now())
    update_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="submissions")
    statuses = relationship("SubmissionStatus", back_populates="student_submission")