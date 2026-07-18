# STADIUMMIND AI - Website Deployment

## Production Website Checklist

- Firebase Auth Email/Password enabled
- Firestore enabled
- Published website domain added to Firebase Auth authorized domains
- Backend deployed with HTTPS
- WebSocket backend available through WSS
- Gemini API key configured on the backend
- Flutter web build created with production `--dart-define` values

## Build Command

```bash
cd frontend
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

## Publish Folder

Upload or host this folder:

```text
frontend/build/web
```

## Firebase Hosting

If using Firebase Hosting, set the public folder to:

```text
frontend/build/web
```

Use SPA rewrites so direct links like `/fan`, `/volunteer`, and `/admin` resolve to `index.html`.

## Match Names

The live match labels are configured in:

```text
frontend/lib/core/constants/app_constants.dart
```

Current labels:

- France vs England
- Spain vs Argentina
