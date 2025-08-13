from motor.motor_asyncio import AsyncIOMotorClient
from app.core.config.config import settings

client = AsyncIOMotorClient(settings.mongo_database_url)
mongo_db = client["TAlign"]

alltitledata_collection = mongo_db.get_collection("completed-dataset-allprodi")

decisiontree_tkom_collection = mongo_db.get_collection("dataset-judul-tkom")

def get_fuzzy_dataset():
    return alltitledata_collection

def get_training_tkom():
    return decisiontree_tkom_collection
