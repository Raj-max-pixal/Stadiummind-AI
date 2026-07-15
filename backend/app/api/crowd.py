from fastapi import APIRouter
from app.models.crowd import CrowdModel, CrowdPredictionRequest, CrowdPredictionResponse
from app.services.simulation_service import simulation_service
from app.services.gemini_service import gemini_service
from typing import Dict, Any

router = APIRouter()


@router.get("/realtime", response_model=CrowdModel)
async def get_realtime_crowd():
    """Get real-time crowd data"""
    data = simulation_service.generate_crowd_data()
    
    # Add AI insight
    try:
        context = {
            "total_attendance": data["total_attendance"],
            "gate_status": data["gates"],
            "overall_status": data["overall_status"]
        }
        
        gate_status_list = [f"{g['gate_name']}: {g['percentage']}%" for g in data['gates'][:3]]
        insight_prompt = f"""
Analyze this crowd data and provide a brief insight:
- Total Attendance: {data['total_attendance']}
- Overall Status: {data['overall_status']}
- Gate Status: {gate_status_list}

Provide 1-2 sentences about the crowd situation.
"""
        
        ai_insight = await gemini_service.generate_response(insight_prompt)
        data["ai_insight"] = ai_insight
        
        # Add recommendation
        rec_prompt = f"""
Based on the crowd data above, provide 1 actionable recommendation for stadium operations.
Keep it concise and specific.
"""
        
        ai_recommendation = await gemini_service.generate_response(rec_prompt)
        data["ai_recommendation"] = ai_recommendation
        
    except Exception as e:
        data["ai_insight"] = "AI insight unavailable"
        data["ai_recommendation"] = "AI recommendation unavailable"
    
    return CrowdModel(**data)


@router.post("/predictions", response_model=CrowdPredictionResponse)
async def get_crowd_prediction(request: CrowdPredictionRequest):
    """Get AI-powered crowd prediction"""
    # Find the gate
    gate_data = None
    for gate in simulation_service.gates:
        if gate["gate_id"] == request.gate_id:
            gate_data = gate
            break
    
    if not gate_data:
        raise Exception("Gate not found")
    
    # Generate prediction using AI
    try:
        historical_data = {
            "historical_patterns": "Peak crowds occur 30 minutes before/after matches",
            "typical_capacity": gate_data["capacity"],
            "location_factors": f"Gate {request.gate_id} serves Sections 1-4"
        }
        
        prediction = await gemini_service.generate_crowd_prediction(
            gate_data=gate_data,
            historical_data=historical_data
        )
        
        return CrowdPredictionResponse(
            gate_id=request.gate_id,
            current_percentage=round(gate_data["capacity"] * 0.5 / gate_data["capacity"] * 100, 1),
            predicted_percentage=prediction["predicted_percentage"],
            time_to_congestion_minutes=prediction["time_to_congestion"],
            confidence=prediction["confidence"],
            reasoning=prediction["reasoning"],
            recommendation=prediction["recommendation"]
        )
    except Exception as e:
        raise Exception(f"Prediction error: {str(e)}")


@router.get("/recommendations")
async def get_gate_recommendations():
    """Get AI-powered gate recommendations"""
    data = simulation_service.generate_crowd_data()
    
    # Find best gate
    best_gate = min(data["gates"], key=lambda g: g["percentage"])
    
    return {
        "recommended_gate": best_gate["gate_name"],
        "current_percentage": best_gate["percentage"],
        "estimated_wait_time": "2-3 minutes",
        "reasoning": f"{best_gate['gate_name']} has the lowest crowd density ({best_gate['percentage']}%)",
        "alternative_gates": [
            {
                "gate": g["gate_name"],
                "percentage": g["percentage"],
                "status": g["status"]
            }
            for g in sorted(data["gates"], key=lambda x: x["percentage"])[:3]
        ]
    }
