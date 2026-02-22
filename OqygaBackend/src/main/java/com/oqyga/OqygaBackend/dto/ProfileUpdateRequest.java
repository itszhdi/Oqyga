package com.oqyga.OqygaBackend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;

@Data
public class ProfileUpdateRequest {

    @NotBlank(message = "Имя пользователя не может быть пустым")
    @Size(min = 3, max = 50, message = "Имя пользователя должно быть от 3 до 50 символов")
    private String userName;

    @Pattern(
            regexp = "^\\+7[0-9]{10}$",
            message = "Неверный формат номера телефона. Ожидается: +7(XXX) XXX XXXX"
    )
    private String phoneNumber;

    @Email(message = "Неверный формат почты")
    private String email;

    private String userPhoto;
}