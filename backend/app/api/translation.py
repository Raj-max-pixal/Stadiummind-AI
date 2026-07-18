from fastapi import APIRouter, HTTPException
from app.models.translation import TranslationRequest, TranslationResponse, VoiceTranslationRequest, VoiceTranslationResponse
from app.services.gemini_service import gemini_service

router = APIRouter()


@router.post("/text", response_model=TranslationResponse)
async def translate_text(request: TranslationRequest):
    """Translate text between languages"""
    try:
        translated = await gemini_service.translate_text(
            text=request.text,
            target_language=request.target_language
        )
        
        return TranslationResponse(
            original_text=request.text,
            translated_text=translated,
            source_language=request.source_language,
            target_language=request.target_language,
            confidence=0.9
        )
    except Exception as e:
        raise HTTPException(
            status_code=502,
            detail=f"Translation service error: {str(e)}",
        )


@router.post("/voice", response_model=VoiceTranslationResponse)
async def translate_voice(request: VoiceTranslationRequest):
    """Translate voice input"""
    # TODO: Implement speech-to-text and text-to-speech
    return VoiceTranslationResponse(
        transcript="Voice transcript (STT integration pending)",
        translated_text="Translation (AI integration pending)",
        audio_response=None,
        source_language=request.source_language,
        target_language=request.target_language
    )
