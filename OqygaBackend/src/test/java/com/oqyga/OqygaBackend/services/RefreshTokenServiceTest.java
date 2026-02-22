package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.security.JwtUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class RefreshTokenServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private JwtUtil jwtUtil;

    @InjectMocks
    private RefreshTokenService refreshTokenService;

    private User user;

    @BeforeEach
    void setUp() {
        user = new User();
        user.setUserId(1);
        user.setUserName("testuser");
    }

    @Test
    void createRefreshToken_Success() {
        String mockToken = "refresh-token-123";
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        when(jwtUtil.generateRefreshToken(1)).thenReturn(mockToken);

        String result = refreshTokenService.createRefreshToken(1);

        assertEquals(mockToken, result);
        assertEquals(mockToken, user.getRefreshToken());
        verify(userRepository).save(user);
    }

    @Test
    void verifyRefreshToken_Success() {
        String token = "valid-token";
        user.setRefreshToken(token);

        when(userRepository.findByRefreshToken(token)).thenReturn(Optional.of(user));
        when(jwtUtil.validateJwtToken(token)).thenReturn(true);

        User result = refreshTokenService.verifyRefreshToken(token);

        assertNotNull(result);
        assertEquals(user.getUserId(), result.getUserId());
    }

    @Test
    void verifyRefreshToken_TokenExpired_ShouldThrowException() {
        String token = "expired-token";
        user.setRefreshToken(token);

        when(userRepository.findByRefreshToken(token)).thenReturn(Optional.of(user));
        when(jwtUtil.validateJwtToken(token)).thenReturn(false);

        Exception exception = assertThrows(IllegalArgumentException.class,
                () -> refreshTokenService.verifyRefreshToken(token));

        assertTrue(exception.getMessage().contains("Сессия истекла"));
        assertNull(user.getRefreshToken()); // Проверяем, что токен обнулился в объекте
        verify(userRepository).save(user);
    }

    @Test
    void deleteRefreshToken_Success() {
        when(userRepository.findById(1)).thenReturn(Optional.of(user));
        user.setRefreshToken("some-token");

        refreshTokenService.deleteRefreshToken(1);

        assertNull(user.getRefreshToken());
        verify(userRepository).save(user);
    }
}