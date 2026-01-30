# CI/CD Pipeline Documentation

## Overview
Automated Continuous Integration and Deployment pipeline using GitHub Actions for PickleCoach AI application.

## Workflows

### 1. Backend CI/CD (`backend-ci.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Changes in `pickleball/backend/**`

**Jobs:**

#### Test Job
- Sets up MySQL 8.0 service
- Runs Maven tests with test database
- Uses Java 17 with Maven caching
- Uploads JAR artifact for deployment

#### Code Quality Job
- Runs SpotBugs static analysis
- Checks for TODO/FIXME comments
- Reports code quality issues

#### Build Docker Job (main branch only)
- Builds Docker image with Git SHA tag
- Optionally pushes to Docker Hub
- Creates `latest` tag for production

**Environment Variables Required:**
```bash
DB_HOST=localhost
DB_PORT=3306
DB_NAME=test_db
DB_USER=root
DB_PASSWORD=test_password
JWT_SECRET=<your-test-jwt-secret>
```

**Secrets Required (for Docker Hub):**
- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`

---

### 2. Frontend CI/CD (`frontend-ci.yml`)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Changes in `pickleball/frontend/**`

**Jobs:**

#### Test Job
- Sets up Node.js 20
- Installs dependencies with `npm ci`
- Runs ESLint
- Builds production bundle
- Uploads build artifacts

#### Code Quality Job
- Checks for `console.log` statements
- Checks for TODO/FIXME comments
- Ensures clean production code

#### Build Docker Job (main branch only)
- Builds Docker image with build args
- Tags with Git SHA and `latest`
- Optionally pushes to Docker Hub

**Secrets Required:**
- `OPENROUTER_API_KEY` (for build)
- `DOCKER_USERNAME` (for Docker Hub)
- `DOCKER_PASSWORD` (for Docker Hub)

---

### 3. Docker Compose Validation (`docker-compose.yml`)

**Triggers:**
- Push to `main` branch
- Changes in `pickleball/docker/**`
- Manual workflow dispatch

**Jobs:**

#### Validate Job
- Validates Docker Compose configuration
- Checks for `.env.example` template

#### Integration Test Job
- Creates test environment file
- Starts MySQL service
- Validates service health
- Cleans up containers

#### Notify Job
- Sends success notification
- Confirms deployment readiness

---

## Setup Instructions

### 1. GitHub Repository Setup

#### Enable GitHub Actions
1. Go to your repository on GitHub
2. Navigate to `Settings` → `Actions` → `General`
3. Enable "Allow all actions and reusable workflows"

#### Add Repository Secrets
Navigate to `Settings` → `Secrets and variables` → `Actions`

Add the following secrets:

**Required for Docker Hub (Optional):**
```
DOCKER_USERNAME=your_dockerhub_username
DOCKER_PASSWORD=your_dockerhub_token
```

**Required for Frontend Build:**
```
OPENROUTER_API_KEY=your_openrouter_api_key
```

### 2. First Push

```bash
# Commit the workflow files
git add .github/workflows/
git commit -m "Add CI/CD pipeline with GitHub Actions"

# Push to trigger workflows
git push origin main
```

### 3. Monitor Workflows

1. Go to `Actions` tab in your GitHub repository
2. View running workflows
3. Check logs for any failures

---

## Workflow Badges

Add these badges to your README.md:

```markdown
![Backend CI](https://github.com/phu-boop/PickleCoach-AI/workflows/Backend%20CI%2FCD/badge.svg)
![Frontend CI](https://github.com/phu-boop/PickleCoach-AI/workflows/Frontend%20CI%2FCD/badge.svg)
![Docker](https://github.com/phu-boop/PickleCoach-AI/workflows/Docker%20Compose%20CI%2FCD/badge.svg)
```

---

## Deployment Strategy

### Development Branch
- Runs tests and code quality checks
- Does NOT build Docker images
- Validates code before merging to main

### Main Branch
- Runs full CI/CD pipeline
- Builds and tags Docker images
- Optionally pushes to Docker Hub
- Ready for production deployment

### Pull Requests
- Runs tests to prevent broken code
- Validates code quality
- Blocks merge if tests fail

---

## Manual Deployment

### Deploy to Production (Example)

```bash
# Pull latest Docker images
docker pull your-username/picklecoach-backend:latest
docker pull your-username/picklecoach-frontend:latest

# Update docker-compose.yml to use your images
# Then deploy
cd pickleball/docker
docker compose up -d
```

---

## Troubleshooting

### Tests Failing in CI

**Check logs:**
```bash
# View workflow logs in GitHub Actions tab
```

**Common issues:**
- Database connection timeout → Increase wait time
- Missing environment variables → Add to workflow
- Dependency version mismatch → Update lockfiles

### Docker Build Failures

**Common issues:**
- Missing build arguments → Add to workflow
- Dockerfile syntax errors → Validate locally
- Large image size → Optimize Dockerfile layers

### Code Quality Checks Failing

**Fix console.log warnings:**
```bash
# Remove all console.log from production code
grep -r "console.log" pickleball/frontend/src
```

**Fix TODO comments:**
```bash
# Either complete TODOs or remove them
grep -r "TODO" pickleball/backend/src/main
```

---

## Advanced Configuration

### Add Deployment to Cloud

#### AWS ECS Deployment
```yaml
- name: Deploy to AWS ECS
  uses: aws-actions/amazon-ecs-deploy-task-definition@v1
  with:
    task-definition: task-definition.json
    service: picklecoach-service
    cluster: picklecoach-cluster
```

#### Google Cloud Run
```yaml
- name: Deploy to Cloud Run
  uses: google-github-actions/deploy-cloudrun@v1
  with:
    service: picklecoach-backend
    image: gcr.io/${{ secrets.GCP_PROJECT }}/picklecoach-backend:${{ github.sha }}
```

### Add Notifications

#### Slack Notifications
```yaml
- name: Notify Slack
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

---

## Best Practices

1. **Keep Secrets Secure**
   - Never commit secrets to repository
   - Use GitHub Secrets for sensitive data
   - Rotate secrets regularly

2. **Optimize Build Times**
   - Use caching for dependencies
   - Run tests in parallel when possible
   - Cache Docker layers

3. **Monitor Workflows**
   - Set up failure notifications
   - Review logs regularly
   - Fix broken builds immediately

4. **Version Control**
   - Tag releases with semantic versioning
   - Use protected branches
   - Require PR reviews before merge

---

## Metrics & Monitoring

### Workflow Insights
- Average build time: ~5-10 minutes
- Test coverage: Tracked in artifacts
- Success rate: Monitor in Actions tab

### Optimization Goals
- Keep build time under 10 minutes
- Maintain 100% test pass rate
- Zero security vulnerabilities

---

*Last Updated: 2026-01-29*
