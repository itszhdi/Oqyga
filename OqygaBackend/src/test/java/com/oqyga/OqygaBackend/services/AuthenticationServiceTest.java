package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.JwtResponse;
import com.oqyga.OqygaBackend.dto.RegistrationRequest;
import com.oqyga.OqygaBackend.dto.SignInRequest;
import com.oqyga.OqygaBackend.entities.Role;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.security.JwtUtil;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthenticationServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private PasswordEncoder passwordEncoder;
    @Mock
    private AuthenticationManager authenticationManager;
    @Mock
    private JwtUtil jwtUtil;
    @Mock
    private RefreshTokenService refreshTokenService;

    @InjectMocks
    private AuthenticationService authenticationService;

    @Test
    @DisplayName("SignUp: Успешная регистрация нового пользователя")
    void signUp_Success() {
        RegistrationRequest request = new RegistrationRequest();
        request.setUserName("testUser");
        request.setPassword("password123");
        request.setPhoneNumber("87771112233");
        request.setEmail("test@example.com");

        when(userRepository.existsByUserName(request.getUserName())).thenReturn(false);
        when(userRepository.existsByPhoneNumber(request.getPhoneNumber())).thenReturn(false);
        when(passwordEncoder.encode(request.getPassword())).thenReturn("encodedPassword");

        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            user.setUserId(1);
            return user;
        });

        when(jwtUtil.generateToken(any(), any())).thenReturn("accessToken123");
        when(refreshTokenService.createRefreshToken(any())).thenReturn("refreshToken123");

        JwtResponse response = authenticationService.signUp(request);

        assertNotNull(response);
        assertEquals("accessToken123", response.getAccessToken());
        assertEquals("refreshToken123", response.getRefreshToken());

        ArgumentCaptor<User> userCaptor = ArgumentCaptor.forClass(User.class);
        verify(userRepository).save(userCaptor.capture());
        User savedUser = userCaptor.getValue();

        assertEquals("testUser", savedUser.getUsername());

        assertEquals("encodedPassword", savedUser.getPassword());
        assertEquals(Role.USER, savedUser.getRole());
    }

    @Test
    @DisplayName("SignUp: Ошибка, если имя пользователя уже занято")
    void signUp_UserNameExists_ThrowsException() {
        // Arrange
        RegistrationRequest request = new RegistrationRequest();
        request.setUserName("existingUser");

        when(userRepository.existsByUserName("existingUser")).thenReturn(true);

        // Act & Assert
        ResponseStatusException exception = assertThrows(ResponseStatusException.class, () -> {
            authenticationService.signUp(request);
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatusCode());
        assertEquals("Пользователь с таким именем уже существует", exception.getReason());

        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("SignUp: Ошибка, если номер телефона уже занят")
    void signUp_PhoneNumberExists_ThrowsException() {
        // Arrange
        RegistrationRequest request = new RegistrationRequest();
        request.setUserName("newUser");
        request.setPhoneNumber("87770000000");

        when(userRepository.existsByUserName("newUser")).thenReturn(false);
        when(userRepository.existsByPhoneNumber("87770000000")).thenReturn(true);

        // Act & Assert
        ResponseStatusException exception = assertThrows(ResponseStatusException.class, () -> {
            authenticationService.signUp(request);
        });

        assertEquals(HttpStatus.BAD_REQUEST, exception.getStatusCode());
        assertEquals("Этот номер телефона уже зарегистрирован", exception.getReason());

        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("SignIn: Успешный вход пользователя")
    void signIn_Success() {
        // Arrange
        SignInRequest request = new SignInRequest();
        request.setUserName("testUser");
        request.setPassword("password123");

        User mockUser = User.builder()
                .userId(1)
                .userName("testUser")
                .role(Role.USER)
                .build();

        when(authenticationManager.authenticate(any(UsernamePasswordAuthenticationToken.class)))
                .thenReturn(null);

        when(userRepository.findByUserName("testUser")).thenReturn(Optional.of(mockUser));
        when(jwtUtil.generateToken(mockUser.getUserId(), mockUser.getAuthorities())).thenReturn("access123");
        when(refreshTokenService.createRefreshToken(mockUser.getUserId())).thenReturn("refresh123");

        // Act
        JwtResponse response = authenticationService.signIn(request);

        // Assert
        assertNotNull(response);
        assertEquals("access123", response.getAccessToken());
        assertEquals("refresh123", response.getRefreshToken());

        verify(authenticationManager).authenticate(any(UsernamePasswordAuthenticationToken.class));
    }

    @Test
    @DisplayName("SignIn: Ошибка, если пользователь не найден после аутентификации")
    void signIn_UserNotFound_ThrowsException() {

        // Arrange
        SignInRequest request = new SignInRequest();
        request.setUserName("ghostUser");
        request.setPassword("pass");

        when(authenticationManager.authenticate(any())).thenReturn(null);
        when(userRepository.findByUserName("ghostUser")).thenReturn(Optional.empty());

        // Act & Assert
        UsernameNotFoundException exception = assertThrows(UsernameNotFoundException.class, () -> {
            authenticationService.signIn(request);
        });

        assertTrue(exception.getMessage().contains("Пользователь не найден после аутентификации"));
    }
}