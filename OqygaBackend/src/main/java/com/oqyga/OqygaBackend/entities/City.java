package com.oqyga.OqygaBackend.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "cities")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class City {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cityId;

    // --- Name ---
    @Column(name = "city_name", nullable = false, unique = true, length = 100)
    private String cityName;

    @Column(name = "city_name_en", length = 100)
    private String cityNameEn;

    @Column(name = "city_name_kk", length = 100)
    private String cityNameKk;
}