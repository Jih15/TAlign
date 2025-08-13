from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.lecturer_crud import (
    get_lecturer, get_lecturers, create_lecturer,
    update_lecturer, delete_lecture
)
from app.database.schemas.lecturer_schema import LecturerCreate, LecturerUpdate, LecturerOut
from app.database.models.user_model import User
from app.database.mysql import get_db
from app.utils.dependencies import require_role

router = APIRouter(prefix="/lecturers", tags=["lecturers"])

# ===================== Lecturer data of himself ==================== #

# Get my lecturer data
@router.get("/me", response_model=LecturerOut)
def read_me(
    user: User = Depends(require_role(["DOSEN"])),
    db: Session = Depends(get_db)
):
    if not user.lecturer:
        raise HTTPException(status_code=404, detail="Lecturer data not found!")
    
    return user.lecturer

# Update myself
@router.put("/me", response_model=LecturerOut)
def update_me(
    lecturer_data: LecturerUpdate,
    user: User = Depends(require_role(["DOSEN"])),
    db: Session = Depends(get_db)
):
    if not user.lecturer:
        raise HTTPException(status_code=404, detail="Lecturer profile not found!")
    
    update_data = update_lecturer(
        db=db,
        lecturer_id=user.lecturer.lecturer_id,
        lecture=lecturer_data
    )

    if update_lecturer is None:
        raise HTTPException(status_code=404, detail="Lecturer not found!")
    
    return update_data

# =========================== ADMIN ================================= #


@router.post("/", response_model=LecturerOut)
def create_new_lecturer(lecturer: LecturerCreate, db: Session = Depends(get_db)):
    try: 
        return create_lecturer(db=db, lecture=lecturer)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    
# GET ALL
@router.get("/", response_model=list[LecturerOut])
def read_lecturers(
    skip: int = 0,
    limit: int = 100,
    user: User = Depends(require_role(["ADMIN"])),
    db: Session = Depends(get_db)
):
    return get_lecturers(db, skip=skip, limit=limit)

# GET: ADMIN bisa lihat semua, DOSEN hanya bisa lihat dirinya sendiri
@router.get("/{lecturer_id}", response_model=LecturerOut)
def read_lecturer(
    lecturer_id: int, 
    user: User = Depends(require_role(["ADMIN", "DOSEN"])),
    db: Session = Depends(get_db)
):
    if user.role.value == "DOSEN":
        if not user.lecturer or user.lecturer.lecturer_id != lecturer_id:
            raise HTTPException(status_code=403, detail="You can only access your own lecturer data.")
        
    lecturer = get_lecturer(db, lecturer_id=lecturer_id)
    if lecturer is None:
        raise HTTPException(status_code=404, detail="Lecturer not found!")
    return lecturer

# PUT: ADMIN bisa update semua, DOSEN hanya update dirinya sendiri
@router.put("/{lecturer_id}", response_model=LecturerOut)
def update_existing_lecturer(
    lecturer_id: int,
    lecture: LecturerUpdate,
    user: User = Depends(require_role(["ADMIN" , "DOSEN"])),
    db: Session = Depends(get_db)
):
    if user.role.value == "DOSEN":
        if not user.lecturer or user.lecturer.lecturer_id != lecturer_id:
            raise HTTPException(status_code=403, detail="You can only update your own student data.")      
    try:
        data = update_lecturer(db=db, lecturer_id=lecturer_id, lecture=lecture)
        if data is None:
            raise HTTPException(status_code=404, detail="Lecturer not found!")
        return data
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.delete("/{lecturer_id}")
def delete_existing_lecturer(lecturer_id: int, db: Session = Depends(get_db)):
    if not delete_lecture(db=db, lecturer_id=lecturer_id):
        raise HTTPException(status_code=404, detail="Lecturer not found!")
    return {"message" : "Lecturer deleted successfully!"}