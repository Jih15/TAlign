# app/feature/gemini/gemini_controller.py
from fastapi import HTTPException
from app.feature.gemini.gemini_schema import BidangITEnum
from app.feature.gemini.gemini_service import generate_judul_from_gemini

def handle_generate_judul(bidang: BidangITEnum):
    try:
        result = generate_judul_from_gemini(bidang)
        return {"data": result}
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
