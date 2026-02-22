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
public class QrCodePayload {
    private Integer userId;
    private Integer eventId;
    private String eventName;
    private String eventDate;
    private String eventTime;
    private String posterUrl;
    private String eventLocation;
    private Integer totalTickets;


    private List<TicketGroup> ticketGroups;

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class TicketGroup {
        private Float price;
        private Integer quantity;
        private String seatDetails;
    }
}