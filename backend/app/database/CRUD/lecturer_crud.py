from sqlalchemy.orm import Session
from app.database.models.lecturer_model import Lecturer
from app.database.models.user_model import User
from app.database.schemas.lecturer_schema import LecturerCreate, LecturerUpdate

def get_lecturer(db: Session, lecturer_id: int):
    return db.query(Lecturer).filter(Lecturer.lecturer_id == lecturer_id).first()

def get_lecturer_by_nip(db: Session, nip: int):
    return db.query(Lecturer).filter(Lecturer.nip == nip).first()

def get_lecturer_by_user_id(db: Session, user_id: int):
    return db.query(Lecturer).filter(Lecturer.user_id == user_id).first()

def get_lecturers(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Lecturer).offset(skip).limit(limit).all()

def create_lecturer(db: Session, lecture: LecturerCreate):
    db_user = db.query(User).filter(User.user_id == lecture.user_id).first()

    if not db_user:
        raise ValueError("User ID tidak valid!")
    
    if get_lecturer_by_nip(db, lecture.nip):
        raise ValueError("NIP sudah terdaftar!")
    
    data = Lecturer(
        user_id = lecture.user_id,
        nip = lecture.nip, 
        full_name = lecture.full_name,
        field = lecture.field
    )

    db.add(data)
    db.commit()
    db.refresh(data)
    return data

def update_lecturer(db: Session, lecturer_id: int, lecture: LecturerUpdate):
    data = get_lecturer(db, lecturer_id)
    if not data:
        return None
    
    update_data = lecture.model_dump(exclude_unset=True)

    if 'nip' in update_data and update_data['nip'] != data.nip:
        if get_lecturer_by_nip(db, update_data['nip']):
            raise ValueError("NIP sudah digunakan oleh lecture lain!")
        
    for field, value in update_data.items():
        setattr(data, field, value)

    db.commit()
    db.refresh(data)
    return data

def delete_lecture(db: Session, lecturer_id: int):
    data = get_lecturer(db, lecturer_id)
    if not data:
        return False
    
    db.delete(data)
    db.commit()
    return True