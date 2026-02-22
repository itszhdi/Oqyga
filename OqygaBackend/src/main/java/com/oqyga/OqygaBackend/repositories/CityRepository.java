package com.oqyga.OqygaBackend.repositories;

import com.oqyga.OqygaBackend.entities.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CityRepository extends JpaRepository<City, Integer> {
}