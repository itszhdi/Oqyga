package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.JwtResponse;
import com.oqyga.OqygaBackend.dto.RefreshTokenRequest;
import com.oqyga.OqygaBackend.dto.RegistrationRequest;
import com.oqyga.OqygaBackend.dto.SignInRequest;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.security.JwtUtil;
import com.oqyga.OqygaBackend.services.AuthenticationService;
import com.oqyga.OqygaBackend.services.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationService authenticationService;
    private final RefreshTokenService refreshTokenService;
    private final JwtUtil jwtUtil;

    @PostMapping("/sign-up")
    public ResponseEntity<JwtResponse> registerUser(@Valid @RequestBody RegistrationRequest request) {
        JwtResponse response = authenticationService.signUp(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/sign-in")
    public ResponseEntity<JwtResponse> authenticateUser(@RequestBody SignInRequest request) {
        JwtResponse response = authenticationService.signIn(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/refresh")
    public ResponseEntity<JwtResponse> refreshToken(@RequestBody RefreshTokenRequest request) {
        try {
            User user = refreshTokenService.verifyRefreshToken(request.getRefreshToken());
            String newAccessToken = jwtUtil.generateToken(user.getUserId(), user.getAuthorities());

            String newRefreshToken = refreshTokenService.createRefreshToken(user.getUserId());

            return ResponseEntity.ok(new JwtResponse(newAccessToken, newRefreshToken));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}