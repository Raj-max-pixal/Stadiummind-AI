from fastapi import APIRouter
from app.models.emergency import EmergencyReport, EmergencyIncident, Volunteer, EmergencyResponse
from app.services.simulation_service import simulation_service
from app.services.gemini_service import gemini_service
from typing import List

router = APIRouter()


@router.post("/report", response_model=EmergencyIncident)
async def report_emergency(report: EmergencyReport):
    """Report a new emergency"""
    # Generate emergency with AI analysis
    emergency = simulation_service.generate_emergency()
    emergency["type"] = report.type
    emergency["location"] = report.location
    emergency["description"] = report.description
    emergency["reporter_id"] = report.reporter_id
    
    # Generate AI analysis
    try:
        analysis = await gemini_service.generate_emergency_analysis(
            incident_type=report.type,
            location=report.location,
            description=report.description
        )
        
        emergency["ai_summary"] = f"Priority: {analysis['priority']}. {analysis['operational_impact']}"
        emergency["ai_recommendation"] = f"Actions: {', '.join(analysis['response_actions'])}"
        
        # Assign volunteer
        if analysis["priority"] in ["HIGH", "CRITICAL"]:
            emergency = simulation_service.assign_volunteer(emergency)
            
            # Assign medical team if needed
            if report.type == "Medical Emergency":
                medical_team = simulation_service.get_nearest_medical_team(report.location)
                if medical_team:
                    emergency["medical_team_id"] = medical_team["id"]
            
            # Calculate route
            if emergency["assigned_volunteer_name"]:
                emergency["fastest_route"] = simulation_service.calculate_route(
                    emergency["assigned_volunteer_name"],
                    report.location
                )
        
    except Exception as e:
        emergency["ai_summary"] = "AI analysis unavailable"
        emergency["ai_recommendation"] = "Manual response required"
    
    return EmergencyIncident(**emergency)


@router.get("/active", response_model=List[EmergencyIncident])
async def get_active_emergencies():
    """Get all active emergencies"""
    return [EmergencyIncident(**e) for e in simulation_service.active_emergencies]


@router.post("/respond", response_model=EmergencyResponse)
async def respond_to_emergency(response: EmergencyResponse):
    """Respond to an emergency"""
    # Find and update emergency
    for emergency in simulation_service.active_emergencies:
        if emergency["id"] == response.incident_id:
            if response.action == "resolve":
                emergency["status"] = "resolved"
                emergency["resolved_at"] = response.timestamp.isoformat()
            elif response.action == "assign":
                emergency["assigned_volunteer_id"] = response.responder_id
            break
    
    return response


@router.get("/volunteers", response_model=List[Volunteer])
async def get_volunteers():
    """Get all volunteers"""
    return [Volunteer(**v) for v in simulation_service.volunteers]
