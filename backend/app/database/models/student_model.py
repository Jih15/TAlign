from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base

class Student(Base):
    __tablename__ = "students"

    student_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), index=True)
    nim = Column(Integer, unique=True)
    full_name = Column(String(55))
    majors = Column(String(155))
    study_program = Column(String(155))
    create_at = Column(TIMESTAMP, server_default=func.now())
    update_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="student")
    submission_statuses = relationship("SubmissionStatus", back_populates="student")