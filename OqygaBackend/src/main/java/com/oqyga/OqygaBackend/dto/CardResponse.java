package com.oqyga.OqygaBackend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CardResponse {
    private int id;
    private String lastFourDigits;
    private String brand;
    private String message;
}