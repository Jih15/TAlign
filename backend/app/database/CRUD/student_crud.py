from sqlalchemy.orm import Session
from app.database.models.student_model import Student
from app.database.models.user_model import User
from app.database.schemas.student_schema import StudentCreate, StudentUpdate

def get_student(db: Session, student_id: int):
    return db.query(Student).filter(Student.student_id == student_id).first()

def get_student_by_nim(db: Session, nim: int):
    return db.query(Student).filter(Student.nim == nim).first()

def get_student_by_user_id(db: Session, user_id: int):
    return db.query(Student).filter(Student.user_id == user_id).first()

def get_students(db: Session, skip : int = 0, limit: int = 100):
    return db.query(Student).offset(skip).limit(limit).all()

def create_student(db: Session, student: StudentCreate):
    #user_id cek
    db_user = db.query(User).filter(User.user_id == student.user_id).first()

    if not db_user:
        raise ValueError("User ID tidak valid!")
    
    #nim cek
    if get_student_by_nim(db, student.nim):
        raise ValueError("NIM sudah terdaftar!")
    
    data = Student(
        user_id = student.user_id,
        nim = student.nim,
        full_name = student.full_name,
        majors = student.majors,
        study_program = student.study_program
    )

    db.add(data)
    db.commit()
    db.refresh(data)
    return data

def update_student(db: Session, student_id: int, student: StudentUpdate):
    data = get_student(db, student_id)
    if not data:
        return None
    
    update_data = student.model_dump(exclude_unset=True)

    #Cek nim
    if 'nim' in update_data and update_data['nim'] != data.nim:
        if get_student_by_nim(db, update_data['nim']):
            raise ValueError("NIM sudah digunakan oleh student lain!")
    
    for field, value in update_data.items():
        setattr(data, field, value)

    db.commit()
    db.refresh(data)
    return data

def delete_student(db: Session, student_id: int):
    data = get_student(db, student_id)
    if not data:
        return False
    
    db.delete(data)
    db.commit()
    return True
