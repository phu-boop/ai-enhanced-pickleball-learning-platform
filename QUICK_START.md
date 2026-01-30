# 🚀 PickleCoach AI - Quick Start Deployment Guide

## One-Command Deployment

### Prerequisites Check
```bash
# Verify Docker is running
docker --version
# Expected: Docker version 20+

# Verify Docker Compose
docker compose version
# Expected: Docker Compose version 2+

# Check available ports
netstat -tuln | grep -E ':(80|8081|8090|3307)'
# Should return empty (ports available)
```

---

## 🎯 5-Minute Production Deployment

### Step 1: Configure Environment (2 minutes)
```bash
cd /home/devphu/Documents/complete-project/PickleCoach-AI/pickleball/docker

# Edit .env file
nano .env
```

**Required Configuration:**
```bash
# Update these with your actual values:
CLIENT_ID=your_google_oauth_client_id
CLIENT_SECRET=your_google_oauth_secret
EMAIL=your_gmail@gmail.com
APP_PASSWORD=your_gmail_app_password
OPENROUTER_API_KEY=your_openrouter_api_key
GEMINI_API_KEY=your_gemini_api_key

# VNPay (if using payments)
Vnp_TmnCode=your_vnpay_tmn_code
Vnp_HashSecret=your_vnpay_hash_secret
```

### Step 2: Deploy Application (3 minutes)
```bash
# From pickleball/docker directory
docker compose up -d --build
```

### Step 3: Verify Deployment (30 seconds)
```bash
# Check all services are running
docker compose ps

# Test backend health
curl http://localhost:8081/actuator/health

# Expected response:
# {"status":"UP","components":{"db":{"status":"UP"}}}
```

---

## ✅ Post-Deployment Verification

### 1. Frontend Check
```bash
# Open in browser or curl
curl -I http://localhost

# Expected: HTTP/1.1 200 OK
```

### 2. Backend API Check
```bash
# Test Swagger UI
curl -I http://localhost:8081/swagger-ui/index.html

# Expected: HTTP/1.1 200 OK
```

### 3. Database Check
```bash
# Check MySQL is accessible
docker compose exec mysql mysql -uroot -ppassword -e "SHOW DATABASES;"

# Expected: List including 'pickleball_db'
```

### 4. AI Service Check
```bash
# Check AI service is running
docker compose logs aivision | tail -20

# Expected: No error messages
```

---

## 🌐 Access Your Application

### For Users
- **Application**: http://localhost
- **Login/Register**: http://localhost/login
- **Dashboard**: http://localhost/dashboard

### For Developers
- **API Documentation**: http://localhost:8081/swagger-ui/index.html
- **Health Check**: http://localhost:8081/actuator/health
- **Metrics**: http://localhost:8081/actuator/metrics
- **Prometheus**: http://localhost:8081/actuator/prometheus

### For Operations
- **Backend Logs**: `docker compose logs -f backend`
- **Frontend Logs**: `docker compose logs -f frontend`
- **Database Logs**: `docker compose logs -f mysql`
- **All Logs**: `docker compose logs -f`

---

## 🔧 Common Commands

### Restart Services
```bash
# Restart specific service
docker compose restart backend

# Restart all services
docker compose restart

# Rebuild and restart
docker compose up -d --build
```

### View Logs
```bash
# Follow all logs
docker compose logs -f

# Last 100 lines of backend
docker compose logs --tail=100 backend

# Search for errors
docker compose logs | grep -i error
```

### Database Operations
```bash
# Backup database
docker compose exec mysql mysqldump -uroot -ppassword pickleball_db > backup.sql

# Restore database
docker compose exec -T mysql mysql -uroot -ppassword pickleball_db < backup.sql

# Access MySQL console
docker compose exec mysql mysql -uroot -ppassword pickleball_db
```

### Clean Up
```bash
# Stop all services
docker compose down

# Stop and remove volumes (⚠️ DELETES DATA)
docker compose down -v

# Remove unused Docker resources
docker system prune -a
```

---

## 🌍 Production Deployment to Cloud

### Option 1: DigitalOcean Droplet

#### 1. Create Droplet
```bash
# Via DigitalOcean Console:
# - Ubuntu 22.04 LTS
# - 4GB RAM minimum
# - Docker pre-installed marketplace app
```

#### 2. Connect and Deploy
```bash
# SSH to droplet
ssh root@your-droplet-ip

# Clone repository
git clone https://github.com/phu-boop/PickleCoach-AI.git
cd PickleCoach-AI/pickleball/docker

# Configure .env
nano .env

# Deploy
docker compose up -d --build
```

#### 3. Configure Domain (Optional)
```bash
# Install Nginx and Certbot
apt install nginx certbot python3-certbot-nginx

# Configure SSL
certbot --nginx -d yourdomain.com
```

