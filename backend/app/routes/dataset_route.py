from fastapi import APIRouter, Depends
from app.database.mongodb import get_dataset

router = APIRouter()

def serialize_item(item):
    return {
        "id": str(item["_id"]),
        "Title": item["Title"],
        "Category": item["Category"],
        "Complexity": item["Complexity"],
        "Resources": item["Resources"],
        "Time Estimation": item["Time Estimation"]
    }

@router.get("/dataset-items")
async def get_items(collection=Depends(get_dataset)):
    raw_items = await collection.find().to_list(100)
    return [serialize_item(item) for item in raw_items]
