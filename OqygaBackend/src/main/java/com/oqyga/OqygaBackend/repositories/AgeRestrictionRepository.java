package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.AgeRestriction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AgeRestrictionRepository extends JpaRepository<AgeRestriction, Integer> {
}