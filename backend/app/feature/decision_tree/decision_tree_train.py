import pandas as pd
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report
import joblib
import asyncio
import os

from app.database.mongodb import get_dataset

# Fetch dataset
async def fetch_dataset():
    collection = get_dataset()
    raw_data = await collection.find().to_list(length=1000)
    return raw_data

# Clean and convert to dataframe
def clean_and_prepare_dataframe(items):
    df = pd.DataFrame(items)
    df = df.dropna()
    df = df[df['Category'].isin(["Mudah", "Sedang", "Sulit"])]
    return df[["Complexity", "Resources", "Time Estimation", "Category"]]

# Train model
def train_decision_tree_model(df: pd.DataFrame):
    X = df[["Complexity", "Resources", "Time Estimation"]]
    y = df["Category"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.4, stratify=y, random_state=42
    )

    model = DecisionTreeClassifier(random_state=42, class_weight="balanced")
    model.fit(X_train, y_train)

    y_pred = model.predict(X_test)
    print("\nClassification Report:\n")
    print(classification_report(y_test, y_pred, zero_division=0))

    scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
    print("\nCross-validation scores:", scores)
    print("Average accuracy:", scores.mean())

    # Save model
    model_dir = os.path.join("app", "models")
    os.makedirs(model_dir, exist_ok=True)
    model_path = os.path.join(model_dir, "decision_tree_tingkat_kesulitan.pkl")
    joblib.dump(model, model_path)
    print(f"\nModel trained and saved to {model_path}")

if __name__ == "__main__":
    loop = asyncio.get_event_loop()
    items = loop.run_until_complete(fetch_dataset())
    df = clean_and_prepare_dataframe(items)
    train_decision_tree_model(df)
