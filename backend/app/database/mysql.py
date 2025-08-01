from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from app.core.config.config import settings

SQLALCHEMY_DATABASE_URL = settings.mysql_database_url

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def get_db_instance() -> Session:
    return SessionLocal()