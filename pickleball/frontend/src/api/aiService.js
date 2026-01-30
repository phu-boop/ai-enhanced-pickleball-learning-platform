import axios from 'axios';

// Create a dedicated client for the AI Service which runs on a different port (8090 public)
const aiClient = axios.create({
    baseURL: import.meta.env.VITE_AI_SERVICE_URL || 'http://localhost:8090',
    headers: {
        'Content-Type': 'application/json',
    },
});

export async function analyzePose(videoFile) {
    // Logic mostly for direct streaming or specific AI endpoints if different from backend proxy
    // Currently AiVideo.jsx was calling localhost:8000/analyze directly
    try {
        const formData = new FormData();
        formData.append('file', videoFile);

        const response = await aiClient.post('/analyze', formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });
        return response.data;
    } catch (error) {
        console.error('Error calling AI Service:', error);
        throw error;
    }
}

export default aiClient;
