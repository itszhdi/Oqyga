package com.oqyga.OqygaBackend.repositories;
import com.oqyga.OqygaBackend.entities.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import com.oqyga.OqygaBackend.entities.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findByUserName(String userName);
    Optional<User> findByEmail(String email);
    Optional<User> findByPhoneNumber(String phoneNumber);
    Optional<User> findByOtp(String otp);
    Optional<User> findByRefreshToken(String token);
    Optional<User> findByPasswordResetToken(String token);

    boolean existsByUserName(String useName);
    boolean existsByPhoneNumber(String phoneNumber);
    boolean existsByEmail(String email);

    List<User> findByRole(Role role);
}