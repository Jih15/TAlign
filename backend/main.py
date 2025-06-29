from fastapi import FastAPI
from app.database.session import Base
from app.database.mysql import engine
from app.routes.auth_route import router as AuthRoute
from app.routes.user_route import router as UserRoute
from app.routes.student_route import router as StudentRoute
from app.routes.lecturer_route import router as LecturerRoute
from app.routes.student_submission_route import router as StudentSubmissionRoute
from app.routes.submission_status_route import router as SubmissionStatusRoute
from app.routes.feedback_route import router as FeedbackRoute

app = FastAPI()
# Base.metadata.drop_all(bind=engine)
Base.metadata.create_all(bind=engine)

@app.get("/")
def read_root():
    return {"message" : "Backend is running!"}

app.include_router(AuthRoute)
app.include_router(UserRoute)
app.include_router(StudentRoute)
app.include_router(LecturerRoute)
app.include_router(StudentSubmissionRoute)
app.include_router(SubmissionStatusRoute)
app.include_router(FeedbackRoute)
