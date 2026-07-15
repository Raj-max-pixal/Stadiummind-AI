from fastapi import APIRouter
from app.models.assistant import AssistantRequest, AssistantResponse, VoiceRequest, VoiceResponse
from app.services.gemini_service import gemini_service

router = APIRouter()


@router.post("/ask", response_model=AssistantResponse)
async def ask_assistant(request: AssistantRequest):
    """AI Assistant endpoint for natural language queries"""
    try:
        # Build context-aware prompt
        context_str = f"User Role: {request.user_role}\n"
        if request.context:
            context_str += f"Context: {request.context}\n"
        
        prompt = f"""
You are an AI Stadium Assistant for FIFA World Cup 2026.

{context_str}
User Question: {request.query}

Provide a helpful, accurate response. If you don't know the answer, say so politely.
Keep responses concise and actionable.
"""
        
        response = await gemini_service.generate_response(prompt)
        
        return AssistantResponse(
            response=response,
            reasoning=None,
            sources=None,
            confidence=0.85
        )
    except Exception as e:
        raise Exception(f"Assistant error: {str(e)}")


@router.post("/voice", response_model=VoiceResponse)
async def voice_assistant(request: VoiceRequest):
    """Voice input endpoint for AI assistant"""
    # TODO: Implement speech-to-text processing
    return VoiceResponse(
        transcript="Voice transcript (STT integration pending)",
        response="Voice response (TTS integration pending)",
        audio_response=None
    )
