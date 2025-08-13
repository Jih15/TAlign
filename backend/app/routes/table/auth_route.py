from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.mysql import get_db
from app.database.schemas.auth_schemas import LoginSchema, TokenSchema, LoginResponse
from app.database.CRUD.auth_crud import authenticate_user
from app.database.CRUD.user_crud import get_user_by_email, create_user
from app.database.models.user_model import User
from app.database.schemas.user_schema import UserCreate, UserOut, UserPublicCreate
from app.utils.security import create_access_token
from app.utils.dependencies import get_current_user
from app.utils.enum import UserRoleEnum
from app.core.config.config import settings

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login", response_model=LoginResponse)
def login_user(data: LoginSchema, db:Session = Depends(get_db)):
    user = authenticate_user(db, username=data.username, password=data.password)

    if user == "username_not_found":
        raise HTTPException(status_code=401, detail="Invalid username!")
    
    elif user == "wrong_password":
        raise HTTPException(status_code=401, detail="Invalid password!")
    
    token,expire = create_access_token(
        data={"sub" : str(user.user_id), "role": user.role.value}
    )

    return {
        "user" : user,
        "access_token": token,
        "token_type": "bearer",
        "expires_at": expire.isoformat()
    }

@router.post("/register/student", response_model=UserOut)
def register_student(user: UserPublicCreate, db: Session = Depends(get_db)):
    if get_user_by_email(db, email=user.email):
        raise HTTPException(status_code=400, detail="Email already registered!")

    return create_user(db=db, user=user, role=UserRoleEnum.MAHASISWA)

@router.post("/register/lecturer", response_model=UserOut)
def register_lecturer(user: UserPublicCreate, db: Session = Depends(get_db)):
    if get_user_by_email(db, email=user.email):
        raise HTTPException(status_code=400, detail="Email already registered!")

    return create_user(db=db, user=user, role=UserRoleEnum.DOSEN)


@router.get("/me", response_model=UserOut)
def get_current_login(
    current_user: User = Depends(get_current_user)
):
    return current_user