package com.oqyga.OqygaBackend.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int eventId;

    // --- Name ---
    @Column(name = "event_name", nullable = false, length = 200)
    private String eventName;

    @Column(name = "event_name_en", length = 200)
    private String eventNameEn;

    @Column(name = "event_name_kk", length = 200)
    private String eventNameKk;

    @Column(name = "event_date")
    private LocalDate eventDate;

    // --- Place ---
    @Column(name = "event_place", length = 200)
    private String event_place;

    @Column(name = "event_place_en", length = 200)
    private String eventPlaceEn;

    @Column(name = "event_place_kk", length = 200)
    private String eventPlaceKk;

    @Column(name = "event_time")
    private LocalTime eventTime;

    // --- Description ---
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "description_en", columnDefinition = "TEXT")
    private String descriptionEn;

    @Column(name = "description_kk", columnDefinition = "TEXT")
    private String descriptionKk;

    @Column(columnDefinition = "TEXT")
    private String poster;

    @Column(name = "people_amount")
    private Integer peopleAmount;


    @OneToMany(mappedBy = "event", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Ticket> tickets;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "age_id")
    private AgeRestriction ageRestriction;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    private City city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organisator_id")
    private Organisator organisator;
}