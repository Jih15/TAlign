from fastapi import APIRouter
from pydantic import BaseModel
import joblib
import numpy as np
import os

router = APIRouter(
    prefix="/predict",
    tags=["Prediction"]
)

# Load model saat server start
model_path = os.path.join("app", "models", "decision_tree_tingkat_kesulitan.pkl")
model = joblib.load(model_path)

class PredictInput(BaseModel):
    complexity: int
    resources: int
    time_estimation: int

@router.post("/difficulty")
def predict_difficulty(data: PredictInput):
    features = np.array([[data.complexity, data.resources, data.time_estimation]])
    prediction = model.predict(features)[0]
    return {"prediction": prediction}
