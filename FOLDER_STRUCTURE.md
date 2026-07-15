# STADIUMMIND AI - Folder Structure

## Root Directory
```
StadiumMindAI/
├── frontend/                    # Flutter Application
├── backend/                     # FastAPI Backend
├── docs/                        # Documentation
├── scripts/                     # Utility scripts
├── .gitignore
├── README.md
└── ARCHITECTURE.md
```

## Frontend Structure (Flutter)
```
frontend/
├── lib/
│   ├── main.dart                # App entry point
│   ├── app.dart                 # Root widget with providers
│   │
│   ├── core/                    # Core utilities and configs
│   │   ├── constants/
│   │   │   ├── api_constants.dart
│   │   │   ├── app_constants.dart
│   │   │   └── asset_constants.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── light_theme.dart
│   │   │   ├── dark_theme.dart
│   │   │   └── color_palette.dart
│   │   ├── utils/
│   │   │   ├── validators.dart
│   │   │   ├── formatters.dart
│   │   │   └── extensions.dart
│   │   └── config/
│   │       └── firebase_config.dart
│   │
│   ├── models/                  # Data models
│   │   ├── user_model.dart
│   │   ├── crowd_model.dart
│   │   ├── emergency_model.dart
│   │   ├── gate_model.dart
│   │   └── location_model.dart
│   │
│   ├── repositories/           # Data repositories
│   │   ├── auth_repository.dart
│   │   ├── assistant_repository.dart
│   │   ├── crowd_repository.dart
│   │   ├── emergency_repository.dart
│   │   └── translation_repository.dart
│   │
│   ├── services/                # Business logic services
│   │   ├── auth_service.dart
│   │   ├── gemini_service.dart
│   │   ├── location_service.dart
│   │   ├── speech_service.dart
│   │   └── notification_service.dart
│   │
│   ├── providers/               # Riverpod state providers
│   │   ├── auth_provider.dart
│   │   ├── assistant_provider.dart
│   │   ├── crowd_provider.dart
│   │   ├── emergency_provider.dart
│   │   └── theme_provider.dart
│   │
│   ├── screens/                 # UI Screens
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   ├── fan/
│   │   │   ├── fan_dashboard.dart
│   │   │   ├── assistant_screen.dart
│   │   │   ├── map_screen.dart
│   │   │   └── emergency_screen.dart
│   │   ├── volunteer/
│   │   │   ├── volunteer_dashboard.dart
│   │   │   ├── translation_screen.dart
│   │   │   └── alerts_screen.dart
│   │   ├── admin/
│   │   │   ├── admin_dashboard.dart
│   │   │   ├── analytics_screen.dart
│   │   │   ├── users_screen.dart
│   │   │   └── settings_screen.dart
│   │   └── shared/
│   │       ├── splash_screen.dart
│   │       └── onboarding_screen.dart
│   │
│   ├── widgets/                 # Reusable widgets
│   │   ├── common/
│   │   │   ├── custom_button.dart
│   │   │   ├── custom_card.dart
│   │   │   ├── custom_textfield.dart
│   │   │   ├── loading_indicator.dart
│   │   │   └── error_widget.dart
│   │   ├── charts/
│   │   │   ├── crowd_chart.dart
│   │   │   ├── line_chart.dart
│   │   │   └── pie_chart.dart
│   │   ├── maps/
│   │   │   ├── stadium_map.dart
│   │   │   └── location_marker.dart
│   │   └── emergency/
│   │       ├── emergency_button.dart
│   │       └── incident_card.dart
│   │
│   └── routes/                  # Navigation routes
│       └── app_routes.dart
│
├── assets/                      # Assets
│   ├── images/
│   │   ├── stadium/
│   │   ├── icons/
│   │   └── onboarding/
│   └── fonts/
│
├── test/                       # Tests
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── pubspec.yaml                # Dependencies
├── analysis_options.yaml        # Linting rules
└── README.md
```

