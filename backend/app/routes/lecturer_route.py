from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.lecturer_crud import (
    get_lecturer, get_lecturers, create_lecturer,
    update_lecturer, delete_lecture
)
from app.database.schemas.lecturer_schema import LecturerCreate, LecturerUpdate, LecturerOut
from app.database.mysql import get_db

router = APIRouter(prefix="/lecturers", tags=["lecturers"])

@router.post("/", response_model=LecturerOut)
def create_new_lecturer(lecturer: LecturerCreate, db: Session = Depends(get_db)):
    try: 
        return create_lecturer(db=db, lecture=lecturer)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@router.get("/", response_model=list[LecturerOut])
def read_lecturers(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return get_lecturers(db, skip=skip, limit=limit)

@router.get("/{lecturer_id}", response_model=LecturerOut)
def read_lecturer(lecturer_id: int, db: Session = Depends(get_db)):
    data = get_lecturer(db, lecturer_id=lecturer_id)
    if data is None:
        raise HTTPException(status_code=404, detail="Lecturer not found!")
    return data

@router.put("/{lectuerer_id}", response_model=LecturerOut)
def update_existing_lecturer(
    lecturer_id: int,
    lecture: LecturerUpdate,
    db: Session = Depends(get_db)
):
    try: 
        data = update_lecturer(db=db, lecturer_id=lecturer_id, lecturer=lecture)
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