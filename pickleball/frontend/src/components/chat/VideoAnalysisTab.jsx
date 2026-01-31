import React, { useRef, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import CourseCard from "../../modules/pages/learner/CourseCard";
import Swal from "sweetalert2";
import "./VideoAnalysisTab.css"; // Import file CSS mới

export default function VideoAnalysisTab() {
    const navigate = useNavigate();
    const [file, setFile] = useState(null);
    const [loading, setLoading] = useState(false);
    const [resultUrl, setResultUrl] = useState("");
    const [errorMsg, setErrorMsg] = useState("");
    const [details, setDetails] = useState(null);
    const [detectedShots, setDetectedShots] = useState([]);
    const [recommendedCourses, setRecommendedCourses] = useState([]);
    const [selectedMistake, setSelectedMistake] = useState(null);
    const [showSaveModal, setShowSaveModal] = useState(false);
    const [saveStatus, setSaveStatus] = useState({ loading: false, message: "" });
    const [userId, setUserId] = useState(null);
    const [jobId, setJobId] = useState(null);
    const [currentTipIndex, setCurrentTipIndex] = useState(0);
    const inputRef = useRef();

    const PRO_TIPS = [
        "Mẹo: Hãy giữ cổ tay ổn định khi thực hiện cú Dink để kiểm soát bóng tốt hơn.",
        "Mẹo: Di chuyển lên lưới (Kitchen line) ngay sau cú giao bóng hoặc trả bóng sâu.",
        "Mẹo: Sử dụng cú 'Third Shot Drop' để vô hiệu hóa sức mạnh của đối thủ.",
        "Mẹo: Giao bóng sâu về phía cuối sân để hạn chế khả năng tấn công của đối phương.",
        "Mẹo: Luôn giữ vợt ở phía trước ngực để sẵn sàng phản xạ nhanh.",
        "Mẹo: Giao tiếp với đồng đội bằng các khẩu lệnh 'Yours' hoặc 'Mine' để tránh va chạm."
    ];

    // Lấy userId từ session store khi component mount
    useEffect(() => {
        const userData = sessionStorage.getItem("id_user");
        if (!userData) {
            Swal.fire({
                icon: "warning",
                title: "Chưa đăng nhập",
                text: "Vui lòng đăng nhập để sử dụng tính năng này.",
            });
            navigate("/login");
            return;
        }
        setUserId(userData);
    }, [navigate]);

    // Xoay vòng Pro-tips khi đang xử lý
    useEffect(() => {
        let tipInterval;
        if (loading) {
            tipInterval = setInterval(() => {
                setCurrentTipIndex((prev) => (prev + 1) % PRO_TIPS.length);
            }, 5000);
        }
        return () => clearInterval(tipInterval);
    }, [loading]);

    const resetResults = () => {
        setResultUrl("");
        setErrorMsg("");
        setDetails(null);
        setDetectedShots([]);
        setRecommendedCourses([]);
        setSelectedMistake(null);
        setSaveStatus({ loading: false, message: "" });
        setJobId(null);
    };

    const handleDrop = (e) => {
        e.preventDefault();
        if (e.dataTransfer.files?.[0]) {
            setFile(e.dataTransfer.files[0]);
            resetResults();
        }
    };

    const handleChange = (e) => {
        if (e.target.files?.[0]) {
            setFile(e.target.files[0]);
            resetResults();
        }
    };

    const handleClick = () => inputRef.current.click();

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!file) {
            setErrorMsg("Vui lòng chọn một video.");
            return;
        }

        const formData = new FormData();
        formData.append("file", file);

        try {
            setLoading(true);
            setErrorMsg("");
            resetResults();

            const aiServiceUrl = import.meta.env.VITE_AI_SERVICE_URL || 'https://picklecoach-aivision.onrender.com';

            // 1. Send analysis request
            const res = await fetch(`${aiServiceUrl}/analyze`, {
                method: "POST",
                body: formData,
            });

            if (!res.ok) throw new Error("Gửi video thất bại");

            const data = await res.json();
            const newJobId = data.job_id;
            setJobId(newJobId);

            // 2. Start Polling
            pollJobStatus(newJobId, aiServiceUrl);

        } catch (err) {
            console.error(err);
            setErrorMsg("Lỗi khi gửi video: " + err.message);
            setLoading(false);
        }
    };

    const pollJobStatus = async (id, baseUrl) => {
        const poll = async () => {
            try {
                const res = await fetch(`${baseUrl}/status/${id}`);
                const data = await res.json();

                if (data.status === "success") {
                    const result = data.result;
                    setResultUrl(`${baseUrl}${result.video_url}`);
                    setDetails(result.details);
                    setDetectedShots(result.details.detected_shots || []);
                    setRecommendedCourses(result.recommended_courses || []);
                    setLoading(false);
                    return true; // Stop polling
                } else if (data.status === "error") {
                    setErrorMsg("Phân tích lỗi: " + (data.message || "Không rõ nguyên nhân"));
                    setLoading(false);
                    return true;
                }
                return false; // Continue polling
            } catch (err) {
                console.error("Polling error:", err);
                return false;
            }
        };

        const intervalId = setInterval(async () => {
            const shouldStop = await poll();
            if (shouldStop) clearInterval(intervalId);
        }, 3000);

        // Run immediately the first time
        poll();
    };

    const handleSaveMistake = (mistake) => {
        if (!userId) {
            navigate("/login");
            return;
        }
        setSelectedMistake(mistake);
        setShowSaveModal(true);
    };

    const confirmSaveMistake = async () => {
        if (!selectedMistake || !userId) return;

        try {
            setSaveStatus({ loading: true, message: "" });
            const response = await fetch(`${import.meta.env.VITE_API_URL || 'http://localhost:8080'}/api/mistakes`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    title: selectedMistake.title,
                    description: selectedMistake.description,
                    status: "OPEN",
                    userId: userId,
                }),
            });

            if (response.ok) {
                setSaveStatus({ loading: false, message: "Lưu lỗi thành công!" });
                setTimeout(() => {
                    setShowSaveModal(false);
                    setSaveStatus({ loading: false, message: "" });
                }, 1500);
            } else {
                throw new Error("Lưu lỗi thất bại");
            }
        } catch (error) {
            console.error("Error saving mistake:", error);
            setSaveStatus({
                loading: false,
                message: "Lưu lỗi thất bại. Vui lòng thử lại."
            });
        }
    };

    return (
        <div className="video-analysis-container">
            <h2 className="video-analysis-title">Phân tích Video Pickleball</h2>
            <p className="video-analysis-subtitle">Tải video lên để AI phân tích và cải thiện kỹ thuật chơi của bạn</p>

            <form onSubmit={handleSubmit} className="video-upload-form">
                <div
                    className={`video-upload-area ${file ? "uploaded" : ""}`}
                    onDrop={handleDrop}
                    onDragOver={(e) => e.preventDefault()}
                    onClick={handleClick}
                >
                    {!file ? (
                        <>
                            <div className="video-upload-content">
                                <div className="video-upload-icon">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        className="upload-icon"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                    >
                                        <path
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                            strokeWidth={1.5}
                                            d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                                        />
                                    </svg>
                                </div>
                                <p className="video-upload-main-text">Chọn hoặc kéo thả video vào đây</p>
                                <p className="video-upload-desc">
                                    Hỗ trợ mp4, mov, avi... Tối đa 100MB.
                                </p>
                            </div>
                            <input
                                type="file"
                                ref={inputRef}
                                onChange={handleChange}
                                className="hidden"
                                accept="video/mp4,video/x-m4v,video/*"
                            />
                        </>
                    ) : (
                        <>
                            <div className="video-upload-content">
                                <div className="video-upload-icon">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        className="upload-success-icon"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                    >
                                        <path
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                            strokeWidth={1.5}
                                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                                        />
                                    </svg>
                                </div>
                                <p className="video-file-name">{file.name}</p>
                                <button
                                    type="button"
                                    className="video-upload-link"
                                    onClick={(e) => {
                                        e.stopPropagation();
                                        setFile(null);
                                    }}
                                >
                                    Chọn lại video
                                </button>
                            </div>
                        </>
                    )}
                </div>

                <button
                    type="submit"
                    className={`video-upload-btn ${!file || loading ? "disabled" : ""}`}
                    disabled={!file || loading}
                >
                    {loading ? "Đang xử lý..." : "Bắt đầu phân tích"}
                </button>
            </form>

            {loading && (
                <div className="ai-processing-overlay">
                    <div className="ai-processing-content">
                        <div className="ai-loader-container">
                            <div className="ai-loader-pulse"></div>
                            <div className="ai-loader-spin"></div>
                            <div className="ai-loader-icon">🤖</div>
                        </div>
                        <h3 className="processing-text">AI đang phân tích video của bạn...</h3>
                        <p className="processing-subtext">Quá trình này có thể mất 1-2 phút tùy vào độ dài video.</p>

                        <div className="pro-tip-container">
                            <div className="pro-tip-card">
                                <span className="pro-tip-label">HỌC TRONG KHI CHỜ ĐỢI</span>
                                <p className="pro-tip-text">{PRO_TIPS[currentTipIndex]}</p>
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {errorMsg && (
                <div className="video-error-msg">
                    <svg className="error-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                            d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span>{errorMsg}</span>
                </div>
            )}

            {resultUrl && (
                <div className="video-results">
                    <div className="result-section">
                        <div className="result-section-content">
                            <h3 className="result-section-title">
                                <svg className="section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                        d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                                </svg>
                                Video kết quả
                            </h3>
                            <div className="video-container">
                                <video
                                    controls
                                    className="result-video"
                                    src={resultUrl}
                                />
                            </div>
                            <div className="video-download">
                                <a
                                    href={resultUrl}
                                    download
                                    className="download-btn"
                                >
                                    <svg className="download-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                            d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                                    </svg>
                                    Tải video về
                                </a>
                            </div>
                        </div>
                    </div>

                    {details && (
                        <div className="result-section">
                            <div className="result-section-content">
                                <h3 className="result-section-title">
                                    <svg className="section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    Đánh giá kỹ thuật
                                </h3>

                                <div className="stats-grid">
                                    <div className="stat-box">
                                        <h4>Tổng số khung hình</h4>
                                        <p className="stat-value">{details.frame_count}</p>
                                    </div>

                                    {details.detected_shot && (
                                        <div className="stat-box">
                                            <h4>Cú đánh tiêu biểu</h4>
                                            <p className="stat-value shot-type">{details.detected_shot.type}</p>
                                            <span>tại {details.detected_shot.time}s</span>
                                        </div>
                                    )}
                                </div>

                                {details.good_points?.length > 0 && (
                                    <div className="points-section good-points">
                                        <h4 className="points-title">
                                            <svg className="points-icon" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                                    d="M5 13l4 4L19 7" />
                                            </svg>
                                            Điểm tốt
                                        </h4>
                                        <div className="points-list">
                                            {details.good_points.map((g, i) => (
                                                <div key={i} className="point-item">
                                                    <div className="point-content">
                                                        <h5 className="point-title">{g.title}</h5>
                                                        <p className="point-description">{g.description}</p>
                                                    </div>
                                                </div>
                                            ))}
                                        </div>
                                    </div>
                                )}

                                {details.errors?.length > 0 && (
                                    <div className="points-section errors">
                                        <h4 className="points-title">
                                            <svg className="points-icon" fill="none" stroke="currentColor"
                                                viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                                    d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                            Lỗi cần cải thiện
                                        </h4>
                                        <div className="points-list">
                                            {details.errors.map((e, i) => (
                                                <div key={i} className="point-item">
                                                    <div className="point-content error-content">
                                                        <h5 className="point-title">{e.title}</h5>
                                                        <p className="point-description">{e.description}</p>
                                                    </div>
                                                    <button
                                                        onClick={() => handleSaveMistake(e)}
                                                        className="save-mistake-btn"
                                                    >
                                                        Lưu lỗi
                                                    </button>
                                                </div>
                                            ))}
                                        </div>
                                    </div>
                                )}
                            </div>
                        </div>
                    )}

                    {detectedShots.length > 0 && (
                        <div className="result-section">
                            <div className="result-section-content">
                                <h3 className="result-section-title">
                                    <svg className="section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                            d="M13 10V3L4 14h7v7l9-11h-7z" />
                                    </svg>
                                    Các cú đánh phát hiện
                                </h3>
                                <div className="shots-list">
                                    {detectedShots.map((shot, i) => (
                                        <span
                                            key={i}
                                            className="shot-tag"
                                        >
                                            {shot.type} ({shot.time}s)
                                        </span>
                                    ))}
                                </div>
                            </div>
                        </div>
                    )}

                    {recommendedCourses.length > 0 && (
                        <div className="result-section">
                            <div className="result-section-content">
                                <h3 className="result-section-title">
                                    <svg className="section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                            d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                    </svg>
                                    Khóa học đề xuất
                                </h3>
                                <div className="courses-grid">
                                    {recommendedCourses.map((course, i) => (
                                        <CourseCard key={i} course={course} />
                                    ))}
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            )}

            {/* Modal xác nhận lưu lỗi */}
            {showSaveModal && (
                <div className="modal-overlay">
                    <div className="modal">
                        <div className="modal-content">
                            <h3>Lưu lỗi sai</h3>
                            <p>
                                Bạn có muốn lưu lỗi <span>"{selectedMistake?.title}"</span> để
                                làm tài liệu học tập sau này không?
                            </p>

                            {saveStatus.message && (
                                <div className={`status-message ${saveStatus.message.includes("thành công") ? "success" : "error"}`}>
                                    {saveStatus.message}
                                </div>
                            )}

                            <div className="modal-actions">
                                <button
                                    onClick={() => {
                                        setShowSaveModal(false);
                                        setSaveStatus({ loading: false, message: "" });
                                    }}
                                    className="cancel-btn"
                                    disabled={saveStatus.loading}
                                >
                                    Hủy bỏ
                                </button>
                                <button
                                    onClick={confirmSaveMistake}
                                    className={`confirm-btn ${saveStatus.loading ? "loading" : ""}`}
                                    disabled={saveStatus.loading}
                                >
                                    {saveStatus.loading ? (
                                        <span className="btn-loading">
                                            <svg className="spinner" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                <circle className="spinner-circle" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                                <path className="spinner-path" fill="currentColor"
                                                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                            </svg>
                                            Đang xử lý...
                                        </span>
                                    ) : "Xác nhận lưu"}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
