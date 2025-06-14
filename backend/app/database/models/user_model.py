from sqlalchemy import Column, Integer, String, Enum, TIMESTAMP
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base
from app.utils.enum import UserRoleEnum

class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String(55), unique=True, index=True)
    email = Column(String(55), unique=True, index=True)
    password = Column(String(255))
    role = Column(Enum(UserRoleEnum), nullable=False)
    create_at = Column(TIMESTAMP, server_default=func.now())
    update_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationships
    student = relationship("Student", back_populates="user", uselist=False)
    lecturer = relationship("Lecturer", back_populates="user", uselist=False)
    submissions = relationship("StudentSubmission", back_populates="user")
    feedbacks = relationship("Feedback", back_populates="user")