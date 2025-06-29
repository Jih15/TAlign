from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base

class Student(Base):
    __tablename__ = "students"

    student_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete ="CASCADE"), index=True)
    nim = Column(Integer, unique=True)
    full_name = Column(String(55))
    majors = Column(String(155))
    study_program = Column(String(155))
    created_at = Column(TIMESTAMP, server_default=func.now())
    updated_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="student", passive_deletes=True)
    submissions = relationship(
        "StudentSubmission",
        back_populates="student",
        cascade="all, delete"
    )

    submission_statuses = relationship(
        "SubmissionStatus",
        back_populates="student",
        cascade="all, delete"
    )
