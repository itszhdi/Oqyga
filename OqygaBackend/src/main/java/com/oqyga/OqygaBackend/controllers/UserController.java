package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.PasswordChangeRequest;
import com.oqyga.OqygaBackend.dto.ProfileUpdateRequest;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.services.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/profile")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/me")
    public ResponseEntity<User> getCurrentUserProfile(@AuthenticationPrincipal User user) {
        Integer userId = user.getUserId();

        return userService.getUserById(userId)
                .map(ResponseEntity::ok)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User profile not found."));
    }

    @PutMapping("/update")
    public ResponseEntity<User> updateProfile(@AuthenticationPrincipal User user,
                                              @Valid @RequestBody ProfileUpdateRequest request) {
        Integer userId = user.getUserId();
        User updatedUser = userService.updateProfile(userId, request);
        return ResponseEntity.ok(updatedUser);
    }

    @PostMapping("/change-password")
    public ResponseEntity<Void> changePassword(@AuthenticationPrincipal User user,
                                               @Valid @RequestBody PasswordChangeRequest request) {
        Integer userId = user.getUserId();
        userService.changePassword(userId, request);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/upload-photo")
    public ResponseEntity<Map<String, String>> uploadProfilePhoto(
            @AuthenticationPrincipal User user,
            @RequestParam("file") MultipartFile file) {
        try {
            String newPhotoUrl = userService.saveUserPhoto(user.getUserId(), file);
            return ResponseEntity.ok(Map.of("userPhoto", newPhotoUrl));

        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Ошибка при сохранении файла.");
        }
    }
}