from pydantic import BaseModel
from typing import Optional
from datetime import datetime


class EmergencyIncident(BaseModel):
    id: str
    type: str
    priority: str
    location: str
    description: str
    reported_at: datetime
    ai_summary: Optional[str] = None
    ai_recommendation: Optional[str] = None
    assigned_volunteer_id: Optional[str] = None
    assigned_volunteer_name: Optional[str] = None
    medical_team_id: Optional[str] = None
    fastest_route: Optional[str] = None
    status: str = "active"
    resolved_at: Optional[datetime] = None


class EmergencyReport(BaseModel):
    type: str
    location: str
    description: str
    reporter_id: str


class Volunteer(BaseModel):
    id: str
    name: str
    current_location: str
    status: str
    assigned_incident_id: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None


class EmergencyResponse(BaseModel):
    incident_id: str
    responder_id: str
    action: str
    timestamp: datetime
