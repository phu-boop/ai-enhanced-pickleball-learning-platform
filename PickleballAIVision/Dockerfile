# Use Python 3.10 slim for smaller image size and better compatibility
FROM python:3.10-slim

WORKDIR /app

# Install system dependencies required for OpenCV and MediaPipe
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --upgrade pip
# Install dependencies, preferring binary wheels to avoid compilation
RUN pip install --no-cache-dir --prefer-binary -r requirements.txt

COPY . .

RUN mkdir -p data

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
