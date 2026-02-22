package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.PasswordChangeRequest;
import com.oqyga.OqygaBackend.dto.ProfileUpdateRequest;
import com.oqyga.OqygaBackend.dto.ResetPasswordRequest;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock private UserRepository userRepository;
    @Mock private PasswordEncoder passwordEncoder;
    @Mock private SmsService smsService;

    @InjectMocks
    private UserService userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        // Устанавливаем значения @Value полей вручную
        ReflectionTestUtils.setField(userService, "uploadDir", "./uploads");
        ReflectionTestUtils.setField(userService, "uploadUrlPath", "/uploads/");

        testUser = new User();
        testUser.setUserId(1);
        testUser.setUserName("john_doe");
        testUser.setEmail("john@example.com");
        testUser.setPhoneNumber("77071112233");
        testUser.setPassword("hashed_old_password");
    }

    @Test
    @DisplayName("Загрузка пользователя по имени: Успех")
    void loadUserByUsername_Success() {
        when(userRepository.findByUserName("john_doe")).thenReturn(Optional.of(testUser));
        UserDetails details = userService.loadUserByUsername("john_doe");
        assertEquals("john_doe", details.getUsername());
    }

    @Test
    @DisplayName("Загрузка пользователя по имени: Ошибка")
    void loadUserByUsername_NotFound() {
        when(userRepository.findByUserName("unknown")).thenReturn(Optional.empty());
        assertThrows(UsernameNotFoundException.class, () -> userService.loadUserByUsername("unknown"));
    }

    @Test
    @DisplayName("Обновление профиля: Конфликт имен")
    void updateProfile_UsernameConflict() {
        ProfileUpdateRequest request = new ProfileUpdateRequest();
        request.setUserName("existing_user");

        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(userRepository.existsByUserName("existing_user")).thenReturn(true);

        assertThrows(IllegalArgumentException.class, () -> userService.updateProfile(1, request));
    }

    @Test
    @DisplayName("Обновление профиля: Успех")
    void updateProfile_Success() {
        ProfileUpdateRequest request = new ProfileUpdateRequest();
        request.setUserName("new_name");
        request.setEmail("new@mail.com");

        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(userRepository.existsByUserName("new_name")).thenReturn(false);
        when(userRepository.existsByEmail("new@mail.com")).thenReturn(false);
        when(userRepository.save(any(User.class))).thenReturn(testUser);

        User updated = userService.updateProfile(1, request);

        assertEquals("new_name", updated.getUsername());
        assertEquals("new@mail.com", updated.getEmail());
    }

    @Test
    @DisplayName("Смена пароля: Неверный текущий пароль")
    void changePassword_WrongCurrentPassword() {
        PasswordChangeRequest request = new PasswordChangeRequest();
        request.setCurrentPassword("wrong");
        request.setNewPassword("new123");
        request.setConfirmNewPassword("new123");

        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches("wrong", testUser.getPassword())).thenReturn(false);

        assertThrows(IllegalArgumentException.class, () -> userService.changePassword(1, request));
    }

    @Test
    @DisplayName("Сохранение фото: Недопустимый формат")
    void saveUserPhoto_InvalidFormat() {
        MultipartFile file = mock(MultipartFile.class);
        when(file.getOriginalFilename()).thenReturn("virus.exe");
        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));

        assertThrows(IllegalArgumentException.class, () -> userService.saveUserPhoto(1, file));
    }

    @Test
    @DisplayName("Сохранение фото")
    void saveUserPhoto_Success() throws IOException {
        MultipartFile file = mock(MultipartFile.class);
        when(file.getOriginalFilename()).thenReturn("avatar.png");
        when(file.getSize()).thenReturn(100L);
        when(file.getInputStream()).thenReturn(mock(InputStream.class));
        when(userRepository.findById(1)).thenReturn(Optional.of(testUser));

        try (MockedStatic<Files> mockedFiles = mockStatic(Files.class)) {
            mockedFiles.when(() -> Files.copy(any(InputStream.class), any(Path.class), any())).thenReturn(1L);

            userService.init();

            String photoUrl = userService.saveUserPhoto(1, file);

            assertTrue(photoUrl.contains("user_photos/"));
            assertTrue(photoUrl.endsWith(".png"));
            verify(userRepository).save(testUser);
        }
    }

    @Test
    @DisplayName("Сброс пароля: Запрос OTP")
    void requestPasswordReset_Success() {
        when(userRepository.findByPhoneNumber("77071112233")).thenReturn(Optional.of(testUser));

        userService.requestPasswordReset("77071112233");

        assertNotNull(testUser.getOtp());
        assertNotNull(testUser.getOtpExpiryDate());
        verify(smsService).sendWhatsAppMessage(eq("77071112233"), anyString());
    }

    @Test
    @DisplayName("Валидация OTP: Код истек")
    void validateResetOtp_Expired() {
        testUser.setOtp("123456");
        testUser.setOtpExpiryDate(LocalDateTime.now().minusMinutes(1)); // Истек

        when(userRepository.findByOtp("123456")).thenReturn(Optional.of(testUser));

        assertThrows(IllegalArgumentException.class, () -> userService.validateResetOtp("123456"));
    }

    @Test
    @DisplayName("Валидация OTP: Успех")
    void validateResetOtp_Success() {
        testUser.setOtp("123456");
        testUser.setOtpExpiryDate(LocalDateTime.now().plusMinutes(5));

        when(userRepository.findByOtp("123456")).thenReturn(Optional.of(testUser));

        String token = userService.validateResetOtp("123456");

        assertNotNull(token);
        assertNull(testUser.getOtp());
        assertNotNull(testUser.getPasswordResetToken());
    }

    @Test
    @DisplayName("Финальный сброс пароля: Успех")
    void resetPassword_Success() {
        ResetPasswordRequest request = new ResetPasswordRequest();
        request.setPasswordResetToken("valid_token");
        request.setNewPassword("new_pass");
        request.setConfirmNewPassword("new_pass");

        testUser.setPasswordResetToken("valid_token");
        testUser.setPasswordResetTokenExpiryDate(LocalDateTime.now().plusMinutes(5));

        when(userRepository.findByPasswordResetToken("valid_token")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.encode("new_pass")).thenReturn("encoded_new_pass");

        userService.resetPassword(request);

        assertEquals("encoded_new_pass", testUser.getPassword());
        assertNull(testUser.getPasswordResetToken());
    }
}