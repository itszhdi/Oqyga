package com.oqyga.OqygaBackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PurchasedTicketDTO {
    private Integer ticketId;
    private Float price;
    private Integer quantity;
    private String seatDetails;
    private Integer userId;
    private Integer eventId;
}