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
    LECTURER_ADVICE = "LECTURER ADVICE"

class StatusEnum(str, Enum):
    PROCESSED = "PROCESSED"
    SUBMITTED = "SUBMITTED"
    APPROVED = "APPROVED"
    REJECTED = "REJECTED"

class SubmissionStatusEnum(str, Enum):
    WAITING = "WAITING"
    APPROVED = "APPROVED"
    REJECTED = "REJECTED"