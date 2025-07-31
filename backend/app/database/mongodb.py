from motor.motor_asyncio import AsyncIOMotorClient
from app.core.config.config import settings

client = AsyncIOMotorClient(settings.mongo_database_url)
mongo_db = client["TAlign"]
my_collection = mongo_db.get_collection("dataset-judul")

def get_dataset():
    return my_collection