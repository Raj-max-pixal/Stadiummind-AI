# STADIUMMIND AI - Project Summary

## Overview

StadiumMind AI is a production-ready AI stadium operations platform for live match-day coordination. The website supports fans, volunteers, and stadium administrators with AI-guided crowd flow, emergency response, multilingual help, nearby lodging discovery, and operations intelligence.

## Live Match Context

- France vs England
- Spain vs Argentina

## Frontend

- Flutter web/mobile application
- Firebase Auth login
- Firestore user profiles and role metadata
- Riverpod state management
- go_router navigation
- Material 3 UI
- Google Maps/location-ready setup
- OpenStreetMap Overpass lodging lookup
- PWA-ready web metadata

## Backend

- FastAPI application
- Gemini AI service
- Crowd intelligence APIs
- Emergency operations APIs
- Translation APIs
- Admin intelligence APIs
- WebSocket endpoints for live crowd and emergency updates
- Docker and Render-ready deployment files

## User Roles

### Fan
- Match-day home screen
- France vs England live card
- Spain vs Argentina next-match label
- Crowd intelligence
- Rooms Near Me with real nearby lodging data
- AI assistant
- Emergency reporting
- Profile settings

### Volunteer
- Volunteer operations home
- Fan assistance queue
- AI operations summary
- Translation workflow
- Voice input with guided fallback
- Alert response actions

### Admin
- Live metrics
- AI executive briefing
- AI Copilot
- Crowd analytics
- Emergency command
- Operations settings

## Production Configuration

Frontend production values are passed with `--dart-define`:

- `BACKEND_URL`
- `BACKEND_WS_URL`
- `FIREBASE_API_KEY`
- `FIREBASE_APP_ID`
- `FIREBASE_MESSAGING_SENDER_ID`
- `FIREBASE_PROJECT_ID`
- `FIREBASE_AUTH_DOMAIN`
- `FIREBASE_STORAGE_BUCKET`
- `FIREBASE_MEASUREMENT_ID`

## Publish Target

Build output:

```text
frontend/build/web
```

Use this folder for Firebase Hosting, Netlify, Vercel static hosting, or any static web host with SPA rewrites to `index.html`.

## Validation

- Focused Flutter model tests pass
- Backend Python compile check passes
- Analyzer passes with `--no-fatal-infos`
- Local web release bundling is blocked on this machine by Windows Application Control policy for Flutter's `impellerc.exe`; use a CI runner or development machine that allows Flutter engine tools for the final hosted build.
