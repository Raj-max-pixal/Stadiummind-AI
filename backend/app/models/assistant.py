from pydantic import BaseModel
from typing import Optional


class AssistantRequest(BaseModel):
    query: str
    context: Optional[dict] = None
    user_role: str = "fan"


class AssistantResponse(BaseModel):
    response: str
    reasoning: Optional[str] = None
    sources: Optional[list] = None
    confidence: float


class VoiceRequest(BaseModel):
    audio_data: str  # Base64 encoded
    language: str = "en"


class VoiceResponse(BaseModel):
    transcript: str
    response: str
    audio_response: Optional[str] = None  # Base64 encoded
