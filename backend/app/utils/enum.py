from enum import Enum

class UserRoleEnum(str, Enum):
    ADMIN = "ADMIN"
    DOSEN = "DOSEN"
    MAHASISWA = "MAHASISWA"

class DifficultyEnum(str, Enum):
    EASY = "EASY"
    MEDIUM = "MEDIUM"
    HARD = "HARD"

class IdeaSourceEnum(str, Enum):
    GENERATED = "GENERATED"
    MANUAL = "MANUAL"
    LECTURER_ADVICE = "LECTURER_ADVICE"

# Submission Status
class SubmissionStatusEnum(str, Enum):
    WAITING = "WAITING_REVIEW"      
    APPROVED = "APPROVED"
    REJECTED = "REJECTED"
    REVISED = "REVISED"      


# Student Submission
# class TitleStatusEnum(str, Enum):
#     DRAFT = "DRAFT"
#     WAITING_REVIEW = "WAITING_REVIEW"
#     APPROVED = "APPROVED"
#     REJECTED = "REJECTED"