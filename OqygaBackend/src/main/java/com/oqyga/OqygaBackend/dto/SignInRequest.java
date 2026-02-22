package com.oqyga.OqygaBackend.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class SignInRequest {

    @NotBlank(message = "Имя пользователя не может быть пустым")
    private String userName;

    @NotBlank(message = "Пароль не может быть пустым")
    private String password;
}