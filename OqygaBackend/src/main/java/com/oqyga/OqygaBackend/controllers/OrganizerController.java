package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.EventRequestDTO;
import com.oqyga.OqygaBackend.entities.Event;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.services.OrganizerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/v1/organizer/events")
@RequiredArgsConstructor
public class OrganizerController {

    private final OrganizerService organizerService;

    @PostMapping(consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    @PreAuthorize("hasRole('ORGANISATOR')")
    public ResponseEntity<Event> addEvent(
            @AuthenticationPrincipal User userPrincipal,
            @RequestPart("event") EventRequestDTO eventDTO,
            @RequestPart("poster") MultipartFile posterFile) {
        try {
            if (userPrincipal.getOrganisator() == null) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }

            eventDTO.setOrganisatorId(userPrincipal.getOrganisator().getOrganisatorId());

            Event newEvent = organizerService.addEvent(eventDTO, posterFile);
            return new ResponseEntity<>(newEvent, HttpStatus.CREATED);
        } catch (IOException e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping(value = "/{eventId}", consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    @PreAuthorize("hasRole('ORGANISATOR')")
    public ResponseEntity<Event> updateEvent(
            @AuthenticationPrincipal User userPrincipal,
            @PathVariable Integer eventId,
            @RequestPart("event") EventRequestDTO eventDTO,
            @RequestPart(value = "poster", required = false) MultipartFile posterFile) {
        try {
            if (userPrincipal.getOrganisator() == null) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
            eventDTO.setOrganisatorId(userPrincipal.getOrganisator().getOrganisatorId());

            Event updatedEvent = organizerService.updateEvent(eventId, eventDTO, posterFile);
            return ResponseEntity.ok(updatedEvent);
        } catch (IOException e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/{eventId}")
    @PreAuthorize("hasRole('ORGANISATOR')")
    public ResponseEntity<Void> deleteEvent(@PathVariable Integer eventId) {
        try {
            organizerService.deleteEvent(eventId);
            return ResponseEntity.noContent().build();
        } catch (IOException e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/places")
    @PreAuthorize("hasRole('ORGANISATOR')")
    public ResponseEntity<List<String>> getPreviousVenues(@AuthenticationPrincipal User userPrincipal) {
        if (userPrincipal.getOrganisator() == null) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        Integer orgId = userPrincipal.getOrganisator().getOrganisatorId();
        List<String> places = organizerService.getPreviousVenues(orgId);
        return ResponseEntity.ok(places);
    }
}