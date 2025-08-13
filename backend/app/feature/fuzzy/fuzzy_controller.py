# import re
# from Levenshtein import ratio
# from app.database.mongodb import get_fuzzy_dataset

# # preprocess
# def preprocess_text(text: str) -> str:
#     text = text.lower()
#     text = re.sub(r'[^a-z0-9\s]', '', text)
#     text = re.sub(r'\s+',' ',text)
#     return text.strip()

# def similarity_calculate(str1: str, str2: str) -> float:
#     return ratio(str1, str2) *100

# async def fuzzy_match_controller(judul_input: str, threshold: float = 79.0):
#     collection = get_fuzzy_dataset()

#     # cursor = collection.find().to_list()
#     # dataset = [doc async for doc in cursor]

#     # input_clean = preprocess_text(judul_input)
#     # print(input_clean)

#     dataset = await collection.find().to_list(length=None)
#     input_clean = preprocess_text(judul_input)

#     result = []
#     for item in dataset:
#         title_val = item.get("Title") or item.get("")
#         title_clean = preprocess_text(title_val)
#         similarity_score = similarity_calculate(input_clean, title_clean)

#         if similarity_score >= threshold:
#             result.append({
#                 "judul_dataset": title_val.strip(),
#                 "similarity": round(similarity_score, 2)
#             })
    
#     return {
#         "input" : judul_input,
#         "threshold": f"{threshold}%",
#         "matches": sorted(result, key=lambda x:x["similarity"], reverse=True)
#     }


import re
from Levenshtein import ratio
from app.database.mongodb import get_fuzzy_dataset

# --- Preprocess ---
def preprocess_text(text: str) -> str:
    text = text.lower()
    text = re.sub(r'[^a-z0-9\s]', '', text)
    text = re.sub(r'\s+', ' ', text)
    return text.strip()

def similarity_calculate(str1: str, str2: str) -> float:
    return ratio(str1, str2) * 100

# --- Controller ---
async def fuzzy_match_controller(judul_input: str, threshold: float = 79.0):
    collection = get_fuzzy_dataset()
    dataset = [doc async for doc in collection.find()]

    input_clean = preprocess_text(judul_input)

    result = []
    highest_score = 0  # untuk menyimpan similarity tertinggi

    for item in dataset:
        title_val = item.get("Title", "")
        title_clean = preprocess_text(title_val)
        similarity_score = similarity_calculate(input_clean, title_clean)

        # update highest similarity
        if similarity_score > highest_score:
            highest_score = similarity_score

        if similarity_score >= threshold:
            result.append({
                "judul_dataset": title_val.strip(),
                "similarity": round(similarity_score, 2)
            })

    return {
        "input": judul_input,
        "threshold": f"{threshold}%",
        "similarity_input": round(highest_score, 2),  # tambahkan ini
        "matches": sorted(result, key=lambda x: x["similarity"], reverse=True)
    }

