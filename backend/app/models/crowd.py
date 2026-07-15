from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime


class GateData(BaseModel):
    gate_id: str
    gate_name: str
    capacity: float
    current_count: float
    percentage: float
    status: str
    prediction: Optional[str] = None
    recommendation: Optional[str] = None


class CrowdModel(BaseModel):
    timestamp: str
    total_attendance: int
    gates: List[GateData]
    average_wait_time: float
    overall_status: str
    ai_insight: Optional[str] = None
    ai_recommendation: Optional[str] = None


class CrowdPredictionRequest(BaseModel):
    gate_id: str
    time_horizon_minutes: int = 15


class CrowdPredictionResponse(BaseModel):
    gate_id: str
    current_percentage: float
    predicted_percentage: float
    time_to_congestion_minutes: Optional[int] = None
    confidence: float
    reasoning: str
    recommendation: str