## Backend Structure (FastAPI)
```
backend/
├── app/
│   ├── main.py                  # Application entry point
│   ├── config.py                # Configuration settings
│   │
│   ├── api/                     # API routes
│   │   ├── __init__.py
│   │   ├── auth.py
│   │   ├── assistant.py
│   │   ├── crowd.py
│   │   ├── emergency.py
│   │   ├── translation.py
│   │   └── admin.py
│   │
│   ├── core/                    # Core functionality
│   │   ├── __init__.py
│   │   ├── security.py
│   │   ├── dependencies.py
│   │   └── middleware.py
│   │
│   ├── models/                  # Pydantic models
│   │   ├── __init__.py
│   │   ├── user.py
│   │   ├── crowd.py
│   │   ├── emergency.py
│   │   ├── assistant.py
│   │   └── translation.py
│   │
│   ├── services/                # Business logic
│   │   ├── __init__.py
│   │   ├── auth_service.py
│   │   ├── gemini_service.py
│   │   ├── crowd_service.py
│   │   ├── emergency_service.py
│   │   ├── translation_service.py
│   │   └── simulation_service.py
│   │
│   ├── repositories/            # Data access
│   │   ├── __init__.py
│   │   ├── firebase_repository.py
│   │   └── cache_repository.py
│   │
│   ├── schemas/                 # Database schemas
│   │   ├── __init__.py
│   │   └── firestore_collections.py
│   │
│   ├── utils/                   # Utilities
│   │   ├── __init__.py
│   │   ├── logger.py
│   │   ├── validators.py
│   │   └── helpers.py
│   │
│   └── websocket/               # WebSocket handlers
│       ├── __init__.py
│       ├── crowd_ws.py
│       └── emergency_ws.py
│
├── tests/                       # Tests
│   ├── unit/
│   ├── integration/
│   └── conftest.py
│
├── .env.example                # Environment variables template
├── requirements.txt             # Python dependencies
├── Dockerfile                  # Docker configuration
├── render.yaml                 # Render deployment config
└── README.md
```

## Documentation Structure
```
docs/
├── api/                        # API documentation
│   ├── endpoints.md
│   ├── models.md
│   └── authentication.md
├── deployment/                 # Deployment guides
│   ├── firebase.md
│   ├── render.md
│   └── github_actions.md
├── development/                # Development guides
│   ├── setup.md
│   ├── testing.md
│   └── debugging.md
└── user_guides/                 # User documentation
    ├── fan_guide.md
    ├── volunteer_guide.md
    └── admin_guide.md
```

## Scripts Structure
```
scripts/
├── setup/
│   ├── setup_flutter.sh
│   ├── setup_backend.sh
│   └── setup_firebase.sh
├── deployment/
│   ├── deploy_frontend.sh
│   └── deploy_backend.sh
└── utils/
    ├── format_code.sh
    └── run_tests.sh
```

## File Naming Conventions

### Dart Files
- Use snake_case: `auth_service.dart`
- Screens: `_screen.dart` suffix
- Widgets: lowercase with descriptive names
- Models: `_model.dart` suffix
- Providers: `_provider.dart` suffix

### Python Files
- Use snake_case: `auth_service.py`
- API routes: lowercase: `auth.py`
- Models: lowercase: `user.py`
- Services: `_service.py` suffix

## Environment Variables

### Backend (.env)
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
FRONTEND_URL=http://localhost:3000
```

### Firebase Configuration
- Create Firebase project at console.firebase.google.com
- Enable Authentication (Email/Password)
- Create Firestore database
- Enable Cloud Functions (if needed)
- Generate service account key for backend

## Git Strategy

### Branch Structure
- `main`: Production code
- `develop`: Integration branch
- `feature/*`: Feature branches
- `bugfix/*`: Bug fix branches
- `hotfix/*`: Emergency fixes

### Commit Convention
```
feat: add AI assistant feature
fix: resolve crowd prediction bug
docs: update API documentation
style: format code
refactor: optimize gemini service
test: add unit tests for auth
chore: update dependencies
```

## Dependencies Version Locking

### Flutter (pubspec.yaml)
- Pin major versions for stability
- Use caret (^) for minor updates
- Document version constraints

### Python (requirements.txt)
- Pin exact versions for production
- Use `==` for critical dependencies
- Document version requirements
