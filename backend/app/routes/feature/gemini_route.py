from fastapi import APIRouter
from app.feature.gemini.gemini_schema import GenerateJudulOnlyRequest
from app.feature.gemini.gemini_controller import handle_generate_judul

router = APIRouter(prefix="/generate-judul", tags=["Gemini"])

@router.post("/")
async def generate_judul(request: GenerateJudulOnlyRequest):
    return handle_generate_judul(request.bidang)
