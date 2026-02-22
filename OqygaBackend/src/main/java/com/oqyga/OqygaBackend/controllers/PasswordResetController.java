package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.ForgotPasswordRequest;
import com.oqyga.OqygaBackend.dto.ResetPasswordRequest;
import com.oqyga.OqygaBackend.dto.ValidateOtpRequest;
import com.oqyga.OqygaBackend.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import jakarta.persistence.EntityNotFoundException;

@RestController
@RequestMapping("/api/v1/auth/password-reset")
@RequiredArgsConstructor
public class PasswordResetController {

    private final UserService userService;

    @PostMapping("/request-otp")
    public ResponseEntity<?> requestPasswordReset(@RequestBody ForgotPasswordRequest request) {
        try {
            userService.requestPasswordReset(request.getPhoneNumber());
            return ResponseEntity.ok(Map.of("message", "Если пользователь с таким номером существует, ему будет отправлено сообщение."));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.ok(Map.of("message", "Если пользователь с таким номером существует, ему будет отправлено сообщение."));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", "Произошла ошибка при отправке сообщения!"));
        }
    }

    @PostMapping("/validate-otp")
    public ResponseEntity<?> validateResetOtp(@RequestBody ValidateOtpRequest request) {
        try {
            String resetToken = userService.validateResetOtp(request.getOtp());
            return ResponseEntity.ok(Map.of("passwordResetToken", resetToken));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordRequest request) {
        try {
            userService.resetPassword(request);
            return ResponseEntity.ok(Map.of("message", "Пароль успешно изменен."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
}