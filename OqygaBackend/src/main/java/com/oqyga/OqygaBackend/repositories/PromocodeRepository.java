package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.Promocode;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface PromocodeRepository extends JpaRepository<Promocode, Integer> {
    Optional<Promocode> findByPromocode(String promocode);
}