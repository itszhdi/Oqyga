package com.oqyga.OqygaBackend.dto;

import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.Ticket;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyTicketResponse {

    private Integer ticketId;
    private String eventName;
    private String eventPlace;
    private String eventDate;
    private String eventPoster;
    private String status;

    public static MyTicketResponse fromEntity(Ticket ticket) {
        Event event = ticket.getEvent();

        String ticketStatus = event.getEventDate().isBefore(LocalDate.now())
                ? "Неактивен"
                : "Активен";

        return MyTicketResponse.builder()
                .ticketId(ticket.getTicketId())
                .eventName(event.getEventName())
                .eventPlace(event.getEvent_place())
                .eventDate(event.getEventDate().toString())
                .eventPoster(event.getPoster())
                .status(ticketStatus)
                .build();
    }
}