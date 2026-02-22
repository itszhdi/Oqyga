package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.Card;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CardRepository extends JpaRepository<Card, Integer> {
    List<Card> findByUserUserId(int userId);

    boolean existsByUserUserIdAndFingerprint(int userId, String fingerprint);
}