**Cost**: $24/month (4GB droplet)

---

### Option 2: AWS EC2

#### 1. Launch EC2 Instance
```bash
# AMI: Ubuntu 22.04 LTS
# Instance type: t3.medium (2 vCPU, 4GB RAM)
# Security Group: Open ports 80, 443, 22
```

#### 2. Install Docker
```bash
ssh -i your-key.pem ubuntu@ec2-instance

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### 3. Deploy
```bash
git clone https://github.com/phu-boop/PickleCoach-AI.git
cd PickleCoach-AI/pickleball/docker
nano .env
docker compose up -d --build
```

**Cost**: ~$30-40/month

---

### Option 3: Google Cloud Run (Serverless)

#### 1. Build and Push Images
```bash
# Authenticate
gcloud auth login

# Configure project
gcloud config set project your-project-id

# Build backend
cd pickleball/backend
gcloud builds submit --tag gcr.io/your-project-id/picklecoach-backend

# Build frontend
cd ../frontend
gcloud builds submit --tag gcr.io/your-project-id/picklecoach-frontend
```

#### 2. Deploy Services
```bash
# Deploy backend
gcloud run deploy picklecoach-backend \
  --image gcr.io/your-project-id/picklecoach-backend \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated

# Deploy frontend
gcloud run deploy picklecoach-frontend \
  --image gcr.io/your-project-id/picklecoach-frontend \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

**Cost**: Pay-per-use, ~$10-30/month for moderate traffic

---

## 📊 Monitoring in Production

### Set Up Uptime Monitoring
```bash
# Use free services:
# - UptimeRobot (https://uptimerobot.com)
# - Pingdom (https://pingdom.com)
# - Better Uptime (https://betteruptime.com)

# Monitor these endpoints:
# - http://yourdomain.com (homepage)
# - http://yourdomain.com:8081/actuator/health (backend health)
```

### Set Up Log Aggregation
```bash
# Option 1: Ship logs to Papertrail
# Configure rsyslog to forward Docker logs

# Option 2: Use Grafana Loki
docker run -d --name=loki -p 3100:3100 grafana/loki:latest
```

### Set Up Metrics Dashboard
```bash
# Run Prometheus
docker run -d -p 9090:9090 \
  -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus

# Run Grafana
docker run -d -p 3000:3000 grafana/grafana
```

---

## 🔒 Security Checklist

### Before Going Live:
- [ ] Change default database password in `.env`
- [ ] Use strong JWT secret (minimum 32 characters)
- [ ] Configure proper CORS origins
- [ ] Set up SSL/TLS certificates
- [ ] Enable firewall (only ports 80, 443, 22)
- [ ] Set up automated backups
- [ ] Configure rate limiting
- [ ] Review Spring Security configuration
- [ ] Disable debug logging in production
- [ ] Set up security monitoring

---

## 📞 Troubleshooting

### Application Won't Start
```bash
# Check logs
docker compose logs

# Common issues:
# 1. Port conflict
netstat -tuln | grep 8081
# Solution: Change BACKEND_PORT in .env

# 2. Database connection
docker compose logs mysql
# Solution: Wait 30s for MySQL to initialize

# 3. Missing environment variables
docker compose config
# Solution: Review .env file
```

### Can't Access Application
```bash
# Check if services are running
docker compose ps

# Check if ports are open
curl -I http://localhost
curl -I http://localhost:8081/actuator/health

# Check firewall (if on server)
sudo ufw status
sudo ufw allow 80/tcp
sudo ufw allow 8081/tcp
```

### Performance Issues
```bash
# Check resource usage
docker stats

# Check database connections
docker compose exec mysql mysql -uroot -ppassword -e "SHOW PROCESSLIST;"

# Scale services (if using Swarm/Kubernetes)
docker compose up -d --scale backend=3
```

---

## 🎯 Success Criteria

Your deployment is successful when:
- ✅ `docker compose ps` shows all services "Up"
- ✅ `curl http://localhost` returns 200 OK
- ✅ `curl http://localhost:8081/actuator/health` returns `{"status":"UP"}`
- ✅ You can login to the application
- ✅ No errors in `docker compose logs`

---

## 🚀 You're Live!

Once deployed, your application is accessible at:
- **Local**: http://localhost
- **VPS**: http://your-server-ip
- **Domain**: http://yourdomain.com (after DNS configuration)

**Next immediate steps:**
1. Test all major workflows (signup, login, upload video)
2. Set up monitoring and alerts
3. Configure automated backups
4. Share with your first users!

---

*Need help? Check the `TRANSFORMATION_REPORT.md` for detailed documentation.*
