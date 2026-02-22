package com.oqyga.OqygaBackend.dto;

import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class TicketFilterRequest {
    private String status;
    private Integer cityId;
    private Integer categoryId;
    private LocalDate dateFrom;
    private LocalDate dateTo;
    private LocalTime timeFrom;
    private LocalTime timeTo;
}