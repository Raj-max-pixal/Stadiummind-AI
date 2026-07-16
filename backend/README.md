# StadiumMind AI - Backend

FastAPI backend for StadiumMind AI - AI-powered Stadium Operations Platform.

## Tech Stack

- **Framework**: FastAPI 0.115+
- **Language**: Python 3.12+
- **AI**: Google Generative AI (Gemini 1.5)
- **Firebase**: Firebase Admin SDK
- **WebSocket**: websockets 13.1+
- **Validation**: Pydantic 2.9+

## Getting Started

### Prerequisites

- Python 3.12 or higher
- pip or poetry
- Firebase project configured
- Gemini API key

### Installation

1. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Configure environment:
```bash
cp .env.example .env
# Edit .env with your API keys
```

4. Run the server:
```bash
python -m app.main
```

Or using uvicorn directly:
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

## API Endpoints

### Authentication
- POST `/api/auth/register` - Register new user
- POST `/api/auth/login` - Login user
- POST `/api/auth/logout` - Logout user
- GET `/api/auth/user` - Get current user

### AI Assistant
- POST `/api/assistant/ask` - Ask AI assistant
- POST `/api/assistant/voice` - Voice input to AI

### Crowd Intelligence
- GET `/api/crowd/realtime` - Get real-time crowd data
- POST `/api/crowd/predictions` - Get crowd predictions
- GET `/api/crowd/recommendations` - Get gate recommendations

### Emergency
- POST `/api/emergency/report` - Report emergency
- GET `/api/emergency/active` - Get active emergencies
- POST `/api/emergency/respond` - Respond to emergency
- GET `/api/emergency/volunteers` - Get volunteers

### Translation
- POST `/api/translate/text` - Translate text
- POST `/api/translate/voice` - Translate voice

### Admin
- GET `/api/admin/analytics` - Get analytics
- GET `/api/admin/users` - Get users
- POST `/api/admin/announce` - Make announcement
- GET `/api/admin/executive-briefing` - Get AI executive briefing

## WebSocket Endpoints

- WS `/ws/crowd` - Real-time crowd data stream
- WS `/ws/emergency` - Emergency updates stream

## Project Structure

```
app/
├── api/                # API routes
│   ├── auth.py
│   ├── assistant.py
│   ├── crowd.py
│   ├── emergency.py
│   ├── translation.py
│   └── admin.py
├── core/               # Core functionality
├── models/             # Pydantic models
│   ├── user.py
│   ├── crowd.py
│   ├── emergency.py
│   ├── assistant.py
│   └── translation.py
├── services/           # Business logic
│   ├── gemini_service.py
│   └── simulation_service.py
├── repositories/       # Data access
├── schemas/            # Database schemas
├── utils/              # Utilities
├── websocket/          # WebSocket handlers
│   ├── crowd_ws.py
│   └── emergency_ws.py
├── ai/                 # AI-specific modules
├── config.py           # Configuration
└── main.py             # Application entry
```

## Services

### GeminiService
Handles all AI interactions with Google Gemini API:
- Chain-of-thought reasoning
- Executive briefing generation
- Emergency analysis
- Crowd prediction
- Translation

### SimulationService
Simulates stadium data:
- Real-time crowd simulation
- Emergency generation
- Volunteer management
- Route calculation

## Environment Variables

```env
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
GEMINI_API_KEY=your_gemini_key
GOOGLE_MAPS_API_KEY=your_maps_key
BACKEND_URL=http://localhost:8000
FRONTEND_URL=http://localhost:3000
```

## Development

### Run tests
```bash
pytest
```

### Code formatting
```bash
black app/
isort app/
```

### Type checking
```bash
mypy app/
```

## Deployment

### Render (Free Tier)
1. Connect GitHub repository
2. Configure environment variables
3. Deploy automatically on push

### Docker
```bash
docker build -t stadiummind-backend .
docker run -p 8000:8000 stadiummind-backend
```

## Contributing

1. Follow existing code style
2. Add tests for new features
3. Update documentation
4. Create pull request

## License

MIT License
## Latest UI and Feature Update - July 2026

The latest work was frontend-focused. Backend API contracts remain unchanged while the Flutter app now provides better animated dashboards and working client-side interactions for fan guidance, volunteer response, emergency reporting, and admin operations actions.
