# -*- coding: utf-8 -*-
import logging
import warnings
from fastapi import FastAPI, UploadFile, File, BackgroundTasks
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
import shutil
import uuid
import os
import traceback
import asyncio
import aiofiles
from video_processor import process_video
from converter import convert_to_browser_compatible
from course_analyzer import recommend_courses

# Job tracking
jobs = {}

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s",
    encoding="utf-8"
)
logging.getLogger('mediapipe').setLevel(logging.ERROR)
warnings.filterwarnings("ignore", category=UserWarning, module="google.protobuf.symbol_database")

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Folder setup
UPLOAD_DIR = "uploads"
OUTPUT_DIR = "outputs"
os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(OUTPUT_DIR, exist_ok=True)

app.mount("/outputs", StaticFiles(directory=OUTPUT_DIR), name="outputs")

@app.get("/")
async def root():
    return {"message": "PickleCoach AI Vision API is running", "status": "healthy"}

@app.get("/health")
async def health():
    import video_processor
    return {
        "status": "healthy",
        "models": {
            "pose": video_processor.pose is not None,
            "model": video_processor.model is not None,
            "font": video_processor.font is not None
        }
    }


def run_analysis_task(job_id: str, input_path: str, raw_output_path: str, final_output_path: str, final_output_filename: str):
    try:
        jobs[job_id]["status"] = "processing"
        
        # 1. Process video
        result = process_video(input_path, raw_output_path)
        
        # 2. Convert to browser compatible
        convert_to_browser_compatible(raw_output_path, final_output_path)
        
        # 3. Analyze results
        feedback_errors = result.get("errors", [])
        detected_shots = result.get("detected_shots", [])
        detected_shot = result.get("detected_shot")
        recommendations = recommend_courses(feedback_errors, detected_shot)
        
        # 4. Save result
        jobs[job_id].update({
            "status": "success",
            "result": {
                "status": "success",
                "video_url": f"/outputs/{final_output_filename}",
                "details": {
                    "frame_count": result.get("frame_count", 0),
                    "good_points": result.get("good_points", []),
                    "errors": result.get("errors", []),
                    "detected_shots": result.get("detected_shots", []),
                    "detected_shot": result.get("detected_shot")
                },
                "recommended_courses": recommendations
            }
        })
        logging.info(f"Job {job_id} finished successfully")

    except Exception as e:
        error_msg = str(e)
        trace = traceback.format_exc()
        logging.error(f"Job {job_id} failed: {error_msg}\n{trace}")
        jobs[job_id].update({
            "status": "error",
            "message": error_msg,
            "details": trace
        })
    finally:
        # Cleanup input files
        if os.path.exists(input_path):
            os.remove(input_path)
        if os.path.exists(raw_output_path):
            os.remove(raw_output_path)

@app.post("/analyze")
async def analyze(background_tasks: BackgroundTasks, file: UploadFile = File(...)):
    job_id = str(uuid.uuid4())
    input_path = os.path.join(UPLOAD_DIR, f"{job_id}.mp4")
    raw_output_path = os.path.join(UPLOAD_DIR, f"{job_id}_raw.mp4")
    final_output_filename = f"{job_id}_annotated.mp4"
    final_output_path = os.path.join(OUTPUT_DIR, final_output_filename)

    # Save file immediately using aiofiles to avoid blocking the event loop
    logging.info(f"Starting async upload for job {job_id}")
    try:
        async with aiofiles.open(input_path, "wb") as buffer:
            while content := await file.read(1024 * 1024):  # Read in 1MB chunks
                await buffer.write(content)
        logging.info(f"File saved successfully for job {job_id}")
    except Exception as e:
        logging.error(f"Failed to save file for job {job_id}: {str(e)}")
        return JSONResponse({"status": "error", "message": "Failed to save upload file"}, status_code=500)

    # Initialize job status
    jobs[job_id] = {"status": "pending", "result": None}

    # Start background task
    background_tasks.add_task(
        run_analysis_task, 
        job_id, 
        input_path, 
        raw_output_path, 
        final_output_path, 
        final_output_filename
    )

    return {"job_id": job_id, "status": "pending"}

@app.get("/status/{job_id}")
async def get_status(job_id: str):
    if job_id not in jobs:
        return JSONResponse({"status": "error", "message": "Job not found"}, status_code=404)
    
    return jobs[job_id]