package com.oqyga.OqygaBackend.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "promocodes")
public class Promocode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "promocode_id")
    private Integer promocodeId;

    @Column(nullable = false, unique = true, length = 200)
    private String promocode;

    @Column(name = "price_charge")
    private Float priceCharge;

    public void setPriceCharge(Float priceCharge) {
        if (priceCharge != null) {
            this.priceCharge = Math.round(priceCharge * 100.0f) / 100.0f;
        } else {
            this.priceCharge = null;
        }
    }
    public Float getPriceCharge() {
        if (priceCharge == null) return null;
        return Math.round(priceCharge * 100.0f) / 100.0f;
    }
}