package com.pickle.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ErrorResponse {
    private int status;
    private String message;
    private LocalDateTime timestamp;
    private Object details; // Can hold validation errors map or detailed string

    public ErrorResponse(int status, String message, Object details) {
        this.status = status;
        this.message = message;
        this.details = details;
        this.timestamp = LocalDateTime.now();
    }
}
