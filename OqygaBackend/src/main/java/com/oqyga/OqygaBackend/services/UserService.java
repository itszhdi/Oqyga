package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.PasswordChangeRequest;
import com.oqyga.OqygaBackend.dto.ProfileUpdateRequest;
import com.oqyga.OqygaBackend.dto.ResetPasswordRequest;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import jakarta.annotation.PostConstruct;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final SmsService smsService;

    @Value("${file.upload-dir}")
    private String uploadDir; // ./uploads

    @Value("${file.upload-url-path}")
    private String uploadUrlPath; // /uploads/

    private Path rootStoragePath;       // ./uploads
    private Path userPhotoStoragePath;  // ./uploads/user_photos

    /**
     * Инициализация директорий при запуске приложения
     */
    @PostConstruct
    public void init() {
        log.info("Инициализация директорий для фото пользователей: {}", uploadDir);
        try {
            this.rootStoragePath = Paths.get(uploadDir).toAbsolutePath().normalize();

            this.userPhotoStoragePath = this.rootStoragePath.resolve("user_photos");

            Files.createDirectories(this.rootStoragePath);
            Files.createDirectories(this.userPhotoStoragePath);

            log.info("User photos directory initialized at: {}", this.userPhotoStoragePath);
        } catch (IOException e) {
            log.error("Не удалось создать директорию для загрузки фото пользователей: {}", e.getMessage(), e);
            throw new RuntimeException("Не удалось создать директорию для загрузки фото пользователей.", e);
        }
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.debug("Загрузка пользователя по имени: {}", username);
        return userRepository.findByUserName(username)
                .orElseThrow(() -> {
                    log.warn("User not found by username: {}", username);
                    return new UsernameNotFoundException("User not found: " + username);
                });
    }

    public Optional<User> getUserById(Integer userId) {
        log.debug("Получение пользователя по ID: {}", userId);
        Optional<User> user = userRepository.findById(userId);
        if (user.isPresent()) {
            log.debug("Пользователь найден: ID={}, имя={}", userId, user.get().getUsername());
        } else {
            log.debug("Пользователь не найден: ID={}", userId);
        }
        return user;
    }

    @Transactional
    public User updateProfile(Integer userId, ProfileUpdateRequest request) {
        log.info("Обновление профиля пользователя: ID={}", userId);

        User user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.error("Пользователь не найден для обновления профиля: ID={}", userId);
                    return new EntityNotFoundException("User not found with ID: " + userId);
                });

        log.debug("Пользователь найден для обновления: ID={}, имя={}", userId, user.getUsername());

        if (request.getUserName() != null && !request.getUserName().isBlank() && !request.getUserName().equals(user.getUsername())) {
            log.debug("Попытка изменить имя пользователя: старое={}, новое={}", user.getUsername(), request.getUserName());
            if (userRepository.existsByUserName(request.getUserName())) {
                log.warn("Имя пользователя {} уже существует", request.getUserName());
                throw new IllegalArgumentException("Пользователь с таким именем уже существует");
            }
            user.setUserName(request.getUserName());
            log.debug("Имя пользователя обновлено: новое={}", request.getUserName());
        }

        if (request.getPhoneNumber() != null && !request.getPhoneNumber().equals(user.getPhoneNumber())) {
            log.debug("Попытка изменить номер телефона: старый={}, новый={}", user.getPhoneNumber(), request.getPhoneNumber());
            if (userRepository.existsByPhoneNumber(request.getPhoneNumber())) {
                log.warn("Номер телефона {} уже зарегистрирован", request.getPhoneNumber());
                throw new IllegalArgumentException("Этот номер телефона уже зарегистрирован.");
            }
            user.setPhoneNumber(request.getPhoneNumber());
            log.debug("Номер телефона обновлен: новый={}", request.getPhoneNumber());
        }

        if (request.getEmail() != null && !request.getEmail().isBlank() && !request.getEmail().equals(user.getEmail())) {
            log.debug("Попытка изменить email: старый={}, новый={}", user.getEmail(), request.getEmail());
            if (userRepository.existsByEmail(request.getEmail())) {
                log.warn("Email {} уже зарегистрирован", request.getEmail());
                throw new IllegalArgumentException("Эта почта уже зарегистрирована.");
            }
            user.setEmail(request.getEmail());
            log.debug("Email обновлен: новый={}", request.getEmail());
        }

        User updatedUser = userRepository.save(user);
        log.info("Профиль пользователя успешно обновлен: ID={}, имя={}", updatedUser.getUserId(), updatedUser.getUsername());
        return updatedUser;
    }

    public void changePassword(Integer userId, PasswordChangeRequest request) {
        log.info("Смена пароля для пользователя: ID={}", userId);

        User user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.error("Пользователь не найден для смены пароля: ID={}", userId);
                    return new EntityNotFoundException("Пользователь с ID не найден: " + userId);
                });

        log.debug("Пользователь найден для смены пароля: ID={}, имя={}", userId, user.getUsername());

        if (!request.getNewPassword().equals(request.getConfirmNewPassword())) {
            log.warn("Пароли не совпадают при смене пароля для пользователя ID={}", userId);
            throw new IllegalArgumentException("Пароли не совпадают!");
        }

        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            log.warn("Неверный текущий пароль при попытке смены для пользователя ID={}", userId);
            throw new IllegalArgumentException("Неверный текущий пароль!");
        }

        String newHashedPassword = passwordEncoder.encode(request.getNewPassword());
        user.setPassword(newHashedPassword);
        userRepository.save(user);
        log.info("Password changed successfully for user ID {}", userId);
    }

    /**
     * Сохранение фото профиля
     */
    @Transactional
    public String saveUserPhoto(Integer userId, MultipartFile file) throws IOException {
        log.info("Сохранение фото профиля для пользователя: ID={}, размер файла={} bytes", userId, file.getSize());

        User user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.error("Пользователь не найден для сохранения фото: ID={}", userId);
                    return new EntityNotFoundException("User not found with ID: " + userId);
                });

        log.debug("Пользователь найден для сохранения фото: ID={}, имя={}", userId, user.getUsername());

        String originalFilename = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        log.debug("Оригинальное имя файла: {}", originalFilename);

        String fileExtension = "";
        int lastDotIndex = originalFilename.lastIndexOf(".");
        if (lastDotIndex > 0) {
            fileExtension = originalFilename.substring(lastDotIndex).toLowerCase();
        }

        if (!fileExtension.matches("\\.(jpg|jpeg|png|gif|webp)$")) {
            log.warn("Недопустимый формат файла: {} для пользователя ID={}", fileExtension, userId);
            throw new IllegalArgumentException("Недопустимый формат файла. Разрешены: jpg, jpeg, png, gif, webp");
        }

        log.debug("Формат файла прошел валидацию: {}", fileExtension);

        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        log.debug("Сгенерировано уникальное имя файла: {}", uniqueFileName);

        Path targetLocation = this.userPhotoStoragePath.resolve(uniqueFileName);

        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
        log.info("File saved to: {}", targetLocation);

        deleteOldUserPhoto(user.getUserPhoto());

        String photoUrl = uploadUrlPath + "user_photos/" + uniqueFileName;
        log.debug("Сформирован URL фото: {}", photoUrl);

        user.setUserPhoto(photoUrl);
        userRepository.save(user);

        log.info("Фото профиля успешно сохранено для пользователя: ID={}, URL={}", userId, photoUrl);
        return photoUrl;
    }

    /**
     * Удаление старого фото пользователя
     */
    private void deleteOldUserPhoto(String oldPhotoUrl) {
        if (oldPhotoUrl == null || oldPhotoUrl.isBlank()) {
            log.debug("Старое фото отсутствует, удаление не требуется");
            return;
        }

        log.debug("Попытка удаления старого фото: URL={}", oldPhotoUrl);
        try {
            String fileName = oldPhotoUrl.substring(oldPhotoUrl.lastIndexOf("/") + 1);

            Path oldFilePath = this.userPhotoStoragePath.resolve(fileName).normalize();

            if (Files.exists(oldFilePath)) {
                Files.delete(oldFilePath);
                log.info("Deleted old photo: {}", oldFilePath);
            } else {
                log.debug("Старое фото не найдено на диске: {}", oldFilePath);
            }
        } catch (Exception e) {
            log.warn("Failed to delete old photo: {}", oldPhotoUrl, e);
        }
    }

    @Transactional
    public void requestPasswordReset(String phoneNumber) {
        log.info("Запрос на сброс пароля для номера телефона: {}", phoneNumber);

        User user = userRepository.findByPhoneNumber(phoneNumber)
                .orElseThrow(() -> {
                    log.error("Пользователь не найден по номеру телефона: {}", phoneNumber);
                    return new EntityNotFoundException("Пользователь с таким номером телефона не найден.");
                });

        log.debug("Пользователь найден для сброса пароля: ID={}, имя={}", user.getUserId(), user.getUsername());

        String otp = String.format("%06d", new java.util.Random().nextInt(999999));
        log.debug("Сгенерирован OTP код для пользователя ID={}", user.getUserId());

        user.setOtp(otp);
        user.setOtpExpiryDate(LocalDateTime.now().plusMinutes(10));
        userRepository.save(user);
        log.debug("OTP код сохранен для пользователя ID={}, срок действия до: {}", user.getUserId(), user.getOtpExpiryDate());

        String messageBody = "Ваш код для сброса пароля в Oqiga: " + otp;

        String rawPhone = user.getPhoneNumber();
        String cleanPhone = rawPhone.replaceAll("\\D", "");

        if (cleanPhone.length() == 11 && cleanPhone.startsWith("8")) {
            cleanPhone = "7" + cleanPhone.substring(1);
        }

        smsService.sendWhatsAppMessage(cleanPhone, messageBody);
        log.info("OTP код отправлен на номер: {}", phoneNumber);
    }

    @Transactional
    public String validateResetOtp(String otp) {
        log.info("Валидация OTP кода для сброса пароля: {}", otp);

        User user = userRepository.findByOtp(otp)
                .orElseThrow(() -> {
                    log.warn("Неверный OTP код: {}", otp);
                    return new IllegalArgumentException("Неверный код подтверждения.");
                });

        log.debug("Пользователь найден по OTP: ID={}, имя={}", user.getUserId(), user.getUsername());

        if (user.getOtpExpiryDate() == null || user.getOtpExpiryDate().isBefore(LocalDateTime.now())) {
            log.warn("OTP код истек для пользователя ID={}", user.getUserId());
            user.setOtp(null);
            user.setOtpExpiryDate(null);
            userRepository.save(user);
            throw new IllegalArgumentException("Код подтверждения истек.");
        }

        String resetToken = UUID.randomUUID().toString();
        log.debug("Сгенерирован токен сброса пароля для пользователя ID={}", user.getUserId());

        user.setOtp(null);
        user.setOtpExpiryDate(null);
        user.setPasswordResetToken(resetToken);
        user.setPasswordResetTokenExpiryDate(LocalDateTime.now().plusMinutes(15));
        userRepository.save(user);

        log.info("OTP успешно валидирован, токен сброса создан для пользователя ID={}", user.getUserId());
        return resetToken;
    }

    @Transactional
    public void resetPassword(ResetPasswordRequest request) {
        log.info("Сброс пароля по токену");

        if (!request.getNewPassword().equals(request.getConfirmNewPassword())) {
            log.warn("Пароли не совпадают при сбросе пароля");
            throw new IllegalArgumentException("Пароли не совпадают!");
        }

        User user = userRepository.findByPasswordResetToken(request.getPasswordResetToken())
                .orElseThrow(() -> {
                    log.error("Неверный токен сброса пароля: {}", request.getPasswordResetToken());
                    return new IllegalArgumentException("Неверный токен сброса пароля.");
                });

        log.debug("Пользователь найден по токену сброса: ID={}, имя={}", user.getUserId(), user.getUsername());

        if (user.getPasswordResetTokenExpiryDate() == null || user.getPasswordResetTokenExpiryDate().isBefore(LocalDateTime.now())) {
            log.warn("Токен сброса пароля истек для пользователя ID={}", user.getUserId());
            user.setPasswordResetToken(null);
            user.setPasswordResetTokenExpiryDate(null);
            userRepository.save(user);
            throw new IllegalArgumentException("Токен сброса пароля истек.");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        user.setPasswordResetToken(null);
        user.setPasswordResetTokenExpiryDate(null);
        userRepository.save(user);
        log.info("Пароль для пользователя {} был успешно сброшен.", user.getUsername());
    }
}