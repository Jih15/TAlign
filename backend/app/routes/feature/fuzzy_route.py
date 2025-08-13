# from fastapi import APIRouter, Query
# from app.feature.fuzzy.fuzzy_controller import fuzzy_match_controller

# router = APIRouter(prefix="/fuzzy", tags=["fuzzy"])

# @router.get("/similarity-check")
# async def fuzzy_match(judul: str = Query(..., description="Judul yang ingin dicek"),
#                       threshold: float = Query(70.0, description="Batas kemiripan minimal")):
#     return await fuzzy_match_controller(judul, threshold)


from fastapi import APIRouter
from pydantic import BaseModel
from app.feature.fuzzy.fuzzy_controller import fuzzy_match_controller

router = APIRouter(prefix="/fuzzy", tags=["fuzzy"])

class FuzzyRequest(BaseModel):
    judul: str
    threshold: float = 70.0

@router.post("/similarity-check")
async def fuzzy_match(request: FuzzyRequest):
    return await fuzzy_match_controller(request.judul, request.threshold)
