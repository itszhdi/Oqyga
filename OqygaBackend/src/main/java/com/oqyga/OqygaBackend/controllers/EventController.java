package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.EventFilterRequest;
import com.oqyga.OqygaBackend.dto.EventResponse;
import com.oqyga.OqygaBackend.services.EventService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import com.oqyga.OqygaBackend.entities.User;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/events")
public class EventController {

    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping("/all")
    public ResponseEntity<List<EventResponse>> getAllEvents(
            EventFilterRequest filterRequest,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language) {
        List<EventResponse> events = eventService.getAllEvents(filterRequest, language);
        return ResponseEntity.ok(events);
    }

    @GetMapping("/{id}")
    public ResponseEntity<EventResponse> getEventById(
            @PathVariable Integer id,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language) {
        EventResponse event = eventService.getEventById(id, language);
        return ResponseEntity.ok(event);
    }

    @GetMapping("/my")
    @PreAuthorize("hasRole('ORGANISATOR')")
    public ResponseEntity<List<EventResponse>> getMyEvents(
            @AuthenticationPrincipal User userPrincipal,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language) {
        if (userPrincipal.getOrganisator() == null) {
            return ResponseEntity.badRequest().build();
        }
        Integer organisatorId = userPrincipal.getOrganisator().getOrganisatorId();
        List<EventResponse> events = eventService.getEventsByOrganisator(organisatorId, language);
        return ResponseEntity.ok(events);
    }
}