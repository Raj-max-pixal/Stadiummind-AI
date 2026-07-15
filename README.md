# STADIUMMIND AI

> **The AI Brain Behind Every Stadium**

AI-powered Stadium Operations Platform for FIFA World Cup 2026

## 🏆 Hackathon Project

**Built for**: FIFA World Cup 2026 GenAI Challenge  
**Tech Stack**: Flutter, FastAPI, Firebase, Gemini AI  
**Development Time**: 3-4 Days  
**Team**: Solo Developer  
**Budget**: ₹0 (Free-tier services only)

---

## 🎯 Features

### 1. AI Operations Copilot
- Chain-of-thought reasoning with Gemini AI
- Executive briefing generation
- Decision intelligence for stadium operations
- Real-time operational recommendations

### 2. Crowd Intelligence
- Live crowd simulation and monitoring
- AI-powered congestion prediction
- Real-time crowd density charts
- Smart gate recommendations

### 3. Emergency AI
- AI-powered emergency incident analysis
- Automatic volunteer assignment
- Route optimization for response teams
- Priority-based response routing

### 4. Multilingual AI
- Text translation in 4 languages (English, Spanish, Hindi, Tamil)
- Voice input/output support
- Real-time translation for volunteers

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.24+
- Dart 3.5+
- Python 3.12+
- Firebase account
- Gemini API key

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd StadiumMindAI
```

2. **Backend Setup**
```bash
cd backend
pip install -r requirements.txt
cp .env.example .env
# Edit .env with your API keys
python -m app.main
```

3. **Frontend Setup**
```bash
cd frontend
flutter pub get
flutter run
```

---

## 📱 Dashboards

### Fan Dashboard
- **Home**: Quick actions, live crowd status, AI insights
- **Crowd Intelligence**: Live charts, gate status, AI predictions
- **AI Assistant**: Natural language Q&A
- **Emergency**: Emergency reporting, contacts
- **Profile**: User settings

### Volunteer Dashboard
- **Home**: Stats, AI operations summary, fan assistance requests
- **Translation**: AI translation (4 languages)
- **Alerts**: Active emergencies
- **Profile**: Volunteer settings

### Admin Dashboard
- **Overview**: Live metrics, AI executive briefing
- **AI Copilot**: AI decision engine, ask AI
- **Analytics**: Crowd charts, gate status
- **Emergency**: Emergency command center
- **Settings**: Admin settings

---

## 🔧 Tech Stack

### Frontend
- **Framework**: Flutter 3.24+
- **State Management**: Riverpod 2.6+
- **Navigation**: go_router 14.2+
- **HTTP**: Dio 5.7+
- **Firebase**: firebase_core, firebase_auth, cloud_firestore
- **Charts**: fl_chart 0.70+
- **Speech**: speech_to_text, flutter_tts

### Backend
- **Framework**: FastAPI 0.115+
- **Language**: Python 3.12+
- **AI**: google-generativeai 0.8+ (Gemini)
- **Firebase**: firebase-admin 6.5+
- **WebSocket**: websockets 13.1+
- **Validation**: Pydantic 2.9+

### Infrastructure
- **Frontend Hosting**: Firebase Hosting
- **Backend Hosting**: Render Free Tier
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth
- **AI Service**: Gemini API (Free Tier)
- **Version Control**: GitHub

---

## 📡 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `GET /api/auth/user` - Get current user

### AI Assistant
- `POST /api/assistant/ask` - Ask AI assistant
- `POST /api/assistant/voice` - Voice input to AI

### Crowd Intelligence
- `GET /api/crowd/realtime` - Get real-time crowd data
- `POST /api/crowd/predictions` - Get crowd predictions
- `GET /api/crowd/recommendations` - Get gate recommendations

### Emergency
- `POST /api/emergency/report` - Report emergency
- `GET /api/emergency/active` - Get active emergencies
- `POST /api/emergency/respond` - Respond to emergency
- `GET /api/emergency/volunteers` - Get volunteers

### Translation
- `POST /api/translate/text` - Translate text
- `POST /api/translate/voice` - Translate voice

### Admin
- `GET /api/admin/analytics` - Get analytics
- `GET /api/admin/users` - Get users
- `POST /api/admin/announce` - Make announcement
- `GET /api/admin/executive-briefing` - Get AI executive briefing

### WebSocket
- `WS /ws/crowd` - Real-time crowd data stream
- `WS /ws/emergency` - Emergency updates stream

---

## 🎨 Design

- **Material Design 3**
- **Dark Mode Support**
- **Responsive Layouts**
- **Smooth Animations**
- **Professional Icons**
- **Color-coded Status Indicators**

---

## 🔐 Environment Variables

Create `.env` file in backend directory:

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

---

## 📦 Deployment

### Frontend (Firebase Hosting)
```bash
cd frontend
flutter build web
firebase deploy
```

### Backend (Render)
1. Connect GitHub repository
2. Configure environment variables
3. Deploy automatically on push

---

## 🧪 Testing

### Frontend Tests
```bash
cd frontend
flutter test
```

### Backend Tests
```bash
cd backend
pytest
```

---

## 📊 Project Structure

```
StadiumMindAI/
├── frontend/                    # Flutter App
│   ├── lib/
│   │   ├── core/               # Core utilities
│   │   ├── models/             # Data models
│   │   ├── repositories/       # Data repositories
│   │   ├── services/           # Business logic
│   │   ├── providers/          # Riverpod providers
│   │   ├── screens/            # UI screens
│   │   ├── widgets/            # Reusable widgets
│   │   ├── routes/             # Navigation
│   │   └── ai/                 # AI modules
│   ├── assets/                 # Assets
│   └── pubspec.yaml
├── backend/                     # FastAPI Backend
│   ├── app/
│   │   ├── api/                # API routes
│   │   ├── core/               # Core functionality
│   │   ├── models/             # Pydantic models
│   │   ├── services/           # Business logic
│   │   ├── repositories/       # Data access
│   │   ├── websocket/          # WebSocket handlers
│   │   ├── ai/                 # AI modules
│   │   ├── config.py           # Configuration
│   │   └── main.py             # Entry point
│   ├── requirements.txt
│   ├── Dockerfile
│   └── render.yaml
├── docs/                        # Documentation
├── scripts/                     # Utility scripts
├── ARCHITECTURE.md
├── FOLDER_STRUCTURE.md
├── PROJECT_SUMMARY.md
└── README.md
```

---

## 🎯 Demo Script

### 3-Minute Demo

**Screen 1: AI Situation Room (0:00-0:45)**
- Show Admin Dashboard
- Live stadium overview with real-time metrics
- AI-generated executive briefing
- "Today's attendance: 78,432. AI has prevented 3 overcrowding incidents."

**Screen 2: AI Decision Engine (0:45-1:30)**
- Navigate to AI Copilot
- Show AI detecting overcrowding at Gate A
- AI makes decision: "Redirect 30% to Gate C"
- AI explains reasoning with confidence score

**Screen 3: AI Emergency Commander (1:30-2:15)**
- Navigate to Emergency screen
- Simulate medical emergency
- AI triages: Priority HIGH
- AI coordinates: Medical team dispatched, volunteer alerted
- AI provides fastest route with real-time updates

**Screen 4: Multilingual AI (2:15-3:00)**
- Navigate to Volunteer Dashboard
- Show Translation screen
- Demonstrate English → Spanish translation
- Show Tamil → English translation
- Demonstrate voice input placeholder

---

## 🏆 Winning Features

1. **AI Operations Copilot** - Not just a chatbot, but a decision engine
2. **Chain-of-Thought Reasoning** - AI explains its reasoning
3. **Real-time Intelligence** - Live crowd simulation with AI predictions
4. **Emergency AI** - AI-powered incident analysis and response
5. **Multilingual Support** - 4 languages with voice/text

---

## 📝 License

MIT License

---

## 👨‍💻 Developer

Built by solo developer for FIFA World Cup 2026 GenAI Hackathon

**Timeline**: 3-4 Days  
**Challenge**: Build production-quality MVP with ₹0 budget  
**Result**: Complete AI-powered stadium operations platform

---

## 🙏 Acknowledgments

- Google Gemini API for AI capabilities
- Firebase for backend infrastructure
- Flutter for cross-platform frontend
- FastAPI for high-performance backend
- Render for free-tier hosting
