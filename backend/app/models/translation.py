from typing import Optional
from pydantic import BaseModel


class TranslationRequest(BaseModel):
    text: str
    source_language: str
    target_language: str


class TranslationResponse(BaseModel):
    original_text: str
    translated_text: str
    source_language: str
    target_language: str
    confidence: float


class VoiceTranslationRequest(BaseModel):
    audio_data: str  # Base64 encoded
    source_language: str
    target_language: str


class VoiceTranslationResponse(BaseModel):
    transcript: str
    translated_text: str
    audio_response: Optional[str] = None  # Base64 encoded
    source_language: str
    target_language: str
