package com.oqyga.OqygaBackend.dto;

import lombok.Data;

@Data
public class CardRequest {
    private String paymentMethodId;
    private int userId;
}