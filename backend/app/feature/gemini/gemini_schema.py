from enum import Enum
from pydantic import BaseModel

class BidangITEnum(str, Enum):
    ai = "Artificial Intelligence"
    web = "Web Development"
    mobile = "Mobile Development"
    iot = "Internet of Things"
    cybersecurity = "Cybersecurity"
    data = "Data Science"
    ml = "Machine Learning"
    blockchain = "Blockchain"

class PromptRequest(BaseModel):
    bidang: BidangITEnum

class JudulResponse(BaseModel):
    judul: str
    deskripsi: str
    teknologi: list[str]

# Revisi: Khusus untuk request generate judul
class GenerateJudulOnlyRequest(BaseModel):
    bidang: BidangITEnum

# Opsional jika nanti ingin menyimpan hasil juga
class GenerateJudulWithResultRequest(BaseModel):
    bidang: BidangITEnum
    generated: list[JudulResponse]
