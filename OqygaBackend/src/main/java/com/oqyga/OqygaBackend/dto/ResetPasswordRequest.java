package com.oqyga.OqygaBackend.dto;

import lombok.Data;

@Data
public class ResetPasswordRequest {
    private String passwordResetToken;
    private String newPassword;
    private String confirmNewPassword;
}