package com.oqyga.OqygaBackend.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EventResponse {

    private int eventId;

    // Русская версия (основная)
    private String eventName;
    private String description;
    private String eventPlace;

    // Английская версия
    private String eventNameEn;
    private String descriptionEn;
    private String eventPlaceEn;

    // Казахская версия
    private String eventNameKk;
    private String descriptionKk;
    private String eventPlaceKk;

    private LocalDate eventDate;
    private LocalTime eventTime;
    private String poster;
    private Integer peopleAmount;
    private boolean soldOut;

    private AgeRestriction ageRestriction;
    private Category category;
    private City city;
    private Float minPrice;
    private Float maxPrice;
    private List<Float> allPrices;

    private List<TicketTypeDTO> ticketTypes;
}