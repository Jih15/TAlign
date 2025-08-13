from fastapi import FastAPI, Depends,HTTPException
from sqlalchemy.exc import SQLAlchemyError
from app.database.session import Base
from app.database.mysql import engine
from app.routes.table.auth_route import router as AuthRoute
from app.routes.table.user_route import router as UserRoute
from app.routes.table.student_route import router as StudentRoute
from app.routes.table.lecturer_route import router as LecturerRoute
from app.routes.table.student_submission_route import router as StudentSubmissionRoute
from app.routes.table.submission_status_route import router as SubmissionStatusRoute
from app.routes.table.feedback_route import router as FeedbackRoute
from app.routes.feature.gemini_route import router as GeminiRoute
from app.routes.feature.dataset_route import router as DataRoute
from app.routes.table.predict_difficulty import router as PredictRoute
from app.routes.feature.fuzzy_route import router as FuzzyRoute
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import os

app = FastAPI()
# Base.metadata.drop_all(bind=engine)
try:
    Base.metadata.create_all(bind=engine)
    print("✅ Database connected and tables created.")
except SQLAlchemyError as e:
    print("❌ Database connection failed:", e)

# Base.metadata.create_all(bind=engine)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],      
    allow_headers=["*"],      
)

app.mount(
    "/static",
    StaticFiles(directory=os.path.join("app", "static")),
    name="static"
)

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
app.include_router(GeminiRoute)
app.include_router(DataRoute)
app.include_router(PredictRoute)
app.include_router(FuzzyRoute)