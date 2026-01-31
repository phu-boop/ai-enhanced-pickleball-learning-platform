# Use Python 3.10 slim for smaller image size and better compatibility
FROM python:3.10-slim

WORKDIR /app

# Install system dependencies required for OpenCV and MediaPipe
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    libgl1 \
    libegl1 \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV GLOG_logtostderr=0
ENV GLOG_minloglevel=2

# Pre-download YOLO model during build to avoid runtime delay/timeout
RUN wget https://github.com/ultralytics/assets/releases/download/v8.4.0/yolov8n.pt -O /app/yolov8n.pt

COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip
# Install dependencies, preferring binary wheels to avoid compilation
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

COPY . .

RUN mkdir -p data uploads outputs

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
