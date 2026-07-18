# STADIUMMIND AI

**The AI Brain Behind Every Stadium**

StadiumMind AI is a production-oriented stadium operations web platform for live match-day coordination. It supports fan guidance, crowd intelligence, emergency operations, multilingual assistance, nearby lodging discovery, and admin command workflows.

## Live Match Configuration

The current frontend match context is:

- France vs England
- Spain vs Argentina

These names are configured in `frontend/lib/core/constants/app_constants.dart`.

## Production Features

- Firebase Auth based login for fan, volunteer, and admin roles
- Firestore-backed user profile documents with role metadata
- Gemini-powered AI assistant, translation, emergency analysis, and operations summaries
- Google Maps/location-ready Flutter frontend
- OpenStreetMap Overpass lodging discovery for real nearby hotels/guest houses
- FastAPI backend for AI, crowd, emergency, translation, admin, and WebSocket services
- Publish-ready Flutter web metadata and PWA manifest
- Configurable backend/Firebase values through build-time environment variables

## Dashboards

### Fan
- Match-day home for France vs England and Spain vs Argentina
- Stadium guidance quick actions
- Crowd intelligence
- Rooms Near Me with real location-based lodging data
- AI Assistant
- Emergency reporting
- Profile settings

### Volunteer
- Active volunteer operations dashboard
- AI operations summary
- Translation support
- Voice input with fallback guided input
- Alert response actions
- Volunteer profile

### Admin
- Live metrics
- AI executive briefing
- AI Copilot
- Crowd analytics
- Emergency command
- Operations settings

## Frontend Setup

```bash
cd frontend
flutter pub get
flutter run
```

## Backend Setup

```bash
cd backend
pip install -r requirements.txt
python -m app.main
```

## Website Build

For local web build:

```bash
cd frontend
flutter build web --release
```

For production web build with Firebase and backend values:

```bash
flutter build web --release ^
  --dart-define=BACKEND_URL=https://your-backend.example.com ^
  --dart-define=BACKEND_WS_URL=wss://your-backend.example.com ^
  --dart-define=FIREBASE_API_KEY=your_key ^
  --dart-define=FIREBASE_APP_ID=your_app_id ^
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=your_sender_id ^
  --dart-define=FIREBASE_PROJECT_ID=your_project_id ^
  --dart-define=FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com ^
  --dart-define=FIREBASE_STORAGE_BUCKET=your_project.appspot.com ^
  --dart-define=FIREBASE_MEASUREMENT_ID=your_measurement_id
```

Publish the generated site from:

```text
frontend/build/web
```

## Firebase Requirements

Enable these Firebase services:

- Authentication with Email/Password provider
- Firestore database
- Authorized domains for your published website domain

Firestore user documents are stored under:

```text
users/{uid}
```

Expected fields:

- `email`
- `name`
- `role`
- `isActive`
- `createdAt`
- `lastLogin`

## Backend Environment

Create `backend/.env` with:

```env
GEMINI_API_KEY=your_gemini_key
BACKEND_URL=https://your-backend.example.com
FRONTEND_URL=https://your-website.example.com
```

Add Firebase/Google Maps variables if your backend deployment needs them.

## Validation

Latest validation performed:

- `flutter test test/hotel_room_model_test.dart`: passed
- Backend Python compile check: passed
- `flutter analyze --no-fatal-infos`: passed
- `flutter build web --release`: source compilation starts, then this machine blocks Flutter's `impellerc.exe` shader compiler through Windows Application Control policy. Run the same build on a machine/CI runner where Flutter engine tools are allowed.

Normal analyzer still reports existing info-level style/deprecation cleanup items, but there are no blocking build/test failures.
