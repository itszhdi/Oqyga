package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.AgeRestriction;
import com.oqyga.OqygaBackend.dto.Category;
import com.oqyga.OqygaBackend.dto.City;
import com.oqyga.OqygaBackend.repositories.AgeRestrictionRepository;
import com.oqyga.OqygaBackend.repositories.CategoryRepository;
import com.oqyga.OqygaBackend.repositories.CityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/filter")
public class FilterController {

    private final CityRepository cityRepository;
    private final CategoryRepository categoryRepository;
    private final AgeRestrictionRepository ageRestrictionRepository;

    @Autowired
    public FilterController(CityRepository cityRepository, CategoryRepository categoryRepository, AgeRestrictionRepository ageRestrictionRepository) {
        this.cityRepository = cityRepository;
        this.categoryRepository = categoryRepository;
        this.ageRestrictionRepository = ageRestrictionRepository;
    }

    private String getLanguageCode(String header) {
        if (header == null || header.isEmpty()) return "ru";
        if (header.contains("kk")) return "kk";
        if (header.contains("en")) return "en";
        return "ru";
    }

    @GetMapping("/cities")
    public ResponseEntity<List<City>> getAllCities(
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String languageHeader) {

        String lang = getLanguageCode(languageHeader);

        List<City> cities = cityRepository.findAll().stream()
                .map(city -> {
                    String name;
                    switch (lang) {
                        case "kk":
                            name = city.getCityNameKk() != null ? city.getCityNameKk() : city.getCityName();
                            break;
                        case "en":
                            name = city.getCityNameEn() != null ? city.getCityNameEn() : city.getCityName();
                            break;
                        default:
                            name = city.getCityName();
                    }
                    return new City(city.getCityId(), name);
                })
                .collect(Collectors.toList());
        return ResponseEntity.ok(cities);
    }

    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getAllCategories(
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String languageHeader) {

        String lang = getLanguageCode(languageHeader);

        List<Category> categories = categoryRepository.findAll().stream()
                .map(category -> {
                    String name;
                    switch (lang) {
                        case "kk":
                            name = category.getCategoryNameKk() != null ? category.getCategoryNameKk() : category.getCategoryName();
                            break;
                        case "en":
                            name = category.getCategoryNameEn() != null ? category.getCategoryNameEn() : category.getCategoryName();
                            break;
                        default:
                            name = category.getCategoryName();
                    }
                    return new Category(category.getCategoryId(), name);
                })
                .collect(Collectors.toList());
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/age-restrictions")
    public ResponseEntity<List<AgeRestriction>> getAllAgeRestrictions(
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String languageHeader) {

        List<AgeRestriction> ageRestrictions = ageRestrictionRepository.findAll().stream()
                .map(age -> new AgeRestriction(age.getAgeId(), age.getAgeCategory()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(ageRestrictions);
    }
}