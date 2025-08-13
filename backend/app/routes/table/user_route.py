from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
import uuid
import os
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
# @router.put("/me", response_model=UserOut)
# def update_me(
#     user: UserUpdate,
#     db: Session = Depends(get_db),
#     current_user: UserModel = Depends(get_current_user)
# ):
#     return update_user(db=db, user_id=current_user.user_id, user_data=user)

@router.put("/me")
def update_me(
    username: str = Form(...),
    email: str = Form(...),
    photo: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user),
):
    if photo:
        upload_dir = "app/static/upload/profile_pic"
        os.makedirs(upload_dir, exist_ok=True)

        ext = os.path.splitext(photo.filename)[1]
        filename = f"{uuid.uuid4()}{ext}"
        file_location = os.path.join(upload_dir, filename)

        with open(file_location, "wb") as f:
            f.write(photo.file.read())

        current_user.profile_picture = f"/static/upload/profile_pic/{filename}"

    current_user.username = username
    current_user.email = email

    db.commit()
    db.refresh(current_user)
    return current_user



# ========================== ADMIN ========================== #

# Create user — ADMIN Only
# @router.post("/", response_model=UserOut)
# def create_new_user(
#     user: UserCreate,
#     db: Session = Depends(get_db),
#     current_user: UserModel = Depends(require_role(["ADMIN"]))  # Role Check
# ):
#     if get_user_by_email(db, email=user.email):
#         raise HTTPException(status_code=400, detail="Email already registered!")
#     return create_user(db=db, user=user, role=user.role)

@router.post("/", response_model=UserOut)
async def create_new_user(
    username: str = Form(...),
    email: str = Form(...),
    password: str = Form(...),
    role: UserRoleEnum = Form(...),
    photo: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(require_role(["ADMIN"]))  # Role Check
):
    if get_user_by_email(db, email=email):
        raise HTTPException(status_code=400, detail="Email already registered!")

    # Simpan foto jika ada
    photo_url = None
    if photo:
        UPLOAD_DIR = "app/static/upload/profile_pic"
        os.makedirs(UPLOAD_DIR, exist_ok=True)
        ext = os.path.splitext(photo.filename)[1]
        filename = f"{uuid.uuid4()}{ext}"
        file_location = os.path.join(UPLOAD_DIR, filename)

        with open(file_location, "wb") as f:
            content = await photo.read()
            f.write(content)

        photo_url = f"/static/upload/profile_pic/{filename}"

    # Bangun UserCreate schema
    user = UserCreate(
        username=username,
        email=email,
        password=password,
        role=role
    )

    return create_user(db=db, user=user, role=role, photo_url=photo_url)


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
# @router.put("/{user_id}", response_model=UserOut)
# def update_existing_user(
#     user_id: int,
#     user: UserUpdate,
#     db: Session = Depends(get_db),
#     current_user: UserModel = Depends(get_current_user)
# ):
#     if current_user.role.value != "ADMIN" and current_user.user_id != user_id:
#         raise HTTPException(status_code=403, detail="Access forbidden: cannot update this user")
#     target_user = get_user(db, user_id=user_id)
#     if not target_user:
#         raise HTTPException(status_code=404, detail="User not found!")
#     return update_user(db=db, user_id=user_id, user_data=user)

@router.put("/{user_id}", response_model=UserOut)
async def update_existing_user(
    user_id: int,
    username: str = Form(None),
    email: str = Form(None),
    password: str = Form(None),
    photo: UploadFile = File(None),
    db: Session = Depends(get_db),
    current_user: UserModel = Depends(get_current_user)
):
    if current_user.role.value != "ADMIN" and current_user.user_id != user_id:
        raise HTTPException(status_code=403, detail="Access forbidden: cannot update this user")

    target_user = get_user(db, user_id=user_id)
    if not target_user:
        raise HTTPException(status_code=404, detail="User not found!")

    # Handle foto
    photo_url = target_user.profile_picture
    if photo:
        UPLOAD_DIR = "app/static/upload/profile_pic"
        os.makedirs(UPLOAD_DIR, exist_ok=True)
        ext = os.path.splitext(photo.filename)[1]
        filename = f"{uuid.uuid4()}{ext}"
        file_location = os.path.join(UPLOAD_DIR, filename)
        with open(file_location, "wb") as f:
            content = await photo.read()
            f.write(content)
        photo_url = f"/static/upload/profile_pic/{filename}"

    # Bangun UserUpdate schema
    user_data = UserUpdate(
        username=username,
        email=email,
        password=password,
        profile_picture=photo_url
    )

    return update_user(db=db, user_id=user_id, user_data=user_data)


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

