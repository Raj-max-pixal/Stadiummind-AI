# StadiumMind AI - Frontend

Flutter application for StadiumMind AI - AI-powered Stadium Operations Platform.

## Tech Stack

- **Framework**: Flutter 3.24+
- **Language**: Dart 3.5+
- **State Management**: Riverpod 2.6+
- **Navigation**: go_router 14.2+
- **HTTP**: Dio 5.7+
- **Firebase**: firebase_core, firebase_auth, cloud_firestore
- **Maps**: google_maps_flutter
- **Speech**: speech_to_text, flutter_tts
- **Charts**: fl_chart

## Getting Started

### Prerequisites

- Flutter SDK 3.24 or higher
- Dart 3.5 or higher
- Android Studio / Xcode / VS Code
- Firebase project configured

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Project Structure

```
lib/
├── core/              # Core utilities and configs
│   ├── constants/     # API and app constants
│   ├── theme/         # Theme configuration
│   ├── utils/         # Utility functions
│   └── config/        # Firebase config
├── models/            # Data models
├── repositories/      # Data repositories
├── services/          # Business logic services
├── providers/         # Riverpod state providers
├── screens/           # UI screens
│   ├── auth/          # Authentication screens
│   ├── fan/           # Fan dashboard
│   ├── volunteer/     # Volunteer dashboard
│   ├── admin/         # Admin dashboard
│   └── shared/        # Shared screens
├── widgets/           # Reusable widgets
│   ├── common/        # Common widgets
│   ├── charts/        # Chart widgets
│   ├── maps/          # Map widgets
│   └── emergency/     # Emergency widgets
├── routes/            # Navigation routes
└── ai/                # AI-specific modules
    ├── agents/        # AI agents
    └── reasoning/     # AI reasoning
```

## Features

### Fan Dashboard
- Stadium navigation
- AI assistant
- Emergency reporting
- Real-time crowd status
- Smart recommendations

### Volunteer Dashboard
- AI translation (4 languages)
- Active alerts
- Fan assistance requests
- AI operations summary

### Admin Dashboard
- AI Operations Copilot
- Real-time analytics
- Emergency command center
- AI recommendations
- Executive briefings

## Environment Variables

Create `.env` file in the project root:

```
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
GEMINI_API_KEY=your_gemini_key
GOOGLE_MAPS_API_KEY=your_maps_key
BACKEND_URL=http://localhost:8000
```

## Contributing

1. Follow the existing code style
2. Write tests for new features
3. Update documentation
4. Create a pull request

## License

MIT License
