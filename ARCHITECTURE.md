# STADIUMMIND AI - System Architecture

## Overview
Production-quality stadium operations platform powered by Generative AI for live match operations.

## Architecture Pattern
Clean Architecture with layered separation:
- Presentation Layer (Flutter UI)
- Domain Layer (Business Logic)
- Data Layer (Repositories, Services)
- Infrastructure Layer (External APIs)

## Technology Stack

### Frontend
- **Framework**: Flutter 3.24+
- **Language**: Dart 3.5+
- **State Management**: Riverpod 2.6+
- **HTTP Client**: Dio 5.7+
- **Maps**: google_maps_flutter 2.9+
- **Authentication**: firebase_auth 5.3+
- **Database**: cloud_firestore 5.4+
- **Speech**: speech_to_text 7.1+
- **Charts**: fl_chart 0.70+
- **Icons**: cupertino_icons 1.0+

### Backend
- **Framework**: FastAPI 0.115+
- **Language**: Python 3.12+
- **AI SDK**: google-generativeai 0.8+
- **Firebase Admin**: firebase-admin 6.5+
- **WebSocket**: fastapi[all]
- **CORS**: fastapi.middleware.cors
- **Environment**: python-dotenv 1.0+

### Infrastructure
- **Frontend Hosting**: Firebase Hosting
- **Backend Hosting**: Render Free Tier
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth
- **AI Service**: Gemini API (Free Tier)
- **Maps**: Google Maps Platform
- **Version Control**: GitHub

## Core Features

### 1. AI Stadium Assistant
- Natural language Q&A for stadium navigation
- Context-aware responses using Gemini
- Real-time location-based answers
- Multi-language support

### 2. AI Crowd Prediction
- Real-time crowd simulation
- AI-powered congestion prediction
- Gate recommendation system
- Live heatmap visualization

### 3. Emergency AI
- AI-generated incident reports
- Priority-based response routing
- Nearest resource identification
- Fastest route calculation

### 4. Multilingual AI
- 6 languages: English, Spanish, French, Arabic, Hindi, Tamil
- Voice and text input
- Real-time translation
- Volunteer dashboard translation

## Data Models

### User Roles
- **Fan**: Basic navigation, assistance
- **Volunteer**: Enhanced features, translation
- **Admin**: Full dashboard, controls

### Simulated Data Streams
- Crowd density per gate
- Parking occupancy
- Metro station load
- Food court queues
- Washroom occupancy
- Emergency events
- Volunteer locations
- Weather conditions

## API Endpoints

### Authentication
- POST /api/auth/register
- POST /api/auth/login
- POST /api/auth/logout
- GET /api/auth/user

### AI Assistant
- POST /api/assistant/ask
- POST /api/assistant/voice

### Crowd Prediction
- GET /api/crowd/realtime
- GET /api/crowd/predictions
- GET /api/crowd/recommendations

### Emergency
- POST /api/emergency/report
- GET /api/emergency/active
- POST /api/emergency/respond

### Multilingual
- POST /api/translate/text
- POST /api/translate/voice

### Admin
- GET /api/admin/analytics
- GET /api/admin/users
- POST /api/admin/announce

## Security Considerations
- Firebase Auth for user authentication
- API key protection (environment variables)
- Role-based access control (RBAC)
- CORS configuration
- Input validation and sanitization
- Rate limiting (to be implemented)

## Performance Optimization
- Riverpod for efficient state management
- WebSocket for real-time updates
- Firestore caching strategies
- Lazy loading for maps
- Image optimization
- Code splitting (to be implemented)

## Scalability Considerations
- Horizontal scaling (FastAPI with Gunicorn)
- Firestore auto-scaling
- CDN for static assets
- WebSocket connection pooling
- Database indexing strategies

## Monitoring & Logging
- Firebase Analytics
- Crashlytics (Flutter)
- Backend logging (Python logging)
- Performance monitoring (to be implemented)

## Deployment Strategy
- Frontend: Firebase Hosting with CI/CD
- Backend: Render with automatic deployments
- Environment: Production, Staging, Development
- Database: Firestore (shared across environments)
## Latest UI and Feature Update - July 2026

The presentation layer now provides more complete client-side interaction behavior: animated dashboard transitions, modal route guidance, snackbar-based task confirmation, stateful admin settings, and actionable operations controls. These improvements sit in the Flutter frontend and do not change the backend API contract.

The Rooms Near Me feature is client-side and reads real lodging data from OpenStreetMap Overpass using the user's granted location; booking inventory is intentionally not modeled without a verified booking provider API.
