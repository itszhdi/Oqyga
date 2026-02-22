package com.oqyga.OqygaBackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
public class EventRequestDTO {
    private String eventName;
    private LocalDate eventDate;
    private LocalTime eventTime;

    @JsonProperty("event_place")
    private String event_place;

    private String description;
    private Integer peopleAmount;

    private Integer ageRestrictionId;
    private Integer categoryId;
    private Integer cityId;
    private Integer organisatorId;
    private List<TicketTypeDTO> ticketTypes;

}