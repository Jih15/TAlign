from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.schemas.submission_status_schema import StatusOut, StatusUpdate
from app.database.CRUD.submission_status_crud import (
    get_status,
    get_all_status,
    get_submission_statuses,
    insert_new_status
)
from app.database.models.user_model import User
from app.database.models.submission_status_model import SubmissionStatus
from app.database.models.student_submission_model import StudentSubmission
from app.utils.dependencies import require_role
from app.database.mysql import get_db
from app.utils.enum import SubmissionStatusEnum
from datetime import datetime, timezone

router = APIRouter(
    prefix="/submission-status",
    tags=["Submission Status"]
)

@router.get("/", response_model=list[StatusOut])
def read_all_status(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db)
):
    return get_all_status(db, skip, limit)

@router.get("/{status_id}", response_model=StatusOut)
def read_status(status_id: int, db: Session = Depends(get_db)):
    status = get_status(db, status_id)
    if not status:
        raise HTTPException(status_code=404, detail="Status not found")
    return status

@router.get("/submission/{submission_id}", response_model=list[StatusOut])
def read_statuses_for_submission(submission_id: int, db: Session = Depends(get_db)):
    return get_submission_statuses(db, submission_id)

# @router.post("/{submission_id}/review", response_model=StatusOut)
# def review_submission_status(
#     submission_id: int,
#     new_status: SubmissionStatusEnum,
#     user: User = Depends(require_role(["DOSEN", "ADMIN"])),
#     db: Session = Depends(get_db)
# ):
#     if not user.lecturer:
#         raise HTTPException(status_code=403, detail="You are not a lecturer!")
    
#     lecturer_id = user.lecturer.lecturer_id

#     try:
#         return insert_new_status(db, submission_id, lecturer_id, new_status)
#     except ValueError as e:
#         raise HTTPException(status_code=400, detail=str(e))

@router.put("/{status_id}/review", response_model=StatusOut)
def update_submission_status(
    status_id: int,
    status_update: StatusUpdate,
    user = Depends(require_role(["DOSEN", "ADMIN"])),
    db: Session = Depends(get_db),
):
    if not user.lecturer:
        raise HTTPException(status_code=403, detail="You are not a lecturer")

    status = db.query(SubmissionStatus).filter(SubmissionStatus.status_id == status_id).first()
    if not status:
        raise HTTPException(status_code=404, detail="Status not found")

    if status_update.status is not None:
        status.status = status_update.status
        status.submitted_at = datetime.now(timezone.utc)
        # **Set lecturer_id dari user yang login**
        status.lecturer_id = user.lecturer.lecturer_id

    submission = db.query(StudentSubmission).filter(StudentSubmission.submission_id == status.submission_id).first()
    if submission:
        submission.title_status = status.status

    db.commit()
    db.refresh(status)
    return status
