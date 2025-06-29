from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.user_crud import (
    get_user, get_users, create_user, 
    update_user, delete_user, get_user_by_email
)
from app.database.schemas.user_schema import UserCreate, UserUpdate, UserOut
from app.database.mysql import get_db 
from app.utils.dependencies import get_current_user, require_role
from app.database.models.user_model import User as UserModel
from app.utils.enum import UserRoleEnum

router = APIRouter(
    prefix="/users",
    tags=["users"],
    dependencies=[Depends(get_current_user)]  
)



# ======================Profile of current user===================== #

# Get current user
@router.get("/me", response_model=UserOut)
def read_me(current_user: UserModel = Depends(get_current_user)):
    return current_user

# Update myself
@router.put("/me", response_model=UserOut)
def update_me(
    user: UserUpdate,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user)
):
    return update_user(db=db, user_id=current_user.user_id, user_data=user)


# ========================== ADMIN ========================== #

# Create user — ADMIN Only
@router.post("/", response_model=UserOut)
def create_new_user(
    user: UserCreate,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(require_role(["ADMIN"]))  # Role Check
):
    if get_user_by_email(db, email=user.email):
        raise HTTPException(status_code=400, detail="Email already registered!")
    return create_user(db=db, user=user, role=user.role)

# Get all users — ADMIN only
@router.get("/", response_model=list[UserOut])
def read_users(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(require_role(["ADMIN"]))
):
    return get_users(db, skip=skip, limit=limit)

# Get specific user — ADMIN atau user itu sendiri
@router.get("/{user_id}", response_model=UserOut)
def read_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user)  # user pasti sudah login
):
    if current_user.role.value != "ADMIN" and current_user.user_id != user_id:
        raise HTTPException(status_code=403, detail="Access forbidden: not your data")
    user = get_user(db, user_id=user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found!")
    return user

# Update user — ADMIN bebas, user biasa hanya dirinya
@router.put("/{user_id}", response_model=UserOut)
def update_existing_user(
    user_id: int,
    user: UserUpdate,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user)
):
    if current_user.role.value != "ADMIN" and current_user.user_id != user_id:
        raise HTTPException(status_code=403, detail="Access forbidden: cannot update this user")
    target_user = get_user(db, user_id=user_id)
    if not target_user:
        raise HTTPException(status_code=404, detail="User not found!")
    return update_user(db=db, user_id=user_id, user_data=user)

# Delete user — hanya ADMIN
@router.delete("/{user_id}")
def delete_existing_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(require_role(["ADMIN"]))
):
    if not delete_user(db=db, user_id=user_id):
        raise HTTPException(status_code=404, detail="User not found!")
    return {"message": "User deleted successfully!"}

