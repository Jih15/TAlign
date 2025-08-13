from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.student_crud import (
    get_student, get_students, create_student, 
    update_student, delete_student
)
from app.database.schemas.student_schema import StudentCreate, StudentUpdate, StudentOut
from app.database.mysql import get_db
from app.utils.dependencies import require_role
from app.database.models.user_model import User

router = APIRouter(prefix="/students", tags=["Students"])

# ========================Student data of himself=====================#

# Get my student data
@router.get("/me", response_model=StudentOut)
def read_me(
    user: User = Depends(require_role(["MAHASISWA"])),
    db: Session = Depends(get_db)
):
    if not user.student:
        raise HTTPException(status_code=404, detail="Student data not found!")

    return user.student

# Update myself
@router.put("/me", response_model=StudentOut)
def update_me(
    student_data: StudentUpdate,
    user: User = Depends(require_role(["MAHASISWA"])),
    db: Session = Depends(get_db),
):
    if not user.student:
        raise HTTPException(status_code=404, detail="Student profile not found!")
    
    update_data = update_student(
        db=db,
        student_id =user.student.student_id,
        student=student_data
    )

    if update_student is None:
        raise HTTPException(status_code=404, detail="Student not found!")
    
    return update_data


# ========================== ADMIN ================================ #

# POST: hanya ADMIN yang bisa menambahkan data mahasiswa
@router.post("/", response_model=StudentOut)
def create_new_student(
    student: StudentCreate,
    user: User = Depends(require_role(["ADMIN"])),
    db: Session = Depends(get_db)
):
    try:
        return create_student(db=db, student=student)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


# GET ALL: hanya ADMIN yang bisa melihat semua data mahasiswa
@router.get("/", response_model=list[StudentOut])
def read_students(
    skip: int = 0,
    limit: int = 100,
    user: User = Depends(require_role(["ADMIN"])),
    db: Session = Depends(get_db)
):
    return get_students(db, skip=skip, limit=limit)


# GET: ADMIN bisa lihat semua, MAHASISWA hanya bisa lihat dirinya sendiri
@router.get("/{student_id}", response_model=StudentOut)
def read_student(
    student_id: int,
    user: User = Depends(require_role(["ADMIN", "MAHASISWA"])),
    db: Session = Depends(get_db)
):
    # MAHASISWA hanya boleh akses data dirinya
    if user.role.value == "MAHASISWA":
        if not user.student or user.student.student_id != student_id:
            raise HTTPException(status_code=403, detail="You can only access your own student data.")

    student = get_student(db, student_id=student_id)
    if student is None:
        raise HTTPException(status_code=404, detail="Student not found!")
    return student


# PUT: ADMIN bisa update semua, MAHASISWA hanya update dirinya sendiri
@router.put("/{student_id}", response_model=StudentOut)
def update_existing_student(
    student_id: int,
    student: StudentUpdate,
    user: User = Depends(require_role(["ADMIN", "MAHASISWA"])),
    db: Session = Depends(get_db)
):
    if user.role.value == "MAHASISWA":
        if not user.student or user.student.student_id != student_id:
            raise HTTPException(status_code=403, detail="You can only update your own student data.")

    try:
        data = update_student(db=db, student_id=student_id, student=student)
        if data is None:
            raise HTTPException(status_code=404, detail="Student not found!")
        return data
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


# DELETE: hanya ADMIN yang bisa menghapus
@router.delete("/{student_id}")
def delete_existing_student(
    student_id: int,
    user: User = Depends(require_role(["ADMIN"])),
    db: Session = Depends(get_db)
):
    if not delete_student(db=db, student_id=student_id):
        raise HTTPException(status_code=404, detail="Student not found!")
    return {"message": "Student deleted successfully!"}


