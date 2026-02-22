package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.JwtResponse;
import com.oqyga.OqygaBackend.dto.RegistrationRequest;
import com.oqyga.OqygaBackend.dto.SignInRequest;
import com.oqyga.OqygaBackend.entities.Role;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import com.oqyga.OqygaBackend.security.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;
    private final RefreshTokenService refreshTokenService;

    public JwtResponse signUp(RegistrationRequest request) {
        log.info("Начало регистрации пользователя: {}", request.getUserName());

        if (userRepository.existsByUserName(request.getUserName())) {
            log.warn("Пользователь с именем {} уже существует", request.getUserName());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Пользователь с таким именем уже существует");
        }
        if (userRepository.existsByPhoneNumber(request.getPhoneNumber())) {
            log.warn("Номер телефона {} уже зарегистрирован", request.getPhoneNumber());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Этот номер телефона уже зарегистрирован");
        }

        log.debug("Создание нового пользователя: {}", request.getUserName());
        User newUser = User.builder()
                .userName(request.getUserName())
                .password(passwordEncoder.encode(request.getPassword()))
                .phoneNumber(request.getPhoneNumber())
                .email(request.getEmail())
                .role(Role.USER)
                .build();
        userRepository.save(newUser);
        log.info("Пользователь успешно сохранен с ID: {}", newUser.getUserId());

        log.debug("Генерация токенов для пользователя c ID {}", newUser.getUserId());
        String accessToken = jwtUtil.generateToken(newUser.getUserId(), newUser.getAuthorities());
        String refreshToken = refreshTokenService.createRefreshToken(newUser.getUserId());

        log.info("Регистрация пользователя с ID {} успешно завершена", newUser.getUserId());
        return new JwtResponse(accessToken, refreshToken);
    }

    public JwtResponse signIn(SignInRequest request) {
        log.info("Попытка входа пользователя: {}", request.getUserName());

        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                request.getUserName(),
                request.getPassword()
        ));
        log.debug("Аутентификация пользователя {} успешна", request.getUserName());

        User user = userRepository.findByUserName(request.getUserName())
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден после аутентификации: " + request.getUserName()));
        log.debug("Пользователь найден с ID: {}", user.getUserId());

        log.debug("Генерация токенов для пользователя с ID {}", user.getUserId());
        String accessToken = jwtUtil.generateToken(user.getUserId(), user.getAuthorities());
        String refreshToken = refreshTokenService.createRefreshToken(user.getUserId());

        log.info("Вход пользователя с ID {} успешно выполнен", user.getUserId());
        return new JwtResponse(accessToken, refreshToken);
    }
}