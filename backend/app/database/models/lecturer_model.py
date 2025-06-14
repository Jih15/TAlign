from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base

class Lecturer(Base):
    __tablename__ = "lecturers"

    lecturer_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), index=True)
    fullname = Column(String(55))
    nip = Column(Integer, unique=True)
    field = Column(String(155))
    create_at = Column(TIMESTAMP, server_default=func.now())
    update_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="lecturer")
    submission_statuses = relationship("SubmissionStatus", back_populates="lecturer")