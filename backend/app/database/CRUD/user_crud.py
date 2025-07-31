from sqlalchemy.orm import Session
from app.database.models.user_model import User
from app.database.models.student_model import Student
from app.database.models.lecturer_model import Lecturer
from app.database.schemas.user_schema import UserCreate, UserUpdate
from app.utils.enum import UserRoleEnum
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_user(db: Session, user_id: int):
    return db.query(User).filter(User.user_id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()

def get_user_by_username(db: Session, username: str):
    return db.query(User).filter(User.username == username).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(User).offset(skip).limit(limit).all()

def create_user(db: Session, user: UserCreate, role: UserRoleEnum):
    hashed_password = pwd_context.hash(user.password)
    
    data = User(
        username=user.username,
        email=user.email,
        password=hashed_password,
        role=role
    )

    db.add(data)
    db.commit()
    db.refresh(data)

    if role == UserRoleEnum.MAHASISWA:
        student = Student(
            user_id=data.user_id,
            full_name=data.username,
            majors = "Teknologi Informasi"  
        )
        db.add(student)

    elif role == UserRoleEnum.DOSEN:
        lecturer = Lecturer(
            user_id=data.user_id,
            fullname=data.username
        )
        db.add(lecturer)

    db.commit()
    return data

def update_user(db: Session, user_id: int, user_data: UserUpdate):
    data = get_user(db, user_id)
    if not data:
        return None

    update_data = user_data.model_dump(exclude_unset=True)

    if "password" in update_data:
        update_data["password"] = pwd_context.hash(update_data["password"])

    for field, value in update_data.items():
        setattr(data, field, value)

    db.commit()
    db.refresh(data)
    return data

def delete_user(db: Session, user_id: int):
    data = get_user(db, user_id)
    if not data:
        return False

    db.delete(data)
    db.commit()
    return True
