from fastapi import APIRouter
from app.services.simulation_service import simulation_service
from app.services.gemini_service import gemini_service
from typing import Dict, Any

router = APIRouter()


@router.get("/analytics")
async def get_analytics():
    """Get stadium analytics"""
    crowd_data = simulation_service.generate_crowd_data()
    
    analytics = {
        "attendance": {
            "current": crowd_data["total_attendance"],
            "capacity": 80000,
            "percentage": round(crowd_data["total_attendance"] / 80000 * 100, 1)
        },
        "emergencies": {
            "active": len(simulation_service.active_emergencies),
            "resolved_today": 5,
            "avg_response_time": "2.3 minutes"
        },
        "volunteers": {
            "total": len(simulation_service.volunteers),
            "active": len([v for v in simulation_service.volunteers if v["status"] == "active"]),
            "on_break": len([v for v in simulation_service.volunteers if v["status"] == "break"])
        },
        "gates": crowd_data["gates"],
        "overall_status": crowd_data["overall_status"]
    }
    
    return analytics


@router.get("/users")
async def get_users():
    """Get all users"""
    # TODO: Implement Firebase user retrieval
    return {
        "message": "Users endpoint - Firebase integration pending",
        "users": []
    }


@router.post("/announce")
async def make_announcement(announcement: Dict[str, Any]):
    """Make stadium announcement"""
    return {
        "message": "Announcement sent successfully",
        "announcement": announcement
    }


@router.get("/executive-briefing")
async def get_executive_briefing():
    """Get AI-generated executive briefing"""
    try:
        crowd_data = simulation_service.generate_crowd_data()
        
        stadium_data = {
            "attendance": crowd_data["total_attendance"],
            "peak_time": "7:45 PM",
            "emergencies": len(simulation_service.active_emergencies),
            "response_time": "2.3 minutes",
            "gate_status": crowd_data["overall_status"],
            "ai_interventions": "3 congestion alerts resolved"
        }
        
        briefing = await gemini_service.generate_executive_briefing(stadium_data)
        
        return {
            "briefing": briefing,
            "generated_at": crowd_data["timestamp"],
            "data_summary": stadium_data
        }
    except Exception as e:
        raise Exception(f"Executive briefing error: {str(e)}")
