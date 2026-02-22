package com.oqyga.OqygaBackend.controllers;

import com.oqyga.OqygaBackend.dto.CardRequest;
import com.oqyga.OqygaBackend.dto.CardResponse;
import com.oqyga.OqygaBackend.entities.Card;
import com.oqyga.OqygaBackend.services.CardService;
import com.stripe.exception.StripeException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/cards")
public class CardController {

    private final CardService cardService;

    public CardController(CardService cardService) {
        this.cardService = cardService;
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<CardResponse>> getUserCards(@PathVariable int userId) {
        try {
            List<CardResponse> cards = cardService.getUserCards(userId);
            return ResponseEntity.ok(cards);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/add")
    public ResponseEntity<?> addCard(@RequestBody CardRequest request) {
        try {
            Card savedCard = cardService.saveCard(request);
            CardResponse response = CardResponse.builder()
                    .id(savedCard.getToken_id())
                    .lastFourDigits(savedCard.getLast_four_digits())
                    .brand(savedCard.getBrand())
                    .message("Карта успешно сохранена")
                    .build();

            return ResponseEntity.ok(response);

        } catch (StripeException e) {
            return ResponseEntity.badRequest().body("Ошибка Stripe: " + e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Ошибка: " + e.getMessage());
        }
    }

    @DeleteMapping("/delete/{cardId}")
    public ResponseEntity<?> deleteCard(
            @PathVariable int cardId,
            @RequestParam int userId
    ) {
        try {
            cardService.deleteCard(cardId, userId);
            return ResponseEntity.ok().body("Карта успешно удалена");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Ошибка удаления: " + e.getMessage());
        }
    }
}