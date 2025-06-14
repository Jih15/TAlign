from sqlalchemy.orm import Session
from app.database.models.user_model import User
from app.database.schemas.user_schema import UserCreate, UserUpdate
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_user(db: Session, user_id: int):
    return db.query(User).filter(User.user_id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()

def get_user_by_username(db: Session, username:str):
    return db.query(User).filter(User.username == username).first()

def get_users(db: Session, skip: int = 0, limit: int = 100):
    return db.query(User).offset(skip).limit(limit).all()

def create_user(db: Session, user: UserCreate):
    hashed_password = pwd_context.hash(user.password)
    data = User(
        username = user.username,
        email = user.email,
        password = hashed_password,
        role = user.role
    )

    db.add(data)
    db.commit()
    db.refresh(data)
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

def authenticate_user(db: Session, username: str, password: str):
    user = get_user_by_username(db, username)
    if not user:
        return None
    if not pwd_context.verify(password, user.password):
        return None
    return User
