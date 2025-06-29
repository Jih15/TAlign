from sqlalchemy.orm import Session
from app.database.models.user_model import User
from app.utils.security import verify_password
from app.database.CRUD.user_crud import get_user_by_username

def authenticate_user(db: Session, username: str, password: str):
    user = get_user_by_username(db, username)
    if not user:
        return "username_not_found"
    if not verify_password(password, user.password):
        return "wrong_password"
    return user
