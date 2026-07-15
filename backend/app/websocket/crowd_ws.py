from fastapi import WebSocket, WebSocketDisconnect
from app.services.simulation_service import simulation_service
import json
import asyncio
import logging

logger = logging.getLogger(__name__)


class ConnectionManager:
    def __init__(self):
        self.active_connections: list[WebSocket] = []
    
    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)
        logger.info(f"WebSocket connected. Total connections: {len(self.active_connections)}")
    
    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)
        logger.info(f"WebSocket disconnected. Total connections: {len(self.active_connections)}")
    
    async def broadcast(self, message: dict):
        for connection in self.active_connections:
            try:
                await connection.send_json(message)
            except Exception as e:
                logger.error(f"Error broadcasting to connection: {str(e)}")


manager = ConnectionManager()


async def crowd_simulation_task():
    """Background task to simulate crowd data"""
    while True:
        try:
            data = simulation_service.generate_crowd_data()
            await manager.broadcast(data)
            await asyncio.sleep(3)  # Update every 3 seconds
        except Exception as e:
            logger.error(f"Crowd simulation error: {str(e)}")
            await asyncio.sleep(5)


async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint for real-time crowd data"""
    await manager.connect(websocket)
    
    # Start simulation task if not already running
    # In production, use a proper task manager
    
    try:
        while True:
            # Keep connection alive
            data = await websocket.receive_text()
            # Echo back or handle client messages
            await websocket.send_json({"status": "received", "data": data})
    except WebSocketDisconnect:
        manager.disconnect(websocket)
    except Exception as e:
        logger.error(f"WebSocket error: {str(e)}")
        manager.disconnect(websocket)
