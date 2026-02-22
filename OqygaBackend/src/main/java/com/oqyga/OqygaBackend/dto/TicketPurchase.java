package com.oqyga.OqygaBackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TicketPurchase {
    private Integer eventId;
    private Integer userId;
    private String promocode;

    private Integer savedCardId;
    private String newPaymentMethodId;
    private boolean saveNewCard;
    private List<PurchaseSeat> seats;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class PurchaseSeat {
        private Integer ticketTypeId;
        private Integer row;
        private Integer number;
    }
}