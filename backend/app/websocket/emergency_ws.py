from fastapi import WebSocket, WebSocketDisconnect
from app.services.simulation_service import simulation_service
import json
import asyncio
import logging

logger = logging.getLogger(__name__)


class EmergencyConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []
    
    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)
        logger.info(f"Emergency WebSocket connected. Total connections: {len(self.active_connections)}")
    
    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)
        logger.info(f"Emergency WebSocket disconnected. Total connections: {len(self.active_connections)}")
    
    async def broadcast(self, message: dict):
        for connection in self.active_connections:
            try:
                await connection.send_json(message)
            except Exception as e:
                logger.error(f"Error broadcasting emergency: {str(e)}")


emergency_manager = EmergencyConnectionManager()


async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint for emergency updates"""
    await emergency_manager.connect(websocket)
    
    try:
        # Send initial active emergencies
        await websocket.send_json({
            "type": "initial",
            "emergencies": simulation_service.active_emergencies
        })
        
        while True:
            data = await websocket.receive_text()
            # Handle client messages
            message = json.loads(data)
            
            if message.get("type") == "subscribe":
                # Client wants emergency updates
                pass
            elif message.get("type") == "ping":
                await websocket.send_json({"type": "pong"})
                
    except WebSocketDisconnect:
        emergency_manager.disconnect(websocket)
    except Exception as e:
        logger.error(f"Emergency WebSocket error: {str(e)}")
        emergency_manager.disconnect(websocket)
