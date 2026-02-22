package com.oqyga.OqygaBackend.dto;

import lombok.Data;

@Data
public class ForgotPasswordRequest {
    private String phoneNumber;
}