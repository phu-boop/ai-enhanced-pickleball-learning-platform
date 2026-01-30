import apiClient from '../apiClient';

export async function uploadVideoAnalysis(userId, formData) {
    try {
        // Append userId manually if not already in formData, though typically it's handled by caller
        // formData.append('userId', userId); 

        const response = await apiClient.post('/api/ai/full-analysis', formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
            params: { userId } // Pass userId as query param as per controller
        });
        return response.data;
    } catch (error) {
        console.error('Error handling video analysis upload:', error);
        throw error;
    }
}
