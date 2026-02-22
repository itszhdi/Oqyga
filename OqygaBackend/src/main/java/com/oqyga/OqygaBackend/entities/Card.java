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
@Table(name = "cards")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Card {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int token_id;

    @Column(nullable = false, unique = true)
    private String payment_token;

    @Column
    private String last_four_digits;

    @Column
    private String brand;

    @Column
    private String fingerprint;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
}