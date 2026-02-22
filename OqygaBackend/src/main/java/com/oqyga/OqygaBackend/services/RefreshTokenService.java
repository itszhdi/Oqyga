package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.security.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

    private final UserRepository userRepository;
    private final JwtUtil jwtUtil;

    @Transactional
    public String createRefreshToken(Integer userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        String refreshToken = jwtUtil.generateRefreshToken(userId);
        user.setRefreshToken(refreshToken);
        userRepository.save(user);
        return refreshToken;
    }

    @Transactional
    public User verifyRefreshToken(String token) {
        User user = userRepository.findByRefreshToken(token)
                .orElseThrow(() -> new IllegalArgumentException("Сессия не найдена!"));

        if (!jwtUtil.validateJwtToken(token)) {
            user.setRefreshToken(null);
            userRepository.save(user);
            throw new IllegalArgumentException("Сессия истекла! Войдите снова");
        }

        return user;
    }

    @Transactional
    public void deleteRefreshToken(Integer userId) {
        userRepository.findById(userId).ifPresent(user -> {
            user.setRefreshToken(null);
            userRepository.save(user);
        });
    }
}