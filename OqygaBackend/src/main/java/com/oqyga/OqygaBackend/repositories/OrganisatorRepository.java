package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.Organisator;
import com.oqyga.OqygaBackend.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrganisatorRepository extends JpaRepository<Organisator, Integer> {
    boolean existsByUser(User user);
}