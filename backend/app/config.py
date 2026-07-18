from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    # Firebase
    firebase_api_key: str = ""
    firebase_auth_domain: str = ""
    firebase_project_id: str = ""
    firebase_storage_bucket: str = ""
    firebase_messaging_sender_id: str = ""
    firebase_app_id: str = ""
    
    # AI
    gemini_api_key: str = ""
    gemini_model: str = "gemini-1.5-flash"
    gemini_pro_model: str = "gemini-1.5-pro"
    
    # Maps
    google_maps_api_key: str = ""
    
    # URLs
    backend_url: str = "http://localhost:8000"
    frontend_url: str = "http://localhost:3000"
    
    # App
    app_name: str = "StadiumMind AI"
    app_version: str = "1.0.0"
    debug: bool = True
    
    class Config:
        env_file = ".env"
        case_sensitive = False


settings = Settings()
