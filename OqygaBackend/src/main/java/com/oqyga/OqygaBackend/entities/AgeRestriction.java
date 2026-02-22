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
@Table(name = "age_restrictions")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class AgeRestriction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ageId;

    @Column(name = "age_category", nullable = false, unique = true, length = 30)
    private String ageCategory;
}