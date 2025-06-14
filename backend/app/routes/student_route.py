from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.CRUD.student_crud import (
    get_student, get_students, create_student, 
    update_student, delete_student
)
from app.database.schemas.student_schema import StudentCreate, StudentUpdate, StudentOut
from app.database.mysql import get_db

router = APIRouter(prefix="/students", tags=["students"])

@router.post("/", response_model=StudentOut)
def create_new_student(student: StudentCreate, db: Session = Depends(get_db)):
    try :
        return create_student(db=db, student=student)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@router.get("/", response_model=list[StudentOut])
def read_students(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return get_students(db, skip=skip, limit=limit)

@router.get("/{student_id}", response_model=StudentOut)
def read_student(student_id: int, db: Session = Depends(get_db)):
    data = get_student(db, student_id=student_id)
    if data is None:
        raise HTTPException(status_code=404, detail="Student not found!")
    return data

@router.put("/{student_id}", response_model=StudentOut)
def update_existing_student(
    student_id: int,
    student: StudentUpdate,
    db: Session = Depends(get_db)
):
    try: 
        data = update_student(db=db, student_id=student_id, student=student)
        if data is None:
            raise HTTPException(status_code=404, detail="Student not found!")
        return data
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@router.delete("/{student_id}")
def delete_existing_student(student_id: int, db: Session = Depends(get_db)):
    if not delete_student(db=db, student_id=student_id):
        raise HTTPException(status_code=404, detail="Student not found!")
    return {"message" : "Student deleted successfully!"}