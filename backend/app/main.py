from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from app.config import settings
from app.api import auth, assistant, crowd, emergency, translation, admin
from app.websocket import crowd_ws, emergency_ws
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info(f"Starting {settings.app_name} v{settings.app_version}")
    yield
    logger.info(f"Shutting down {settings.app_name}")


app = FastAPI(
    title=settings.app_name,
    version=settings.app_version,
    description="AI-powered Stadium Operations Platform for FIFA World Cup 2026",
    lifespan=lifespan
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure properly for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(assistant.router, prefix="/api/assistant", tags=["AI Assistant"])
app.include_router(crowd.router, prefix="/api/crowd", tags=["Crowd Intelligence"])
app.include_router(emergency.router, prefix="/api/emergency", tags=["Emergency"])
app.include_router(translation.router, prefix="/api/translate", tags=["Translation"])
app.include_router(admin.router, prefix="/api/admin", tags=["Admin"])

# WebSocket routes
app.add_websocket_route("/ws/crowd", crowd_ws.websocket_endpoint)
app.add_websocket_route("/ws/emergency", emergency_ws.websocket_endpoint)


@app.get("/")
async def root():
    return {
        "name": settings.app_name,
        "version": settings.app_version,
        "status": "running",
        "message": "AI-powered Stadium Operations Platform"
    }


@app.get("/health")
async def health_check():
    return {"status": "healthy"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=settings.debug
    )
