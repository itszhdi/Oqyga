package com.oqyga.OqygaBackend.dto;

import jakarta.validation.constraints.Pattern;
import lombok.Data;
import jakarta.validation.constraints.Size;

@Data
public class PasswordChangeRequest {

    private String currentPassword;

    @Size(min = 8, message = "Пароль должен содержать минимум 8 символов")
    @Pattern(
            regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$",
            message = "Пароль должен содержать минимум одну заглавную, одну строчную букву и одну цифру"
    )
    private String newPassword;

    private String confirmNewPassword;
}