# app/feature/gemini/gemini_service.py
import google.generativeai as genai
import json
from app.core.config.config import settings
from app.feature.gemini.gemini_schema import BidangITEnum

genai.configure(api_key=settings.gemini_api_key)
model = genai.GenerativeModel("gemini-2.5-flash")

def generate_prompt(bidang: BidangITEnum) -> str:
    return (
        f"Berikan 25 ide judul tugas akhir dalam bidang {bidang.value} "
        "dalam format JSON array tanpa markdown, tanpa penjelasan. "
        "Format: [\"judul 1\", \"judul 2\", \"judul 3\"]"
    )



def generate_judul_from_gemini(bidang: BidangITEnum):
    prompt = generate_prompt(bidang)
    # print("DEBUG PROMPT:", prompt)
    
    response = model.generate_content(prompt)
    text_response = response.text.strip()
    
    # print("DEBUG RESPONSE:", text_response)

    try:
        return json.loads(text_response)
    except json.JSONDecodeError as e:
        raise ValueError(f"Gagal mem-parsing JSON dari Gemini: {e}")
