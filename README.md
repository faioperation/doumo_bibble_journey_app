# Bible Journey App – Enterprise Core System

Welcome to the **Bible Journey App** workspace. This repository contains the complete ecosystem for the Bible Journey mobile platform, including a high-performance Python/Django Rest Framework API backend and a cross-platform Dart/Flutter mobile application codebase.

---

## 📖 Project Overview
The Bible Journey App is a spiritual companion application that guides users through themed, sequence-based devotional content (Journeys) based on user categorization (onboarding questionnaires). The platform features:
* **Custom Persona Journeys**: Intelligent categorization based on onboarding QA results, mapping user sequences dynamically.
* **Daily Action Progress**: Structured stages (Prayer, Devotion, Micro-Action, Quiz, and Reflection Space) requiring consecutive completions.
* **Subscription Packages**: Monetized access configurations using Stripe Checkout and Stripe Webhook event listeners.
* **Notifications Engine**: Foreground schedules pushed via daily cron-trigger checks (APScheduler).

---

## 🛠 Tech Stack

### Backend App (`backend/`)
* **Framework**: Django 5.2.8 & Django Rest Framework 3.16.1
* **ASGI Server**: Daphne 4.2.1 (for WebSockets/Channels support)
* **WSGI Web Gateway**: Gunicorn 23.0.0
* **Relational DB**: PostgreSQL (Production) / SQLite (Development)
* **Caching & Channel Layers**: Redis 7.0+
* **Dependencies Manager**: Pip / `requirements.txt`

### Mobile App (`app-codebase/`)
* **SDK Compatibility**: Flutter SDK (Dart ^3.9.2)
* **Local Storage**: SharedPreferences
* **Audio engine**: JustAudio

---

## 📁 Repository Structure

```
├── app-codebase/            # Flutter Mobile Application Code base
│   ├── android/             # Native Android build bindings
│   ├── ios/                 # Native iOS build bindings
│   ├── lib/                 # Core Flutter source code
│   │   ├── app/             # Routing, constants, endpoints
│   │   ├── core/            # Common API services, storage access
│   │   └── features/        # Devotion, auth, profile pages
│   └── pubspec.yaml         # Dart package dependencies configuration
│
├── backend/                 # Python Django Backend Application
│   ├── accounts/            # User account registration and authentication
│   ├── bibble_project/      # Core settings and URL entry points
│   ├── daily_devotion/      # Prayers, devotions, and reflection space models
│   ├── journey/             # Journey sequences and Bible verse integrations
│   ├── notifications/       # User notifications registry and scheduler daemon
│   ├── payments/            # Stripe checkouts and webhook integrations
│   ├── quiz/                # Daily user quizzes and answer submissions
│   ├── userprogress/        # User journey step-level locks and progress logs
│   ├── Dockerfile           # Backend container instructions
│   └── requirements.txt     # Python backend dependencies list
│
├── nginx/                   # Reverse Proxy Configurations
│   └── nginx.conf           # Nginx server configurations
│
├── docker-compose.yml       # Base Docker Compose orchestrator
├── docker-compose.dev.yml   # Developer hot-reloading configurations override
└── docker-compose.prod.yml  # Production logging and restart policy override
```

---

## 🚀 Quick Start Guide (Local Development)

### 1. Backend Local Setup
Prerequisites: Python 3.11+, Redis server.

1. Navigate to the backend directory and create a virtual environment:
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
2. Install Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Copy environment variables example and configure defaults:
   ```bash
   cp .env.example .env
   ```
4. Run migrations, collect static files, and start development server:
   ```bash
   python manage.py migrate
   python manage.py collectstatic --noinput
   python manage.py runserver
   ```

### 2. Mobile App Local Setup
Prerequisites: Flutter SDK, Android Studio or Xcode.

1. Navigate to the app-codebase directory:
   ```bash
   cd app-codebase
   ```
2. Get packages:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## 🐳 Docker Deployment Setup

Deploy the backend, database, cache, and reverse proxy in a single command using Docker:

### 1. Build and Run Dev Environment (SQLite Backend)
This starts Gunicorn and Redis locally for instant testing:
```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build
```

### 2. Build and Run Production Environment (PostgreSQL Backend)
Ensure you set production variables in your `.env` file first:
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

---

## 🔒 Security Best Practices
* **Environment Variables**: Always store API secret keys (Stripe, SMTP details, Django Secret Keys) in the `.env` file; do not commit credentials.
* **User Constraints**: SQLite backend should not be used in live configurations due to concurrent transaction lock risks.
* **CORS Settings**: Restrict `CORS_ALLOWED_ORIGINS` to active API client domains in production settings.

---

## 📄 Reference Documents (Artifacts)
Additional technical resources can be found in your IDE workspace under these absolute links:
* [System Architecture & Visual Diagrams](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/architecture.md)
* [Codebase Audit & Audit Findings](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/audit_report.md)
* [API Endpoint Schemas & Responses](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/api_docs.md)
* [Environment Configuration Guide](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/env_docs.md)
* [Database Models & Seeding Details](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/database_docs.md)
* [Production Readiness Checklist](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/production_readiness_checklist.md)
* [System Scaling & VPS Deployment Guide](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/deployment_guide.md)
* [Future Architectural Roadmap](file:///C:/Users/Night%20Shift/.gemini/antigravity-ide/brain/6ae5593f-e235-41be-9b25-dc3a21340a8c/improvement_roadmap.md)
