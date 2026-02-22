package com.oqyga.OqygaBackend.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AgeRestriction {
    private Integer ageId;
    private String ageCategory;
}