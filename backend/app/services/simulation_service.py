import random
import asyncio
from typing import List, Dict, Any
from datetime import datetime
import logging

logger = logging.getLogger(__name__)


class SimulationService:
    def __init__(self):
        self.gates = [
            {"gate_id": "A", "gate_name": "Gate A", "capacity": 10000},
            {"gate_id": "B", "gate_name": "Gate B", "capacity": 10000},
            {"gate_id": "C", "gate_name": "Gate C", "capacity": 10000},
            {"gate_id": "D", "gate_name": "Gate D", "capacity": 10000},
            {"gate_id": "E", "gate_name": "Gate E", "capacity": 10000},
            {"gate_id": "F", "gate_name": "Gate F", "capacity": 10000},
            {"gate_id": "G", "gate_name": "Gate G", "capacity": 10000},
            {"gate_id": "H", "gate_name": "Gate H", "capacity": 10000},
        ]
        self.volunteers = [
            {"id": "V1", "name": "Volunteer 1", "location": "Gate A", "status": "active"},
            {"id": "V2", "name": "Volunteer 2", "location": "Gate B", "status": "active"},
            {"id": "V3", "name": "Volunteer 3", "location": "Gate C", "status": "active"},
            {"id": "V4", "name": "Volunteer 4", "location": "Section 5", "status": "active"},
            {"id": "V5", "name": "Volunteer 5", "location": "Section 12", "status": "active"},
        ]
        self.medical_teams = [
            {"id": "M1", "name": "Medical Team A", "location": "Section 5", "status": "available"},
            {"id": "M2", "name": "Medical Team B", "location": "Section 15", "status": "available"},
        ]
        self.active_emergencies = []
    
    def generate_crowd_data(self) -> Dict[str, Any]:
        gate_data = []
        total_count = 0
        
        for gate in self.gates:
            # Simulate crowd with realistic patterns
            base_percentage = random.uniform(0.3, 0.9)
            
            # Add some randomness
            variation = random.uniform(-0.1, 0.1)
            percentage = max(0.1, min(0.98, base_percentage + variation))
            
            current_count = int(gate["capacity"] * percentage)
            total_count += current_count
            
            # Determine status
            if percentage < 0.5:
                status = "LOW"
            elif percentage < 0.75:
                status = "MODERATE"
            elif percentage < 0.9:
                status = "HIGH"
            else:
                status = "CRITICAL"
            
            gate_data.append({
                "gate_id": gate["gate_id"],
                "gate_name": gate["gate_name"],
                "capacity": gate["capacity"],
                "current_count": current_count,
                "percentage": round(percentage * 100, 1),
                "status": status,
                "prediction": None,
                "recommendation": None
            })
        
        avg_wait_time = random.uniform(2, 15)
        
        if avg_wait_time < 5:
            overall_status = "NORMAL"
        elif avg_wait_time < 10:
            overall_status = "BUSY"
        else:
            overall_status = "CONGESTED"
        
        return {
            "timestamp": datetime.now().isoformat(),
            "total_attendance": total_count,
            "gates": gate_data,
            "average_wait_time": round(avg_wait_time, 1),
            "overall_status": overall_status,
            "ai_insight": None,
            "ai_recommendation": None
        }
    
    def update_crowd_simulation(self, data: Dict[str, Any]) -> Dict[str, Any]:
        # Gradually change crowd levels
        for gate in data["gates"]:
            change = random.uniform(-0.05, 0.05)
            new_percentage = max(0.1, min(0.98, (gate["percentage"] / 100) + change))
            gate["percentage"] = round(new_percentage * 100, 1)
            gate["current_count"] = int(gate["capacity"] * new_percentage)
            
            # Update status
            if gate["percentage"] < 50:
                gate["status"] = "LOW"
            elif gate["percentage"] < 75:
                gate["status"] = "MODERATE"
            elif gate["percentage"] < 90:
                gate["status"] = "HIGH"
            else:
                gate["status"] = "CRITICAL"
        
        data["timestamp"] = datetime.now().isoformat()
        data["total_attendance"] = sum(gate["current_count"] for gate in data["gates"])
        data["average_wait_time"] = round(random.uniform(2, 15), 1)
        
        return data
    
    def generate_emergency(self) -> Dict[str, Any]:
        emergency_types = [
            "Medical Emergency",
            "Crowd Congestion",
            "Lost Child",
            "Fight/Altercation",
            "Security Incident"
        ]
        
        locations = [
            "Section 5", "Section 8", "Section 12", "Section 15",
            "Gate A", "Gate B", "Food Court", "Concourse A"
        ]
        
        priorities = ["LOW", "MEDIUM", "HIGH", "CRITICAL"]
        
        emergency = {
            "id": f"EMG{random.randint(1000, 9999)}",
            "type": random.choice(emergency_types),
            "priority": random.choice(priorities),
            "location": random.choice(locations),
            "description": f"Emergency reported at {random.choice(locations)}",
            "reported_at": datetime.now().isoformat(),
            "ai_summary": None,
            "ai_recommendation": None,
            "assigned_volunteer_id": None,
            "assigned_volunteer_name": None,
            "medical_team_id": None,
            "fastest_route": None,
            "status": "active",
            "resolved_at": None
        }
        
        self.active_emergencies.append(emergency)
        return emergency
    
    def assign_volunteer(self, emergency: Dict[str, Any]) -> Dict[str, Any]:
        # Find nearest available volunteer
        available_volunteers = [v for v in self.volunteers if v["status"] == "active"]
        
        if available_volunteers:
            volunteer = random.choice(available_volunteers)
            emergency["assigned_volunteer_id"] = volunteer["id"]
            emergency["assigned_volunteer_name"] = volunteer["name"]
            volunteer["assigned_incident_id"] = emergency["id"]
        
        return emergency
    
    def get_nearest_medical_team(self, location: str) -> Dict[str, Any]:
        # Simplified distance calculation
        available_teams = [t for t in self.medical_teams if t["status"] == "available"]
        
        if available_teams:
            return random.choice(available_teams)
        
        return None
    
    def calculate_route(self, from_location: str, to_location: str) -> str:
        # Simplified route calculation
        routes = [
            f"{from_location} → Concourse → {to_location}",
            f"{from_location} → Gate C → Concourse B → {to_location}",
            f"{from_location} → Elevator → {to_location}"
        ]
        return random.choice(routes)


# Singleton instance
simulation_service = SimulationService()
