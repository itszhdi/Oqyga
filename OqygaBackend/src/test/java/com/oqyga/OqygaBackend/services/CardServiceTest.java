package com.oqyga.OqygaBackend.services;

import com.oqyga.OqygaBackend.dto.CardRequest;
import com.oqyga.OqygaBackend.dto.CardResponse;
import com.oqyga.OqygaBackend.entities.Card;
import com.oqyga.OqygaBackend.repositories.CardRepository;
import com.oqyga.OqygaBackend.repositories.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CardServiceTest {

    @Mock
    private CardRepository cardRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private CardService cardService;

    @BeforeEach
    void setUp() {
        // Внедряем API ключ через рефлексию, так как он помечен @Value
        ReflectionTestUtils.setField(cardService, "stripeApiKey", "sk_test_12345");
        cardService.init(); // Инициализируем Stripe
    }

    @Test
    void getUserCards_ShouldReturnListOfCardResponses() {
        // Arrange
        int userId = 1;
        Card card = Card.builder()
                .token_id(100)
                .last_four_digits("4242")
                .build();

        when(cardRepository.findByUserUserId(userId)).thenReturn(List.of(card));

        // Act
        List<CardResponse> responses = cardService.getUserCards(userId);

        // Assert
        assertNotNull(responses);
        assertEquals(1, responses.size());
        assertEquals("4242", responses.get(0).getLastFourDigits());
        assertEquals(100, responses.get(0).getId());
        verify(cardRepository, times(1)).findByUserUserId(userId);
    }

    @Test
    void saveCard_UserNotFound_ShouldThrowException() {
        // Arrange
        CardRequest request = new CardRequest();
        request.setUserId(99);

        when(userRepository.findById(99)).thenReturn(Optional.empty());

        // Act & Assert
        RuntimeException exception = assertThrows(RuntimeException.class, () -> cardService.saveCard(request));
        assertEquals("User not found", exception.getMessage());
    }
}