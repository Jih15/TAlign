from fastapi import APIRouter, Depends
from app.database.mongodb import get_fuzzy_dataset, get_training_tkom

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

def serialize_item_title(item):
    return {
        "id": str(item["_id"]),
        "Title": item["Title"]
    }

@router.get("/fuzzy-dataset")
async def get_items(collection=Depends(get_fuzzy_dataset)):
    raw_items = await collection.find().to_list()
    return [serialize_item_title(item) for item in raw_items]

@router.get("/data-train-tkom")
async def get_items(collection=Depends(get_training_tkom)):
    raw_items = await collection.find().to_list(100)
    return [serialize_item(item) for item in raw_items]
