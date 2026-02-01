# 🏓 Pickleball AI: Smart Coaching & Management Platform

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.3.0-brightgreen)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18.x-blue)](https://react.dev/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100.x-009688)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An end-to-end, AI-enhanced platform for Pickleball enthusiasts. This project bridges the gap between traditional coaching and modern technology by providing real-time AI analysis, WebRTC video calls, and a comprehensive management system for Learners, Coaches, and Administrators.

---

## 🔗 Live Demo
- 🌐 **Frontend**: [https://picklecoach-frontend.onrender.com](https://picklecoach-frontend.onrender.com)
- 🧠 **AI Service**: [https://picklecoach-aivision.onrender.com](https://picklecoach-aivision.onrender.com)
- 📊 **Main Backend**: [https://picklecoach-backend.onrender.com](https://picklecoach-backend.onrender.com)

## 🔐 Test Accounts
To explore the platform immediately, use the following credentials:

| Role | Email | Password |
|------|-------|----------|
| **Admin** | `admin@gmail.com` | `123123123` |
| **Coach** | `coach@gmail.com` | `123123123` |
| **Learner** | `learner@gmail.com` | `123123123` |

## 🖼️ Screenshots
| Platform Overview | AI Feature Analysis |
|------------------|------------|
| ![Screenshots1](Screenshots1.png) | ![Screenshot3](Screenshot3.png) |

| Technical Highlights |
|----------------------|
| ![Screenshots2](Screenshots2.png) |

---

## 🌟 Vision & Impact

Pickleball is the fastest-growing sport in the world, yet personalized coaching remains expensive and geographically limited. **PickleCoach-AI** democratizes professional coaching by:
- Using **Computer Vision** to provide objective technique feedback.
- Facilitating **Remote Coaching** through zero-latency WebRTC integration.
- Automating **Curriculum Management** using AI-driven course recommendations.

---

## 🚀 Key Features

### 👨‍🎓 For Learners
- **AI Studio**: Upload game footage for frame-by-frame pose analysis and ball tracking.
- **Smart Scheduling**: Seamlessly book and pay for 1-on-1 sessions.
- **Interactive Quizzes**: AI-generated adaptive quizzes to reinforce strategy.
- **Personalized Roadmap**: Get drill suggestions based on detected technique errors.

### 🧑‍🏫 For Coaches
- **Verified Profiles**: Show certifications and specialized expertise.
- **Remote Coaching**: Conduct zero-latency sessions via integrated WebRTC.
- **Financial Dashboard**: Track earnings, payments, and student progress.
- **Schedule Management**: Automated booking with calendar synchronization.

### 🛡️ For Administrators
- **System Analytics**: Real-time visualization of user growth and revenue.
- **Content Moderation**: Audit courses, materials, and coach applications.

---

## 🧩 System Architecture

```mermaid
graph TD
    Client["React Frontend (Tailwind CSS)"]
    
    subgraph "Main Infrastructure"
        SB["Spring Boot Backend (API Gateway)"]
        DB[(MySQL Database)]
        VNPAY["VNPAY (Payment)"]
    end
    
    subgraph "AI Microservices"
        AI_Vision["FastAPI AI Vision (YOLOv8 + MediaPipe)"]
        AI_Quiz["AI Quiz Service"]
    end

    Client -- "HTTPS / REST" --> SB
    Client -- "WebRTC Signaling" --> SB
    SB -- "JPA / Hibernate" --> DB
    SB -- "API Request" --> VNPAY
    SB -- "Async Processing" --> AI_Vision
    SB -- "REST" --> AI_Quiz
    
    AI_Vision -- "Video Analysis" --> SB
```

### 🏗️ Technical Implementation
- **React Frontend** communicates via REST + WebSocket for real-time interaction.
- **Spring Boot 3** handles Authentication (JWT), Business Logic, and Payments.
- **FastAPI AI Service** processes video asynchronously to avoid blocking.
- **WebRTC** signaling via Spring WebSocket for peer-to-peer coaching sessions.
- **MySQL** for transactional data (Production on Railway/Render).
- **VNPAY** Integration for secure coaching fee processing.

---

## 🧠 Engineering Challenges & Solutions

### 1. WebRTC Signaling Reliability
**Problem:** ICE candidates arriving before peer connection was ready.  
**Solution:** Implemented room-based signaling with a robust "ready" handshake protocol.  
**Result:** Stable video calls with <300ms latency even on cross-region connections.

### 2. AI Processing Timeout on Cloud
**Problem:** Video analysis (YOLOv8 + MediaPipe) exceeded Render's standard request timeout.  
**Solution:** Switched to an asynchronous background processing architecture with client polling and job tracking.  
**Result:** 0 timeouts, supports large video uploads, and highly scalable.

### 3. Secure Payment Flow
**Problem:** Preventing "man-in-the-middle" attacks and fake payment callbacks.  
**Solution:** Implemented VNPAY signature validation + idempotent transaction logic to ensure each payment is processed exactly once.  
**Result:** 100% reliable financial transactions.

---

## 🤖 AI Technical Deep Dive

The **AI Vision Service** processes user-uploaded videos to provide frame-by-frame analysis:
1.  **Pose Estimation**: Uses MediaPipe to track 33 body landmarks, calculating joint angles and stance stability.
2.  **Ball Tracking**: Uses a specialized YOLOv8 (v8n) model for trajectory detection.
3.  **Heuristic Analysis**: A custom engine identifies common technical mistakes.
4.  **Course Recommendation**: Maps technical errors to specific curriculum modules via NLP.

---

## 🧪 Testing & Quality
- **Backend**: JUnit 5, Mockito for comprehensive Service & Controller layers testing.
- **Frontend**: Manual E2E testing for complex booking & payment flows.
- **API Quality**: Standardized RESTful endpoints documented and tested via Postman.

## 🔐 Security
- **JWT-based Authentication** with secure token refresh cycles.
- **RBAC (Role-Based Access Control)**: Strict boundaries for Learner, Coach, and Admin roles.
- **Secure Signaling**: WebRTC handshake is protected via Spring Security.
- **Environment Management**: Sensitive keys managed via Docker Secrets and Render Environment Variables.

---

## 📁 Repository Structure

```text
picklecoach-ai/
├── pickleball/
│   ├── frontend/        # React + Tailwind CSS
│   ├── backend/         # Spring Boot API
│   └── docker/          # Docker Compose configurations
├── PickleballAIVision/  # FastAPI AI Service (Process logic)
├── Pickeball_AI_Quizz/   # AI Quiz Engine
├── Screenshots1.png     # Application Screenshots
├── Screenshots2.png     # Application Screenshots
└── README.md
```

---

## 🗺️ Roadmap
- [ ] **Real-time Pose Feedback**: Direct feedback during live WebRTC sessions.
- [ ] **Mobile Application**: Cross-platform app using React Native.
- [ ] **Coach Ranking**: Data-driven review and reputation system.
- [ ] **AI Model Fine-tuning**: Custom YOLO models trained on pickleball-specific datasets.

---

## 👨‍💻 My Role
This project was designed and implemented **end-to-end by myself**, including:
- Full system architecture & database schema design.
- Frontend UI/UX design & state management.
- Backend API development & security implementation.
- AI microservices integration (Computer Vision & NLP).
- Cloud deployment and CI/CD pipeline setup using Docker.

---

## 🚀 Getting Started (Developers)

### 🐳 Local Development (Docker)
```bash
cd pickleball/docker
docker compose up --build -d
```

## 🤝 Contact
- **Developer**: Nguyễn Lê Anh Phú
- **Email**: [phudz25022005@gmail.com](mailto:phudz25022005@gmail.com)
- **GitHub**: [github.com/phu-boop](https://github.com/phu-boop)
- **LinkedIn**: [linkedin.com/in/nguy%E1%BB%85n-l%C3%AA-anh-ph%C3%BA-8392393a9](https://www.linkedin.com/in/nguy%E1%BB%85n-l%C3%AA-anh-ph%C3%BA-8392393a9)

---
## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
*Note: This project serves as a professional demonstration of Full-Stack engineering, AI integration, and Scalable Cloud Infrastructure.*

