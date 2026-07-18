from fastapi import APIRouter, HTTPException
from app.models.user import UserCreate, UserLogin, UserResponse
from typing import Dict, Any

router = APIRouter()


@router.post("/register", response_model=Dict[str, Any])
async def register(user: UserCreate):
    """Return Firebase client-auth registration guidance."""
    return {
        "message": "Registration is handled by Firebase Auth in the web client.",
        "user": {
            "email": user.email,
            "name": user.name,
            "role": user.role
        }
    }


@router.post("/login", response_model=Dict[str, Any])
async def login(user: UserLogin):
    """Return Firebase client-auth login guidance."""
    return {
        "message": "Login is handled by Firebase Auth in the web client.",
        "email": user.email,
        "token_source": "firebase_id_token"
    }


@router.post("/logout")
async def logout():
    """Logout user"""
    return {"message": "Logout successful"}


@router.get("/user", response_model=Dict[str, Any])
async def get_user():
    """Return current auth architecture."""
    return {
        "message": "User identity is read from Firebase Auth and Firestore by the web client.",
        "user_source": "firebase_auth_firestore"
    }
