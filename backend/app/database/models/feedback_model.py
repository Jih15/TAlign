from sqlalchemy import Column, Integer, ForeignKey, TIMESTAMP, Enum, Float, String
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database.session import Base

class Feedback(Base):
    __tablename__ = "feedbacks"

    feedback_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), index=True)
    rating = Column(Integer)
    comment = Column(String(155))
    created_at = Column(TIMESTAMP, server_default=func.now())
    updated_at = Column(TIMESTAMP, server_default=func.now(), onupdate=func.now())

    # Relationship
    user = relationship("User", back_populates="feedbacks")