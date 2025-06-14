from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.user_crud import (
    get_user, get_users, create_user, 
    update_user, delete_user, get_user_by_email
)
from app.database.schemas.user_schema import UserCreate, UserUpdate, UserOut
from app.database.mysql import get_db 

router = APIRouter(prefix="/users" , tags=["users"])

@router.post("/", response_model=UserOut)
def create_new_user(user: UserCreate, db: Session = Depends(get_db)):
    data = get_user_by_email(db, email=user.email)
    if data:
        raise HTTPException(status_code=400, detail="Email already registered!")
    return create_user(db=db, user=user)

@router.get("/", response_model=list[UserOut])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    users = get_users(db, skip=skip, limit=limit)
    return users

@router.get("/{user_id}", response_model=UserOut)
def read_user(user_id: int, db: Session = Depends(get_db)):
    data = get_user(db, user_id=user_id)
    if data is None:
        raise HTTPException(status_code=404, detail="User not found!")
    return data

@router.put("/{user_id}", response_model=UserOut)
def update_existing_user(
    user_id: int,
    user: UserUpdate,
    db: Session = Depends(get_db)
):
    data = get_user(db, user_id=user_id)
    if data is None:
        raise HTTPException(status_code=404, detail="User not found!")
    return update_user(db=db, user_id=user_id, user_data=user)

@router.delete("/{user_id}")
def delete_existing_user(user_id: int, db: Session = Depends(get_db)):
    if not delete_user(db=db, user_id=user_id):
        raise HTTPException(status_code=404, detail="User not found!")
    return {"message" : "User deleted successfully!"}