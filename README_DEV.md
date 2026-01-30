# PickleCoach AI - Development Guidelines

This document outlines the coding standards, configuration management, and best practices for the PickleCoach AI project.

## 1. Configuration Management (`.env`)
**NEVER hardcode secrets or environment-specific URLs.**

All configuration is managed centrally in `pickleball/docker/.env`.
-   **Ports**: `BACKEND_PORT`, `FRONTEND_PORT`, etc.
-   **URLs**: `BACKEND_URL_PUBLIC`, `VITE_API_URL`, etc.
-   **Secrets**: `OPENROUTER_API_KEY`, `DB_PASSWORD`, etc.

### Adding a New Variable
1.  Add it to `pickleball/docker/.env` with a default value.
2.  Add it to `docker-compose.yml` under the relevant service (`env_file` automatically picks it up, but build args need explicit passing).
3.  **Frontend**: If needed in the browser, prefix with `VITE_` and pass it as an argument in `docker-compose.yml` -> `frontend/Dockerfile`.

## 2. Code Cleanliness & Logging

### Frontend (React/Vite)
-   **NO `console.log`**: usage in production code. Use `console.error` only for caught exceptions.
-   **Linting**: Run `npm run lint` (if configured) before committing.

### Backend (Spring Boot)
-   **NO `System.out.println`**: Use SLF4J Logging.
    ```java
    import lombok.extern.slf4j.Slf4j;

    @Slf4j
    public class MyClass {
        public void method() {
            log.info("Processing data...");
            log.error("Something went wrong", e);
        }
    }
    ```
-   **Remove Dead Code**: Do not leave commented-out blocks of old logic.

## 3. Running the Project
Always run via Docker Compose to ensure environment consistency.

```bash
cd pickleball/docker
docker compose up -d --build
```

## 4. Port Conflict Resolution
If ports `80` or `8081` are taken:
1.  Open `.env`.
2.  Change `FRONTEND_PORT` or `BACKEND_PORT`.
3.  Restarts automatically pick up the new ports.
