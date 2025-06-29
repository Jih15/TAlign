from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    mysql_database_url: str
    secret_key: str
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30
    environment: str = "development"
    debug: bool = True

    model_config = {
        "env_file": ".env",
        "case_sensitive": False,
    }

settings = Settings()
