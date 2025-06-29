from fastapi import APIRouter, Depends, HTTPException
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from app.database.models.user_model import User
from app.database.models.student_model import Student
from app.database.models.student_submission_model import StudentSubmission
from app.database.models.submission_status_model import SubmissionStatus
from app.database.schemas.student_submission_schema import SubmissionCreate, SubmissionUpdate, SubmissionOut
from app.database.CRUD.student_submission_crud import (
    get_submissions,
    get_submission,
    get_submission_by_student,
    create_submission,
    update_submission,
    delete_submission
)
from app.utils.dependencies import require_role,get_current_student
from app.utils.enum import SubmissionStatusEnum
from app.database.mysql import get_db

router = APIRouter(prefix="/submissions", tags=["Student Submissions"])

# ====================== Submission data of himself ===================== #

#Get my submission data
@router.get("/me", response_model=SubmissionOut)
def get_my_submission(
    user: User = Depends(require_role(["MAHASISWA"])),
    db: Session = Depends(get_db),
):
    if not user.student:
        raise HTTPException(status_code=400, detail="Student data not found.")

    submission = (
        db.query(StudentSubmission)
        .filter(StudentSubmission.student_id == user.student.student_id)
        .order_by(StudentSubmission.created_at.desc())
        .first()
    )

    if not submission:
        raise HTTPException(status_code=404, detail="Submission not found")

    return submission

@router.put("/me", response_model=SubmissionOut)
def update_my_active_submission(
    submission_data: SubmissionUpdate,
    user = Depends(require_role(["MAHASISWA"])),
    db: Session = Depends(get_db),
):
    if not user.student:
        raise HTTPException(status_code=400, detail="Student data not found")

    submission = (
        db.query(StudentSubmission)
        .filter(StudentSubmission.student_id == user.student.student_id)
        .filter(StudentSubmission.title_status.in_([SubmissionStatusEnum.REJECTED, SubmissionStatusEnum.REVISED]))
        .first()
    )

    if not submission:
        raise HTTPException(status_code=404, detail="You are not allowed to edit, please wait until review finished!")

    update_data = submission_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(submission, field, value)

    # Update status submission utama jadi WAITING
    submission.title_status = SubmissionStatusEnum.WAITING

    # Tambah entri status baru di tabel SubmissionStatus
    new_status_entry = SubmissionStatus(
        submission_id=submission.submission_id,
        student_id=submission.student_id,
        lecturer_id=None,  # Belum ada lecturer karena ini dari mahasiswa
        status=SubmissionStatusEnum.WAITING,
        created_at=datetime.now(timezone.utc),
    )
    db.add(new_status_entry)

    db.commit()
    db.refresh(submission)
    return submission

# ========================== ADMIN =========================== #

# GET: Semua submission - untuk ADMIN dan DOSEN
@router.get("/", response_model=list[SubmissionOut])
def read_submissions(
    skip: int = 0,
    limit: int = 100,
    user: User = Depends(require_role(["ADMIN", "DOSEN"])),
    db: Session = Depends(get_db),
):
    return get_submissions(db, skip, limit)


# GET: Submission by ID - untuk ADMIN, DOSEN, MAHASISWA (tapi mahasiswa hanya boleh miliknya sendiri)
@router.get("/{submission_id}", response_model=SubmissionOut)
def read_submission(
    submission_id: int,
    user: User = Depends(require_role(["ADMIN", "DOSEN", "MAHASISWA"])),
    db: Session = Depends(get_db),
):
    submission = get_submission(db, submission_id)
    if not submission:
        raise HTTPException(status_code=404, detail="Submission not found")

    # Mahasiswa hanya boleh lihat submission miliknya
    if user.role.value == "MAHASISWA":
        if not user.student or submission.student_id != user.student.student_id:
            raise HTTPException(status_code=403, detail="Not authorized to access this submission")

    return submission


# GET: Semua submission milik student tertentu - hanya ADMIN dan DOSEN
@router.get("/student/{student_id}", response_model=list[SubmissionOut])
def read_submissions_by_student(
    student_id: int,
    user: User = Depends(require_role(["ADMIN", "DOSEN"])),
    db: Session = Depends(get_db),
):
    return get_submission_by_student(db, student_id)


# POST: Buat submission - hanya ADMIN dan MAHASISWA
@router.post("/", response_model=SubmissionOut)
def create_new_submission(
    submission: SubmissionCreate,
    user: User = Depends(require_role(["ADMIN", "MAHASISWA"])),
    db: Session = Depends(get_db),
):
    if user.role.value == "MAHASISWA":
        if not user.student:
            raise HTTPException(status_code=403, detail="Student data not found.")
        student_id = user.student.student_id
    else:
        # Admin harus mengirimkan student_id (bisa diimplementasikan di schema atau parameter tambahan)
        raise HTTPException(status_code=400, detail="Admin cannot create submission without student_id.")

    return create_submission(db, submission, student_id)


# PUT: Update submission - ADMIN dan MAHASISWA (hanya miliknya)
# @router.put("/{submission_id}", response_model=SubmissionOut)
# def update_existing_submission(
#     submission_id: int,
#     submission_data: SubmissionUpdate,
#     user: User = Depends(require_role(["ADMIN", "MAHASISWA"])),
#     db: Session = Depends(get_db),
# ):
#     submission = get_submission(db, submission_id)
#     if not submission:
#         raise HTTPException(status_code=404, detail="Submission not found")

#     if user.role.value == "MAHASISWA":
#         if not user.student or submission.student_id != user.student.student_id:
#             raise HTTPException(status_code=403, detail="You can only update your own submission")

#     return update_submission(db, submission_id, submission_data)

@router.put("/{submission_id}", response_model=SubmissionOut)
def update_existing_submission(
    submission_id: int,
    submission_data: SubmissionUpdate,
    user: User = Depends(require_role(["ADMIN", "MAHASISWA"])),
    db: Session = Depends(get_db),
):
    submission = get_submission(db, submission_id)
    if not submission:
        raise HTTPException(status_code=404, detail="Submission not found")

    if user.role.value == "MAHASISWA":
        if not user.student or submission.student_id != user.student.student_id:
            raise HTTPException(status_code=403, detail="You can only update your own submission")

        # Cek status, hanya boleh update jika status REJECTED atau REVISED
        allowed_statuses = ["REJECTED", "REVISED"]  # sesuaikan dengan enum atau string status yang kamu punya
        if submission.title_status.name not in allowed_statuses:
            raise HTTPException(
                status_code=403,
                detail=f"Submission can only be updated if status is {allowed_statuses}"
            )

    return update_submission(db, submission_id, submission_data)



# DELETE: Hapus submission - hanya ADMIN
@router.delete("/{submission_id}")
def remove_submission(
    submission_id: int,
    user: User = Depends(require_role(["ADMIN"])),
    db: Session = Depends(get_db),
):
    submission = get_submission(db, submission_id)
    if not submission:
        raise HTTPException(status_code=404, detail="Submission not found")

    return delete_submission(db, submission_id)
