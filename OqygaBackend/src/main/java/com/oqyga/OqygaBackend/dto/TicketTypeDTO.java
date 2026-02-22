package com.oqyga.OqygaBackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TicketTypeDTO {
    private Integer id;
    private String description;
    private Float price;
    private Integer quantity;
}