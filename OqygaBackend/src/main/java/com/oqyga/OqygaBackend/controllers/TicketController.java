package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.*;
import com.oqyga.OqygaBackend.entities.Ticket;
import com.oqyga.OqygaBackend.entities.User;
import com.oqyga.OqygaBackend.services.QrCodeService;
import com.oqyga.OqygaBackend.services.TicketService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import java.util.List;

@RestController
@RequestMapping("/api/v1/tickets")
@RequiredArgsConstructor
public class TicketController {

    private final TicketService ticketService;
    private final QrCodeService qrCodeService;

    @GetMapping("/promocode/validate")
    public ResponseEntity<Float> validatePromocode(@RequestParam String code) {
        try {
            float discount = ticketService.validatePromocode(code);
            return ResponseEntity.ok(discount);
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping("/purchase")
    public ResponseEntity<PurchasedTicketDTO> purchaseTickets(@RequestBody TicketPurchase purchase) {
        if (purchase.getSeats() == null || purchase.getSeats().isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        try {
            // Теперь вызываем метод, который возвращает ОДИН DTO
            PurchasedTicketDTO purchasedTicket = ticketService.purchaseTickets(purchase);
            // Возвращаем DTO, завернутый в ResponseEntity
            return ResponseEntity.status(HttpStatus.CREATED).body(purchasedTicket);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error during ticket purchase", e);
        }
    }

    @GetMapping("/details")
    public ResponseEntity<QrCodePayload> getTicketDetails(
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) Integer eventId,
            @RequestParam(required = false) Integer ticketId,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language) {

        try {
            QrCodePayload details;
            if (ticketId != null) {

                details = qrCodeService.getTicketDetailsByTicketId(ticketId, language);
            } else if (userId != null && eventId != null) {

                details = qrCodeService.getTicketDetails(userId, eventId, language);
            } else {
                return ResponseEntity.badRequest().build();
            }
            return ResponseEntity.ok(details);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @GetMapping(value = "/qr-code", produces = MediaType.IMAGE_PNG_VALUE)
    public ResponseEntity<byte[]> getTicketQrCode(
            @RequestParam(required = false) Integer userId,
            @RequestParam(required = false) Integer eventId,
            @RequestParam(required = false) Integer ticketId,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language) {

        try {
            byte[] qrCodeBytes;
            if (ticketId != null) {
                qrCodeBytes = qrCodeService.generateQrCodeForTicketId(ticketId, language);
            } else if (userId != null && eventId != null) {
                // Исправлено: добавлен параметр language
                qrCodeBytes = qrCodeService.generateQrCodeForUserEvent(userId, eventId, language);
            } else {
                return ResponseEntity.badRequest().build();
            }
            return ResponseEntity.ok(qrCodeBytes);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to generate QR code", e);
        }
    }

    @GetMapping("/my-tickets")
    public ResponseEntity<List<MyTicketResponse>> getMyTickets(
            @AuthenticationPrincipal User userPrincipal,
            TicketFilterRequest filterRequest,
            @RequestHeader(value = "Accept-Language", defaultValue = "ru") String language
    ) {
        if (userPrincipal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Integer userId = userPrincipal.getUserId();
        List<MyTicketResponse> tickets = ticketService.getTicketsForUser(userId, filterRequest, language);
        return ResponseEntity.ok(tickets);
    }
}