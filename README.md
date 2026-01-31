# 🏓 Pickleball AI: Smart Coaching & Management Platform

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.0-brightgreen)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18.x-blue)](https://react.dev/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100.x-009688)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An end-to-end, AI-enhanced platform for Pickleball enthusiasts. This project bridges the gap between traditional coaching and modern technology by providing real-time AI analysis, WebRTC video calls, and a comprehensive management system for Learners, Coaches, and Administrators.

---

## 🌟 Vision & Impact

Pickleball is the fastest-growing sport in the world, yet personalized coaching remains expensive and geographically limited. **PickleCoach-AI** democratizes professional coaching by:
- Using **Computer Vision** to provide objective technique feedback.
- Facilitating **Remote Coaching** through zero-latency WebRTC integration.
- Automating **Curriculum Management** using AI-driven course recommendations.

---

## 🛠️ Tech Stack & Architecture

This is a **Cloud-Native, Multi-Service Architecture**:

### Core Components
-   **Frontend**: React.js 18 with Tailwind CSS for a premium, responsive UI.
-   **Backend**: Java Spring Boot 3 with Spring Security, JWT, and JPA/Hibernate.
-   **AI Engine**: Python FastAPI microservice utilizing **YOLOv8** (Object Detection) and **MediaPipe** (Pose Estimation).
-   **Real-time Logic**: WebRTC (Signaling via WebSocket) for high-performance video communication.
-   **Database**: MySQL (Production on Railway, Local on Docker).
-   **Payments**: VNPAY Integration for secure coaching fee processing.

---

## 🤖 AI Technical Deep Dive

The **AI Vision Service** is the brain of the platform. It processes user-uploaded videos to provide frame-by-frame analysis:
1.  **Pose Estimation**: Uses MediaPipe to track 33 body landmarks, calculating joint angles and stance stability.
2.  **Ball Tracking**: Uses YOLOv8 (v8n) specialized model to detect the ball trajectory.
3.  **Heuristic Analysis**: A custom feedback engine identifies common mistakes (e.g., "Non-dominant hand not stabilized", "Wrong contact point").
4.  **Course Recommendation**: A NLP-based system maps technical errors to specific curriculum modules to suggest personalized drills.

---

## 🚀 Key Features

### 👨‍🎓 For Learners
-   **Skill Assessment**: Initial evaluation and progress tracking.
-   **AI Studio**: Upload your game footage and get instant technical feedback.
-   **Smart Scheduling**: Book and pay for 1-on-1 sessions with verified coaches.
-   **Interactive Quizzes**: AI-generated quizzes to reinforce game rules and strategy.

### 🧑‍🏫 For Coaches
-   **Verified Profiles**: Showcase certifications and specialties.
-   **Schedule Management**: Automated booking system with calendar sync.
-   **Remote Coaching**: Conduct sessions via integrated video call.
-   **Financial Dashboard**: Track earnings and payment statuses.

### 🛡️ For Administrators
-   **Content Verification**: Audit courses and verified user applications.
-   **System Analytics**: Visualize user growth and revenue statistics.

---

## 🏗️ Getting Started

### 🐳 Local Development (Docker)
The easiest way to run the entire stack is using Docker Compose:

```bash
cd pickleball/docker
cp .env.example .env  # Update variables (DB_URL, API_KEYS)
docker-compose up --build -d
```

### ☁️ Cloud Deployment (Render Blueprint)
This project is configured for **Render Infrastructure as Code**.
1. Push this repository to GitHub.
2. Go to **Render Dashboard** -> **New** -> **Blueprint**.
3. Connect the repo; it will automatically provision:
    - Frontend (Static Site)
    - Backend (Docker Web Service)
    - AI Vision Service (Docker Web Service)
    - Quiz Service (Docker Web Service)

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contact
-   **Developed by**: [Your Name/Duy Phu]
-   **Email**: [Your Email]
-   **Portfolio**: [Link to Portfolio]
-   **LinkedIn**: [Link to LinkedIn]

---
*Note: This project was developed as a comprehensive demonstration of Full-Stack development, AI integration, and Scalable Infrastructure.*
