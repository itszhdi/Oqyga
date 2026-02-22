package com.oqyga.OqygaBackend.dto;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventFilterRequest {

    // Фильтр по минимальной цене билета
    private Double priceFrom;
    private Double priceTo;

    // Фильтр по связанным сущностям
    private Integer cityId;
    private Integer ageRestrictionId;
    private Integer categoryId;

    // Фильтр по дате и времени
    private LocalDate dateFrom;
    private LocalDate dateTo;
    private LocalTime timeFrom;
    private LocalTime timeTo;
}